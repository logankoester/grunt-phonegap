(function() {
  var icons, path;

  path = require('path');

  module.exports = icons = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      build: function(fn) {
        var phonegapPath, ref, ref1, res;
        icons = helpers.config('icons');
        phonegapPath = helpers.config('path');
        res = path.join(phonegapPath, 'platforms', 'wp8');
        if (icons != null ? (ref = icons.wp8) != null ? ref.app : void 0 : void 0) {
          grunt.file.copy(icons.wp8.app, path.join(res, 'ApplicationIcon.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref1 = icons.wp8) != null ? ref1.tile : void 0 : void 0) {
          grunt.file.copy(icons.wp8.tile, path.join(res, 'Background.png'), {
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
