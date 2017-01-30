(function() {
  var async, fs, path, platform;

  async = require('async');

  path = require('path');

  fs = require('fs');

  module.exports = platform = function(grunt) {
    var addPlatform, buildPlatform, getArgs, helpers, local, remote, runAfter;
    getArgs = function() {
      var args;
      args = grunt.config.get('phonegap.config.args');
      if (args) {
        return ' --' + args.map(function(arg) {
          return arg.name + '="' + arg.value + '"';
        }).join(' --');
      } else {
        return '';
      }
    };
    helpers = require('../../helpers')(grunt);
    remote = function(platform, fn) {
      return helpers.exec(grunt.config.get('phonegap.config.cli') + (" remote build " + platform + (getArgs()) + " " + (helpers.setVerbosity())), fn);
    };
    local = function(platform, fn) {
      return helpers.exec(grunt.config.get('phonegap.config.cli') + (" build " + platform + (getArgs()) + " " + (helpers.setVerbosity())), fn);
    };
    runAfter = function(provider, platform, fn) {
      var adapter;
      adapter = path.join(__dirname, '..', 'after', provider, "" + platform + ".js");
      if (grunt.file.exists(adapter)) {
        return require(adapter)(grunt).run(fn);
      } else {
        grunt.log.writeln("No post-build tasks at '" + adapter + "'");
        if (fn) {
          return fn();
        }
      }
    };
    buildPlatform = function(platform, fn) {
      if (helpers.isRemote(platform)) {
        return remote(platform, function() {
          return runAfter('remote', platform, fn);
        });
      } else {
        return local(platform, function() {
          return runAfter('local', platform, fn);
        });
      }
    };
    addPlatform = function(platform, fn) {
      if (grunt.config.get('phonegap.config.cli') === 'cordova') {
        return helpers.exec("cordova platform add " + platform, function(err) {
          if (err) {
            return grunt.fatal(err);
          } else {
            return buildPlatform(platform, fn);
          }
        });
      } else {
        return buildPlatform(platform, fn);
      }
    };
    return {
      build: function(platforms, fn) {
        grunt.log.writeln('Building platforms');
        return async.eachSeries(platforms, addPlatform, function(err) {
          if (fn) {
            return fn(err);
          }
        });
      }
    };
  };

}).call(this);
