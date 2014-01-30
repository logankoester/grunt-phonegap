(function() {
  var copy, cp, exec, grunt, helpers, path, _,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  grunt = require('grunt');

  copy = require('directory-copy');

  cp = require('cp');

  path = require('path');

  exec = require('child_process').exec;

  _ = require('lodash');

  helpers = require('./helpers');

  module.exports.Build = (function() {
    function Build() {
      this._fixAndroidVersionCode = __bind(this._fixAndroidVersionCode, this);
      this._buildPlatformLocal = __bind(this._buildPlatformLocal, this);
      this._buildPlatformRemote = __bind(this._buildPlatformRemote, this);
      this.buildScreens = __bind(this.buildScreens, this);
      this.buildIcons = __bind(this.buildIcons, this);
      this.buildPlatform = __bind(this.buildPlatform, this);
      this.postProcessPlatform = __bind(this.postProcessPlatform, this);
      this.addPlugin = __bind(this.addPlugin, this);
      this.compileConfig = __bind(this.compileConfig, this);
      this.cloneRoot = __bind(this.cloneRoot, this);
      this.cloneCordova = __bind(this.cloneCordova, this);
    }

    Build.prototype.buildTree = function(platforms) {
      var phonegapPath,
        _this = this;
      phonegapPath = helpers.config('path');
      _.each(['plugins', 'platforms', 'www', '.cordova'], function(dir) {
        return grunt.file.mkdir(path.join(phonegapPath, dir));
      });
      return _.each(platforms, function(platform) {
        return grunt.file.mkdir(path.join(phonegapPath, 'merges', platform));
      });
    };

    Build.prototype.cloneCordova = function(fn) {
      var cordovaPath, phonegapPath,
        _this = this;
      cordovaPath = helpers.config('cordova');
      phonegapPath = helpers.config('path');
      return copy({
        src: cordovaPath,
        dest: path.join(phonegapPath, '.cordova')
      }, function(err) {
        if (err) {
          grunt.warn(err);
        }
        if (fn) {
          return fn(err);
        }
      });
    };

    Build.prototype.cloneRoot = function(fn) {
      var phonegapPath, rootPath,
        _this = this;
      rootPath = helpers.config('root');
      phonegapPath = helpers.config('path');
      return copy({
        src: rootPath,
        dest: path.join(phonegapPath, 'www')
      }, function(err) {
        if (err) {
          grunt.warn(err);
        }
        if (fn) {
          return fn(err);
        }
      });
    };

    Build.prototype.compileConfig = function(fn) {
      var compiled, configXml, dest, phonegapPath, template;
      phonegapPath = helpers.config('path');
      configXml = helpers.config('config');
      dest = path.join(phonegapPath, 'www', 'config.xml');
      if (grunt.util.kindOf(configXml) === 'string') {
        grunt.logc.writeln("Copying static " + configXml);
        return cp(configXml, dest, function() {
          return fn();
        });
      } else {
        grunt.log.writeln("Compiling template " + configXml.template);
        template = grunt.file.read(configXml.template);
        compiled = grunt.template.process(template, {
          data: configXml.data
        });
        grunt.file.write(dest, compiled);
        return fn();
      }
    };

    Build.prototype.addPlugin = function(plugin, fn) {
      var cmd;
      cmd = "phonegap plugin add " + plugin + " " + (helpers.setVerbosity());
      return helpers.exec(cmd, fn);
    };

    Build.prototype.postProcessPlatform = function(platform, fn) {
      switch (platform) {
        case 'android':
          if (!helpers.isRemote()) {
            this._fixAndroidVersionCode();
          }
      }
      if (fn) {
        return fn();
      }
    };

    Build.prototype.buildPlatform = function(platform, fn) {
      if (helpers.isRemote()) {
        return this._buildPlatformRemote(platform, fn);
      } else {
        return this._buildPlatformLocal(platform, fn);
      }
    };

    Build.prototype.buildIcons = function(platform, fn) {
      var icons;
      icons = helpers.config('icons');
      if (icons) {
        switch (platform) {
          case 'android':
            this.buildAndroidIcons(icons);
            break;
          case 'wp8':
            this.buildWindowsPhone8Icons(icons);
            break;
          default:
            grunt.warn("You have set `phonegap.config.icons`, but " + platform + " does not support it. Skipped...");
        }
      } else {
        grunt.log.writeln("No `phonegap.config.icons` specified. Skipped.");
      }
      if (fn) {
        return fn();
      }
    };

    Build.prototype.buildAndroidIcons = function(icons) {
      var best, phonegapPath, res, _ref, _ref1, _ref2, _ref3;
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
        return grunt.file.copy(best, path.join(res, 'drawable', 'icon.png'), {
          encoding: null
        });
      }
    };

    Build.prototype.buildWindowsPhone8Icons = function(icons) {
      var phonegapPath, res, _ref, _ref1;
      phonegapPath = helpers.config('path');
      res = path.join(phonegapPath, 'platforms', 'wp8');
      if (icons != null ? (_ref = icons.wp8) != null ? _ref.app : void 0 : void 0) {
        grunt.file.copy(icons.wp8.app, path.join(res, 'ApplicationIcon.png'), {
          encoding: null
        });
      }
      if (icons != null ? (_ref1 = icons.wp8) != null ? _ref1.tile : void 0 : void 0) {
        return grunt.file.copy(icons.wp8.tile, path.join(res, 'Background.png'), {
          encoding: null
        });
      }
    };

    Build.prototype.buildScreens = function(platform, fn) {
      var screens;
      screens = helpers.config('screens');
      if (screens) {
        switch (platform) {
          case 'android':
            this.buildAndroidScreens(screens);
            break;
          default:
            grunt.warn("You have set `phonegap.config.screens`, but " + platform + " does not support it. Skipped...");
        }
      } else {
        grunt.log.writeln("No `phonegap.config.screens` specified. Skipped.");
      }
      if (fn) {
        return fn();
      }
    };

    Build.prototype.buildAndroidScreens = function(screens) {
      var best, bestLand, phonegapPath, res, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7;
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
        return grunt.file.copy(bestLand, path.join(res, 'drawable-land', 'splash.png'), {
          encoding: null
        });
      }
    };

    Build.prototype._buildPlatformRemote = function(platform, fn) {
      grunt.task.run('phonegap:login');
      helpers.exec("phonegap remote build " + platform + " " + (helpers.setVerbosity()), fn);
      return grunt.task.run('phonegap:logout');
    };

    Build.prototype._buildPlatformLocal = function(platform, fn) {
      return helpers.exec("phonegap local build " + platform + " " + (helpers.setVerbosity()), fn);
    };

    Build.prototype._fixAndroidVersionCode = function() {
      var data, doc, dom, manifest, manifestPath, phonegapPath, versionCode;
      dom = require('xmldom').DOMParser;
      data = helpers.config('versionCode');
      versionCode = grunt.util.kindOf(data) === 'function' ? data() : data;
      phonegapPath = helpers.config('path');
      manifestPath = path.join(phonegapPath, 'platforms', 'android', 'AndroidManifest.xml');
      manifest = grunt.file.read(manifestPath);
      doc = new dom().parseFromString(manifest, 'text/xml');
      doc.getElementsByTagName('manifest')[0].setAttribute('android:versionCode', versionCode);
      return grunt.file.write(manifestPath, doc);
    };

    return Build;

  })();

}).call(this);
