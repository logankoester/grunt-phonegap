(function() {
  var icons, path;

  path = require('path');

  module.exports = icons = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      build: function(fn) {
        var appName, phonegapPath, ref, ref1, ref10, ref11, ref12, ref13, ref14, ref15, ref2, ref3, ref4, ref5, ref6, ref7, ref8, ref9, res;
        icons = helpers.config('icons');
        phonegapPath = helpers.config('path');
        appName = helpers.config('name');
        res = path.join(phonegapPath, 'platforms', 'ios', appName, 'Resources', 'icons');
        if (icons != null ? (ref = icons.ios) != null ? ref.icon29 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon29, path.join(res, 'icon-small.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref1 = icons.ios) != null ? ref1.icon29x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon29x2, path.join(res, 'icon-small@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref2 = icons.ios) != null ? ref2.icon40 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon40, path.join(res, 'icon-40.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref3 = icons.ios) != null ? ref3.icon40x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon40x2, path.join(res, 'icon-40@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref4 = icons.ios) != null ? ref4.icon50 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon50, path.join(res, 'icon-50.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref5 = icons.ios) != null ? ref5.icon50x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon50x2, path.join(res, 'icon-50@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref6 = icons.ios) != null ? ref6.icon57 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon57, path.join(res, 'icon.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref7 = icons.ios) != null ? ref7.icon57x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon57x2, path.join(res, 'icon@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref8 = icons.ios) != null ? ref8.icon60 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon60, path.join(res, 'icon-60.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref9 = icons.ios) != null ? ref9.icon60x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon60x2, path.join(res, 'icon-60@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref10 = icons.ios) != null ? ref10.icon72 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon72, path.join(res, 'icon-72.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref11 = icons.ios) != null ? ref11.icon72x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon72x2, path.join(res, 'icon-72@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref12 = icons.ios) != null ? ref12.icon76 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon76, path.join(res, 'icon-76.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref13 = icons.ios) != null ? ref13.icon76x2 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon76x2, path.join(res, 'icon-76@2x.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref14 = icons.ios) != null ? ref14.icon512 : void 0 : void 0) {
          grunt.file.copy(icons.ios.icon512, path.join(res, 'icon-512.png'), {
            encoding: null
          });
        }
        if (icons != null ? (ref15 = icons.ios) != null ? ref15.icon512x2 : void 0 : void 0) {
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
