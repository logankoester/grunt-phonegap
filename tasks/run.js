(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  module.exports.Run = (function() {
    Run.prototype.exec = require('child_process').exec;

    function Run(grunt, config) {
      this.grunt = grunt;
      this.config = config;
      this._childExec = __bind(this._childExec, this);
      this._runRemote = __bind(this._runRemote, this);
      this._runLocal = __bind(this._runLocal, this);
      this.run = __bind(this.run, this);
    }

    Run.prototype.run = function(platform, device, fn) {
      if (this._isRemote()) {
        return this._runRemote(platform, fn);
      } else {
        return this._runLocal(platform, fn);
      }
    };

    Run.prototype._runLocal = function(platform, fn) {
      return this._childExec("phonegap local run " + platform + " " + (this._setVerbosity()), fn);
    };

    Run.prototype._runRemote = function(platform, fn) {
      return this._childExec("phonegap remote run " + platform + " " + (this._setVerbosity()), fn);
    };

    Run.prototype._childExec = function(cmd, fn) {
      var childProcess,
        _this = this;
      childProcess = this.exec(cmd, {
        cwd: this.config.path,
        maxBuffer: this.config.maxBuffer * 1024
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

    Run.prototype._setVerbosity = function() {
      if (this.config.verbose) {
        return '-V';
      } else {
        return '';
      }
    };

    Run.prototype._isRemote = function(platform) {
      var _ref, _ref1;
      if ((((_ref = this.config.remote) != null ? _ref.platforms : void 0) != null) && __indexOf.call((_ref1 = this.config.remote) != null ? _ref1.platforms : void 0, platform) >= 0) {
        this.grunt.config.requires('phonegap.remote.username');
        this.grunt.config.requires('phonegap.remote.password');
        return true;
      } else {
        return false;
      }
    };

    return Run;

  })();

}).call(this);
