(function() {
  var path, screens;

  path = require('path');

  module.exports = screens = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      build: function(fn) {
        var best, bestLand, phonegapPath, ref, ref1, ref2, ref3, ref4, ref5, ref6, ref7, res;
        screens = helpers.config('screens');
        phonegapPath = helpers.config('path');
        res = path.join(phonegapPath, 'platforms', 'android', 'res');
        best = null;
        bestLand = null;
        if (screens != null ? (ref = screens.android) != null ? ref.ldpi : void 0 : void 0) {
          best = screens.android.ldpi;
          grunt.file.copy(screens.android.ldpi, path.join(res, 'drawable-ldpi', 'splash.png'), {
            encoding: null
          });
        }
        if (screens != null ? (ref1 = screens.android) != null ? ref1.ldpiLand : void 0 : void 0) {
          bestLand = screens.android.ldpiLand;
          grunt.file.copy(screens.android.ldpiLand, path.join(res, 'drawable-land-ldpi', 'splash.png'), {
            encoding: null
          });
        }
        if (screens != null ? (ref2 = screens.android) != null ? ref2.mdpi : void 0 : void 0) {
          best = screens.android.mdpi;
          grunt.file.copy(screens.android.mdpi, path.join(res, 'drawable-mdpi', 'splash.png'), {
            encoding: null
          });
        }
        if (screens != null ? (ref3 = screens.android) != null ? ref3.mdpiLand : void 0 : void 0) {
          bestLand = screens.android.mdpiLand;
          grunt.file.copy(screens.android.mdpiLand, path.join(res, 'drawable-land-mdpi', 'splash.png'), {
            encoding: null
          });
        }
        if (screens != null ? (ref4 = screens.android) != null ? ref4.hdpi : void 0 : void 0) {
          best = screens.android.hdpi;
          grunt.file.copy(screens.android.hdpi, path.join(res, 'drawable-hdpi', 'splash.png'), {
            encoding: null
          });
        }
        if (screens != null ? (ref5 = screens.android) != null ? ref5.hdpiLand : void 0 : void 0) {
          bestLand = screens.android.hdpiLand;
          grunt.file.copy(screens.android.hdpiLand, path.join(res, 'drawable-land-hdpi', 'splash.png'), {
            encoding: null
          });
        }
        if (screens != null ? (ref6 = screens.android) != null ? ref6.xhdpi : void 0 : void 0) {
          best = screens.android.xhdpi;
          grunt.file.copy(screens.android.xhdpi, path.join(res, 'drawable-xhdpi', 'splash.png'), {
            encoding: null
          });
        }
        if (screens != null ? (ref7 = screens.android) != null ? ref7.xhdpiLand : void 0 : void 0) {
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
  };

}).call(this);
