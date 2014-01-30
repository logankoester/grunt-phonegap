(function() {
  var helpers;

  helpers = require('./helpers');

  module.exports.Run = (function() {
    function Run() {}

    Run.prototype.run = function(platform, device, fn) {
      if (helpers.isRemote()) {
        return this._runRemote(platform, device, fn);
      } else {
        return this._runLocal(platform, device, fn);
      }
    };

    Run.prototype._runLocal = function(platform, device, fn) {
      var cmd;
      cmd = "phonegap local run " + platform + " " + (helpers.setVerbosity());
      if (device) {
        if (device === 'emulator') {
          cmd += ' --emulator';
        } else {
          cmd += " --device " + device;
        }
      }
      return helpers.exec(cmd, fn);
    };

    Run.prototype._runRemote = function(platform, device, fn) {
      var cmd;
      cmd = "phonegap remote run " + platform + " " + (helpers.setVerbosity());
      return helpers.exec(cmd, fn);
    };

    return Run;

  })();

}).call(this);
