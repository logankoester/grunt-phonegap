(function() {
  var grunt, helpers, path;

  path = require('path');

  grunt = require('grunt');

  helpers = require('../../../../helpers');

  module.exports = {
    build: function(fn) {
      var best, icons, phonegapPath, res, _ref, _ref1, _ref2, _ref3;
      icons = helpers.config('icons');
      phonegapPath = helpers.config('path');
      res = path.join(phonegapPath, 'platforms', 'android', 'res');
      best = null;
      if ((icons != null ? icons.ldpi : void 0) || (icons != null ? icons.mdpi : void 0) || (icons != null ? icons.hdpi : void 0) || (icons != null ? icons.xhdpi : void 0)) {
        grunt.warn("`phonegap.config.icons` has moved to `phonegap.config.icons.<platform>`.\nCheck the example in the grunt-phonegap README and update your Gruntfile accordingly.\n");
        icons.android = icons;
      }
      if (icons != null ? (_ref = icons.android) != null ? _ref.ldpi : void 0 : void 0) {
        best = icons.android.ldpi;
        grunt.file.copy(icons.android.ldpi, path.join(res, 'drawable-ldpi', 'icon.png'), {
          encoding: null
        });
      }
      if (icons != null ? (_ref1 = icons.android) != null ? _ref1.mdpi : void 0 : void 0) {
        best = icons.android.mdpi;
        grunt.file.copy(icons.android.mdpi, path.join(res, 'drawable-mdpi', 'icon.png'), {
          encoding: null
        });
      }
      if (icons != null ? (_ref2 = icons.android) != null ? _ref2.hdpi : void 0 : void 0) {
        best = icons.android.hdpi;
        grunt.file.copy(icons.android.hdpi, path.join(res, 'drawable-hdpi', 'icon.png'), {
          encoding: null
        });
      }
      if (icons != null ? (_ref3 = icons.android) != null ? _ref3.xhdpi : void 0 : void 0) {
        best = icons.android.xhdpi;
        grunt.file.copy(icons.android.xhdpi, path.join(res, 'drawable-xhdpi', 'icon.png'), {
          encoding: null
        });
      }
      if (best) {
        grunt.file.copy(best, path.join(res, 'drawable', 'icon.png'), {
          encoding: null
        });
      }
      if (fn) {
        return fn();
      }
    }
  };

}).call(this);
