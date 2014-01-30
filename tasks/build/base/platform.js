(function() {
  var async, path, platform;

  async = require('async');

  path = require('path');

  module.exports = platform = function(grunt) {
    var buildPlatform, helpers, local, remote, runAfter;
    helpers = require('../../helpers')(grunt);
    remote = function(platform, fn) {
      grunt.task.run('phonegap:login');
      helpers.exec("phonegap remote build " + platform + " " + (helpers.setVerbosity()), fn);
      return grunt.task.run('phonegap:logout');
    };
    local = function(platform, fn) {
      return helpers.exec("phonegap local build " + platform + " " + (helpers.setVerbosity()), fn);
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
      if (helpers.isRemote()) {
        return remote(platform, function() {
          return runAfter('remote', platform, fn);
        });
      } else {
        return local(platform, function() {
          return runAfter('local', platform, fn);
        });
      }
    };
    return {
      build: function(platforms, fn) {
        grunt.log.writeln('Building platforms');
        return async.eachSeries(platforms, buildPlatform, function(err) {
          if (fn) {
            return fn(err);
          }
        });
      }
    };
  };

}).call(this);
