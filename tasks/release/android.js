(function() {
  var antPropertiesFile, antRelease, copyApk, createReleasesPath, grunt, helpers, path, platformPath, setAntProperties;

  grunt = require('grunt');

  path = require('path');

  helpers = require('../helpers');

  copyApk = function(fn) {
    var dest, phonegapPath, releaseName, src, srcDir;
    phonegapPath = helpers.config('path');
    srcDir = path.join(phonegapPath, 'platforms', 'android', 'bin');
    releaseName = helpers.config('releaseName');
    src = grunt.file.expand("" + srcDir + "/*-release.apk")[0];
    dest = path.join(helpers.config('releases'), 'android', "" + releaseName + ".apk");
    grunt.file.copy(src, dest, {
      encoding: null
    });
    if (fn) {
      return fn();
    }
  };

  setAntProperties = function(includePasswords) {
    var key, keyStorePath, properties;
    key = helpers.config('key');
    keyStorePath = path.relative(platformPath('android'), key.store);
    properties = [];
    properties.push("key.store=" + keyStorePath);
    properties.push("key.store=" + (path.sep === '\\' ? keyStorePath.replace(/\\/g, '\\\\') : keyStorePath));
    properties.push("key.alias=" + key.alias);
    if (includePasswords) {
      properties.push("key.store.password=" + (key.storePassword()));
      properties.push("key.alias.password=" + (key.aliasPassword()));
    }
    return grunt.file.write(antPropertiesFile(), properties.join("\n"));
  };

  antRelease = function(fn) {
    var cmd, cwd, keyStore, phonegapPath;
    phonegapPath = helpers.config('path');
    keyStore = helpers.config('key.store');
    helpers.ensureExists(keyStore, 'You need to create a keystore file to generate a signed release (see http://developer.android.com/tools/publishing/app-signing.html)');
    cmd = 'ant release';
    cwd = path.join(phonegapPath, 'platforms', 'android');
    return helpers.exec(cmd, fn, cwd);
  };

  platformPath = function(platform) {
    return path.join(helpers.config('path'), 'platforms', 'android');
  };

  antPropertiesFile = function() {
    return path.join(platformPath('android'), 'ant.properties');
  };

  createReleasesPath = function(platform) {
    var releasesPath;
    releasesPath = helpers.config('releases');
    return grunt.file.mkdir(path.join(releasesPath, platform));
  };

  module.exports = {
    release: function(fn) {
      grunt.log.writeln('Creating release for \'android\' platform');
      createReleasesPath('android');
      setAntProperties(true);
      return antRelease(function() {
        return copyApk(function() {
          setAntProperties(false);
          return fn();
        });
      });
    }
  };

}).call(this);
