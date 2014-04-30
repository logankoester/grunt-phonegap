(function() {
  var android, path;

  path = require('path');

  module.exports = android = function(grunt) {
    var antDebug, copyApk, createDebugPath, helpers;
    helpers = require('../helpers')(grunt);
    copyApk = function(fn) {
      var dest, phonegapPath, releaseName, src, srcDir;
      phonegapPath = helpers.config('path');
      srcDir = path.join(phonegapPath, 'platforms', 'android', 'bin');
      releaseName = helpers.config('releaseName');
      src = grunt.file.expand("" + srcDir + "/*-debug.apk")[0];
      dest = path.join(helpers.config('releases'), 'debug', 'android', "" + releaseName + ".apk");
      grunt.file.copy(src, dest, {
        encoding: null
      });
      if (fn) {
        return fn();
      }
    };
    antDebug = function(fn) {
      var cmd, cwd, phonegapPath;
      phonegapPath = helpers.config('path');
      cmd = 'ant debug';
      cwd = path.join(phonegapPath, 'platforms', 'android');
      return helpers.exec(cmd, fn, cwd);
    };
    createDebugPath = function(platform) {
      var releasesPath;
      releasesPath = helpers.config('releases');
      return grunt.file.mkdir(path.join(releasesPath, 'debug', platform));
    };
    return {
      debug: function(fn) {
        grunt.log.writeln('Creating debug build for \'android\' platform');
        createDebugPath('android');
        return antDebug(function() {
          return copyApk(function() {
            return fn();
          });
        });
      }
    };
  };

}).call(this);
