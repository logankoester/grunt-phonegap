(function() {
  var icons, path;

  path = require('path');

  module.exports = icons = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      build: function(fn) {
        var phonegapPath, res, _ref, _ref1;
        icons = helpers.config('icons');
        phonegapPath = helpers.config('path');
        res = path.join(phonegapPath, 'platforms', 'wp8');
        if (icons != null ? (_ref = icons.wp8) != null ? _ref.app : void 0 : void 0) {
          grunt.file.copy(icons.wp8.app, path.join(res, 'ApplicationIcon.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref1 = icons.wp8) != null ? _ref1.tile : void 0 : void 0) {
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
