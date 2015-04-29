(function() {
  var icons, path;

  path = require('path');

  module.exports = icons = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      build: function(fn) {
        var appName, phonegapPath, res, _ref, _ref1, _ref10, _ref11, _ref12, _ref13, _ref14, _ref15, _ref16, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9;
        icons = helpers.config('icons');
        phonegapPath = helpers.config('path');
        appName = helpers.config('name');
        res = path.join(phonegapPath, 'platforms', 'ios', appName, 'Resources', 'icons');
        if (icons != null ? (_ref = icons.ios) != null ? _ref.icon29 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon29, path.join(res, 'icon-small.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref1 = icons.ios) != null ? _ref1.icon29x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon29x2, path.join(res, 'icon-small@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref2 = icons.ios) != null ? _ref2.icon40 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon40, path.join(res, 'icon-40.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref3 = icons.ios) != null ? _ref3.icon40x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon40x2, path.join(res, 'icon-40@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref4 = icons.ios) != null ? _ref4.icon50 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon50, path.join(res, 'icon-50.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref5 = icons.ios) != null ? _ref5.icon50x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon50x2, path.join(res, 'icon-50@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref6 = icons.ios) != null ? _ref6.icon57 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon57, path.join(res, 'icon.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref7 = icons.ios) != null ? _ref7.icon57x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon57x2, path.join(res, 'icon@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref8 = icons.ios) != null ? _ref8.icon60 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon60, path.join(res, 'icon-60.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref9 = icons.ios) != null ? _ref9.icon60x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon60x2, path.join(res, 'icon-60@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref10 = icons.ios) != null ? _ref10.icon60x3 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon60x3, path.join(res, 'icon-60@3x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref11 = icons.ios) != null ? _ref11.icon72 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon72, path.join(res, 'icon-72.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref12 = icons.ios) != null ? _ref12.icon72x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon72x2, path.join(res, 'icon-72@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref13 = icons.ios) != null ? _ref13.icon76 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon76, path.join(res, 'icon-76.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref14 = icons.ios) != null ? _ref14.icon76x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon76x2, path.join(res, 'icon-76@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref15 = icons.ios) != null ? _ref15.icon512 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon512, path.join(res, 'icon-512.png'), {
            encoding: null
          });
        }
        if (icons != null ? (_ref16 = icons.ios) != null ? _ref16.icon512x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon512x2, path.join(res, 'icon-512@2x.png'), {
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
