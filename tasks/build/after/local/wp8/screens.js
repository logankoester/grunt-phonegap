(function() {
  var path, screens;

  path = require('path');

  module.exports = screens = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      build: function(fn) {
        var phonegapPath, res;
        screens = helpers.config('screens');
        phonegapPath = helpers.config('path');
        res = path.join(phonegapPath, 'platforms', 'wp8');
        if (screens != null ? screens.wp8 : void 0) {
          grunt.file.copy(screens.wp8, path.join(res, 'SplashScreenImage.jpg'), {
            encoding: null
          });
        }
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
