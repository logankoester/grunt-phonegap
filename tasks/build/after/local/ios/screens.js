(function() {
  var path, screens;

  path = require('path');

  module.exports = screens = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      build: function(fn) {
        var appName, phonegapPath, res, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6;
        screens = helpers.config('screens');
        phonegapPath = helpers.config('path');
        appName = helpers.config('name');
        res = path.join(phonegapPath, 'platforms', 'ios', appName, 'Resources', 'splash');
        if ((screens != null ? (_ref = screens.ios) != null ? _ref.ipadLand : void 0 : void 0) != null) {
          grunt.file.copy(screens.ios.ipadLand, path.join(res, 'Default-Landscape~ipad.png'), {
            encoding: null
          });
        }
        if ((screens != null ? (_ref1 = screens.ios) != null ? _ref1.ipadLandx2 : void 0 : void 0) != null) {
          grunt.file.copy(screens.ios.ipadLandx2, path.join(res, 'Default-Landscape@2x~ipad.png'), {
            encoding: null
          });
        }
        if ((screens != null ? (_ref2 = screens.ios) != null ? _ref2.ipadPortraitx2 : void 0 : void 0) != null) {
          grunt.file.copy(screens.ios.ipadPortraitx2, path.join(res, 'Default-Portrait@2x~ipad.png'), {
            encoding: null
          });
        }
        if ((screens != null ? (_ref3 = screens.ios) != null ? _ref3.ipadPortrait : void 0 : void 0) != null) {
          grunt.file.copy(screens.ios.ipadPortrait, path.join(res, 'Default-Portrait~ipad.png'), {
            encoding: null
          });
        }
        if ((screens != null ? (_ref4 = screens.ios) != null ? _ref4.iphonePortrait : void 0 : void 0) != null) {
          grunt.file.copy(screens.ios.iphonePortrait, path.join(res, 'Default~iphone.png'), {
            encoding: null
          });
        }
        if ((screens != null ? (_ref5 = screens.ios) != null ? _ref5.iphonePortraitx2 : void 0 : void 0) != null) {
          grunt.file.copy(screens.ios.iphonePortraitx2, path.join(res, 'Default@2x~iphone.png'), {
            encoding: null
          });
        }
        if ((screens != null ? (_ref6 = screens.ios) != null ? _ref6.iphone568hx2 : void 0 : void 0) != null) {
          grunt.file.copy(screens.ios.iphone568hx2, path.join(res, 'Default-568h@2x~iphone.png'), {
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
