(function() {
  var run;

  module.exports = run = function(grunt) {
    var helpers, local, remote;
    helpers = require('./helpers')(grunt);
    local = function(platform, device, fn) {
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
    remote = function(platform, device, fn) {
      var cmd;
      cmd = "phonegap remote run " + platform + " " + (helpers.setVerbosity());
      return helpers.exec(cmd, fn);
    };
    return {
      run: function(platform, device, fn) {
        if (helpers.isRemote()) {
          return remote(platform, device, fn);
        } else {
          return local(platform, device, fn);
        }
      }
    };
  };

}).call(this);
