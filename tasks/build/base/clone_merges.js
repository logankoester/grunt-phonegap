(function() {
  var cloneRoot, ncp, path;

  path = require('path');

  ncp = require('ncp').ncp;

  module.exports = cloneRoot = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var mergesPath, phonegapPath;
        mergesPath = helpers.config('merges');
        if (mergesPath && mergesPath !== '') {
          grunt.log.writeln(mergesPath);
          grunt.log.writeln('Cloning root directory');
          phonegapPath = helpers.config('path');
          return ncp(mergesPath, path.join(phonegapPath, 'merges'), {
            stopOnError: true
          }, (function(_this) {
            return function(err) {
              if (err) {
                grunt.warn(err);
              }
              if (fn) {
                return fn(err);
              }
            };
          })(this));
        }
      }
    };
  };

}).call(this);
