(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  module.exports.Run = (function() {
    Run.prototype.exec = require('child_process').exec;

    function Run(grunt, config) {
      this.grunt = grunt;
      this.config = config;
      this.run = __bind(this.run, this);
    }

    Run.prototype.run = function(platform, device, fn) {
      var childProcess, cmd,
        _this = this;
      cmd = "phonegap local run " + platform + " " + (this._setVerbosity());
      if (device) {
        cmd += " --device " + device;
      }
      childProcess = this.exec(cmd, {
        cwd: this.config.path,
        maxBuffer: this.config.maxBuffer * 1024
      }, function(err, stdout, stderr) {
        if (err) {
          _this.grunt.fatal(err);
        }
        if (fn) {
          return fn(err);
        }
      });
      childProcess.stdout.on('data', function(out) {
        return _this.grunt.log.write(out);
      });
      return childProcess.stderr.on('data', function(err) {
        return _this.grunt.fatal(err);
      });
    };

    Run.prototype._setVerbosity = function() {
      if (this.config.verbose) {
        return '-V';
      } else {
        return '';
      }
    };

    return Run;

  })();

}).call(this);
