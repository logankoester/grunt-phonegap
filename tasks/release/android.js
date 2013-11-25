(function() {
  var ReleaseAndroid, exports;

  module.exports = exports = ReleaseAndroid = (function() {
    ReleaseAndroid.prototype.cp = require('cp');

    ReleaseAndroid.prototype.path = require('path');

    ReleaseAndroid.prototype.exec = require('child_process').exec;

    function ReleaseAndroid(grunt, config) {
      this.grunt = grunt;
      this.config = config;
      this.file = this.grunt.file;
      this.log = this.grunt.log;
      this.warn = this.grunt.warn;
      this.fatal = this.grunt.fatal;
    }

    ReleaseAndroid.prototype.release = function(fn) {
      var _this = this;
      this.setAntProperties(true);
      return this.antRelease(function() {
        return _this.copyApk(function() {
          _this.setAntProperties(false);
          return fn();
        });
      });
    };

    ReleaseAndroid.prototype.copyApk = function(fn) {
      var dest, src, srcDir;
      srcDir = this.path.join(this.config.path, 'platforms', 'android', 'bin');
      src = this.file.expand("" + srcDir + "/*-release.apk")[0];
      dest = this.path.join(this.config.releases, 'android', "" + (this.config.releaseName()) + ".apk");
      this.file.copy(src, dest, {
        encoding: null
      });
      if (fn) {
        return fn();
      }
    };

    ReleaseAndroid.prototype.setAntProperties = function(includePasswords) {
      var keyStorePath, properties;
      keyStorePath = this.path.relative(this._platformPath('android'), this.config.key.store);
      properties = [];
      properties.push("key.store=" + (this.path.sep === '\\' ? keyStorePath.replace(/\\/g, '\\\\') : keyStorePath)); // Path must be escaped in the file as well
      properties.push("key.alias=" + this.config.key.alias);
      if (includePasswords) {
        properties.push("key.store.password=" + (this.config.key.storePassword()));
        properties.push("key.alias.password=" + (this.config.key.aliasPassword()));
      }
      return this.file.write(this._antPropertiesFile(), properties.join("\n"));
    };

    ReleaseAndroid.prototype.antRelease = function(fn) {
      var childProcess, cmd, cwd,
        _this = this;
      this._ensureExists(this.config.key.store, 'You need to create a keystore file to generate a signed release (see http://developer.android.com/tools/publishing/app-signing.html)');
      cmd = 'ant release';
      cwd = this.path.join(this.config.path, 'platforms', 'android');
      childProcess = this.exec(cmd, {
        cwd: cwd
      }, function(err, stdout, stderr) {
        if (err) {
          _this.fatal(err);
        }
        if (fn) {
          return fn(err);
        }
      });
      childProcess.stdout.on('data', function(out) {
        return _this.log.write(out);
      });
      return childProcess.stderr.on('data', function(err) {
        return _this.fatal(err);
      });
    };

    ReleaseAndroid.prototype._platformPath = function(platform) {
      return this.path.join(this.config.path, 'platforms', 'android');
    };

    ReleaseAndroid.prototype._antPropertiesFile = function() {
      return this.path.join(this._platformPath('android'), 'ant.properties');
    };

    ReleaseAndroid.prototype._ensureExists = function(path, failMessage) {
      failMessage || (failMessage = "\"" + path + "\" does not exist.");
      if (this.grunt.file.exists(this.config.key.store)) {
        return true;
      } else {
        this.fatal(failMessage);
        return false;
      }
    };

    return ReleaseAndroid;

  })();

}).call(this);
