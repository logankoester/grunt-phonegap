(function() {
  var cloneCordova, ncp, path;

  path = require('path');

  ncp = require('ncp').ncp;

  module.exports = cloneCordova = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var cordovaPath, phonegapPath;
        grunt.log.writeln('Cloning .cordova directory');
        cordovaPath = helpers.config('cordova');
        phonegapPath = helpers.config('path');
        return ncp(cordovaPath, path.join(phonegapPath, '.cordova'), {
          stopOnError: true
        }, (err) => {
          if (err) {
            grunt.warn(err);
          }
          if (fn) {
            return fn(err);
          }
        });
      }
    };
  };

}).call(this);
