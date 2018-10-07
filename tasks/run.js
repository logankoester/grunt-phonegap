(function() {
  var run;

  module.exports = run = function(grunt) {
    var helpers, local, remote;
    helpers = require('./helpers')(grunt);
    
    // Use a local SDK to build and install your application
    // for a specific platform.

    // @param [String] platform The platform to build and run on
    // @param [String] device One of `$ adb devices` or "emulator"
    // @param [Function] fn Optional callback to run when the child process terminates.
    local = function(platform, device, fn) {
      var cmd;
      cmd = `phonegap run ${platform} ${helpers.setVerbosity()}`;
      if (device) {
        if (device === 'emulator') {
          cmd += ' --emulator';
        } else {
          cmd += ` --device ${device}`;
        }
      }
      return helpers.exec(cmd, fn);
    };
    // Use the Phonegap Build service to remotely build and install your application
    // for a specific platform.

    // @param [String] platform The platform to build and run on
    // @param [String] device Ignored
    // @param [Function] fn Optional callback to run when the child process terminates.
    remote = function(platform, device, fn) {
      var cmd;
      cmd = `phonegap remote run ${platform} ${helpers.setVerbosity()}`;
      return helpers.exec(cmd, fn);
    };
    return {
      run: function(platform, device, fn) {
        if (helpers.isRemote(platform)) {
          return remote(platform, device, fn);
        } else {
          return local(platform, device, fn);
        }
      }
    };
  };

}).call(this);
