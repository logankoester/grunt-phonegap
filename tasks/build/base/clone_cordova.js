(function() {
  var cloneCordova, copy, path;

  path = require('path');

  copy = require('directory-copy');

  module.exports = cloneCordova = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var cordovaPath, phonegapPath;
        grunt.log.writeln('Cloning .cordova directory');
        cordovaPath = helpers.config('cordova');
        phonegapPath = helpers.config('path');
        return copy({
          src: cordovaPath,
          dest: path.join(phonegapPath, '.cordova')
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
    };
  };

}).call(this);
