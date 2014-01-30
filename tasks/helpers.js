(function() {
  var exec, helpers, _,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  _ = require('lodash');

  exec = require('child_process').exec;

  module.exports = helpers = function(grunt) {
    return {
      mergeConfig: function(defaults) {
        return _.defaults(grunt.config.get('phonegap.config'), defaults);
      },
      exec: function(cmd, fn, cwd) {
        var options, proc,
          _this = this;
        if (cwd == null) {
          cwd = grunt.config.get('phonegap.config.path');
        }
        grunt.log.writeln("Running: " + cmd);
        options = {
          maxBuffer: grunt.config.get('phonegap.config.maxBuffer') * 1024,
          cwd: cwd
        };
        proc = exec(cmd, options, function(err, stdout, stderr) {
          if (err) {
            grunt.fatal(err);
          }
          if (fn) {
            return fn(err);
          }
        });
        proc.stdout.on('data', function(out) {
          return grunt.log.write(out);
        });
        return proc.stderr.on('data', function(err) {
          return grunt.fatal(err);
        });
      },
      clean: function(target) {
        if (grunt.file.exists(target)) {
          return grunt.file["delete"](target);
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
        if (((remote != null ? remote.platforms : void 0) != null) && __indexOf.call(remote.platforms, platform) >= 0) {
          grunt.config.requires('phonegap.config.remote.username');
          grunt.config.requires('phonegap.config.remote.password');
          return true;
        } else {
          return false;
        }
      },
      ensureExists: function(path, failMessage) {
        failMessage || (failMessage = "\"" + path + "\" does not exist.");
        if (grunt.file.exists(path)) {
          return true;
        } else {
          grunt.fatal(failMessage);
          return false;
        }
      },
      config: function(property) {
        var value;
        value = grunt.config.get("phonegap.config." + property);
        if (typeof value === 'Function') {
          return value();
        } else {
          return value;
        }
      }
    };
  };

}).call(this);
