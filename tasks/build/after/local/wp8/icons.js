(function() {
  var grunt, helpers, path;

  path = require('path');

  grunt = require('grunt');

  helpers = require('../../../../helpers');

  module.exports = {
    build: function(fn) {
      var icons, phonegapPath, res, _ref, _ref1;
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

}).call(this);
