(function() {
  var _, canBuild, exec, helpers,
    indexOf = [].indexOf;

  _ = require('lodash');

  exec = require('child_process').exec;

  // Check SDK compatibility for a target platform from the current environment.

  // Note that this does not guarantee that the required SDK is installed on the system,
  // nor that any particular `grunt-phonegap` features support the platform.

  // @see http://docs.phonegap.com/en/3.3.0/guide_support_index.md.html#Platform%20Support

  // @param [String] targetPlatform The target mobile platform.
  // @return [Boolean] true When it is possible to build from this environment.
  // @return [Boolean] false When it is not possible to build from this environment from this environment.
  canBuild = function(targetPlatform) {
    var compatibility;
    compatibility = {
      'amazon-fireos': ['darwin', 'win32', 'linux'],
      'android': ['darwin', 'win32', 'linux'],
      'blackberry10': ['darwin', 'win32'],
      'firefoxos': ['darwin', 'win32', 'linux'],
      'ios': ['darwin'],
      'ubuntu': ['linux'], // Specifically Ubuntu
      'wp7': ['win32'],
      'wp8': ['win32'], // Specifically Windows 8
      'win8': ['win32'], // Specifically Windows 8
      'tizen': []
    };
    return _.contains(compatibility[targetPlatform.toLowerCase()], process.platform.toLowerCase());
  };

  module.exports = helpers = function(grunt) {
    return {
      // Merge a default config object into the grunt-phonegap configuration.

      // @param [Object] defaults The default config object
      // @return [Object] The merged config object
      mergeConfig: function(defaults) {
        return grunt.config.set('phonegap.config', _.defaults(grunt.config.get('phonegap.config'), defaults));
      },
      // Execute the given command in a child process, and then run the
      // callback function if one is provided.

      // STDOUT will be written to the Grunt logger.
      // STDERR will be displayed and then Grunt will be aborted immediately.

      // @param [String] cmd The shell command to execute
      // @param [Function] fn An optional function to call when the child process terminates.
      exec: function(cmd, fn, cwd = grunt.config.get('phonegap.config.path')) {
        var options, proc;
        grunt.log.writeln(`Running: ${cmd}`);
        options = {
          maxBuffer: grunt.config.get('phonegap.config.maxBuffer') * 1024,
          cwd: cwd
        };
        proc = exec(cmd, options, (err, stdout, stderr) => {
          if (err) {
            grunt.fatal(err);
          }
          if (fn) {
            return fn(err);
          }
        });
        proc.stdout.on('data', (out) => {
          return grunt.log.write(out);
        });
        return proc.stderr.on('data', (err) => {
          return grunt.log.error(err);
        });
      },
      // Delete a target file path if it exists.

      // @param [String] target File path to be deleted.
      clean: function(target) {
        if (grunt.file.exists(target)) {
          return grunt.file.delete(target);
        }
      },
      setVerbosity: function() {
        if (grunt.config.get('phonegap.config.verbose')) {
          return '-V';
        } else {
          return '';
        }
      },
      isRemote: function(platform) {
        var remote;
        remote = helpers(grunt).config('remote');
        if (((remote != null ? remote.platforms : void 0) != null) && indexOf.call(remote.platforms, platform) >= 0) {
          grunt.config.requires('phonegap.config.remote.username');
          grunt.config.requires('phonegap.config.remote.password');
          return true;
        } else {
          return false;
        }
      },
      ensureExists: function(path, failMessage) {
        failMessage || (failMessage = `"${path}" does not exist.`);
        if (grunt.file.exists(path)) {
          return true;
        } else {
          grunt.fatal(failMessage);
          return false;
        }
      },
      config: function(property) {
        var value;
        value = grunt.config.get(`phonegap.config.${property}`);
        if (typeof value === 'function') {
          return value();
        } else {
          return value;
        }
      },
      canBuild: canBuild,
      // Reduce an array of platforms to a subset compatible with the current environment.

      // Logs a message for each platform that is excluded.

      // @param [Array] platforms An array of platforms.
      // @return [Array] platforms A subset of the given array for which #canBuild(platform) is true.
      reducePlatforms: function(platforms) {
        return _.filter(platforms, function(platform) {
          if (canBuild(platform)) {
            return true;
          }
          grunt.log.writeln(`Skipping platform '${platform}' (SDK not compatible)`);
          return false;
        });
      }
    };
  };

}).call(this);
