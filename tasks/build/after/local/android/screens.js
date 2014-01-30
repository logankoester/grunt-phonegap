(function() {
  var grunt, helpers, path;

  path = require('path');

  grunt = require('grunt');

  helpers = require('../../../../helpers');

  module.exports = {
    build: function(fn) {
      var best, bestLand, phonegapPath, res, screens, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7;
      screens = helpers.config('screens');
      phonegapPath = helpers.config('path');
      res = path.join(phonegapPath, 'platforms', 'android', 'res');
      best = null;
      bestLand = null;
      if (screens != null ? (_ref = screens.android) != null ? _ref.ldpi : void 0 : void 0) {
        best = screens.android.ldpi;
        grunt.file.copy(screens.android.ldpi, path.join(res, 'drawable-ldpi', 'splash.png'), {
          encoding: null
        });
      }
      if (screens != null ? (_ref1 = screens.android) != null ? _ref1.ldpiLand : void 0 : void 0) {
        bestLand = screens.android.ldpiLand;
        grunt.file.copy(screens.android.ldpiLand, path.join(res, 'drawable-land-ldpi', 'splash.png'), {
          encoding: null
        });
      }
      if (screens != null ? (_ref2 = screens.android) != null ? _ref2.mdpi : void 0 : void 0) {
        best = screens.android.mdpi;
        grunt.file.copy(screens.android.mdpi, path.join(res, 'drawable-mdpi', 'splash.png'), {
          encoding: null
        });
      }
      if (screens != null ? (_ref3 = screens.android) != null ? _ref3.mdpiLand : void 0 : void 0) {
        bestLand = screens.android.mdpiLand;
        grunt.file.copy(screens.android.mdpiLand, path.join(res, 'drawable-land-mdpi', 'splash.png'), {
          encoding: null
        });
      }
      if (screens != null ? (_ref4 = screens.android) != null ? _ref4.hdpi : void 0 : void 0) {
        best = screens.android.hdpi;
        grunt.file.copy(screens.android.hdpi, path.join(res, 'drawable-hdpi', 'splash.png'), {
          encoding: null
        });
      }
      if (screens != null ? (_ref5 = screens.android) != null ? _ref5.hdpiLand : void 0 : void 0) {
        bestLand = screens.android.hdpiLand;
        grunt.file.copy(screens.android.hdpiLand, path.join(res, 'drawable-land-hdpi', 'splash.png'), {
          encoding: null
        });
      }
      if (screens != null ? (_ref6 = screens.android) != null ? _ref6.xhdpi : void 0 : void 0) {
        best = screens.android.xhdpi;
        grunt.file.copy(screens.android.xhdpi, path.join(res, 'drawable-xhdpi', 'splash.png'), {
          encoding: null
        });
      }
      if (screens != null ? (_ref7 = screens.android) != null ? _ref7.xhdpiLand : void 0 : void 0) {
        bestLand = screens.android.xhdpiLand;
        grunt.file.copy(screens.android.xhdpiLand, path.join(res, 'drawable-land-xhdpi', 'splash.png'), {
          encoding: null
        });
      }
      if (best) {
        grunt.file.copy(best, path.join(res, 'drawable', 'splash.png'), {
          encoding: null
        });
      }
      if (bestLand) {
        grunt.file.copy(bestLand, path.join(res, 'drawable-land', 'splash.png'), {
          encoding: null
        });
      }
      if (fn) {
        return fn();
      }
    }
  };

}).call(this);
