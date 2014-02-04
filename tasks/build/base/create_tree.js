(function() {
  var createTree, path, _;

  path = require('path');

  _ = require('lodash');

  module.exports = createTree = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(platforms, fn) {
        var phonegapPath;
        grunt.log.writeln('Creating directory tree');
        phonegapPath = helpers.config('path');
        _.each(['plugins', 'platforms', 'www', '.cordova'], function(dir) {
          return grunt.file.mkdir(path.join(phonegapPath, dir));
        });
        _.each(platforms, (function(_this) {
          return function(platform) {
            return grunt.file.mkdir(path.join(phonegapPath, 'merges', platform));
          };
        })(this));
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
