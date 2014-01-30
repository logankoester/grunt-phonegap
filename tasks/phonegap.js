(function() {
  module.exports = function(grunt) {
    var async, defaults, helpers, _;
    _ = require('lodash');
    async = require('async');
    helpers = require('./helpers');
    defaults = {
      root: 'www',
      config: 'www/config.xml',
      path: 'build',
      cordova: '.cordova',
      plugins: [],
      platforms: [],
      maxBuffer: 200,
      verbose: false,
      releases: 'releases',
      releaseName: function() {
        var pkg;
        pkg = grunt.file.readJSON('package.json');
        return "" + pkg.name + "-" + pkg.version;
      },
      key: {
        store: 'release.keystore',
        alias: 'release',
        aliasPassword: function() {
          return '';
        },
        storePassword: function() {
          return '';
        }
      },
      versionCode: function() {
        return 1;
      },
      remote: {}
    };
    grunt.registerTask('phonegap:build', 'Build as a Phonegap application', function(platform) {
      var Build, build, done, platforms, plugins;
      helpers.mergeConfig(defaults);
      Build = require('./build').Build;
      done = this.async();
      platforms = platform ? [platform] : helpers.config('platforms');
      plugins = helpers.config('plugins');
      build = new Build;
      helpers.clean(helpers.config('path'));
      build.buildTree(platforms);
      return async.series([build.cloneRoot, build.cloneCordova, build.compileConfig], function() {
        return async.eachSeries(plugins, build.addPlugin, function(err) {
          return async.eachSeries(platforms, build.buildPlatform, function(err) {
            return async.eachSeries(platforms, build.postProcessPlatform, function() {
              return async.eachSeries(platforms, build.buildIcons, function(err) {
                return async.eachSeries(platforms, build.buildScreens, function(err) {
                  return done();
                });
              });
            });
          });
        });
      });
    });
    grunt.registerTask('phonegap:run', 'Run a Phonegap application', function() {
      var Run, device, done, platform, run;
      helpers.mergeConfig(defaults);
      Run = require('./run').Run;
      platform = this.args[0] || _.first(grunt.config.get('phonegap.config.platforms'));
      device = this.args[1] || '';
      done = this.async();
      return run = new Run().run(platform, device, function() {
        return done();
      });
    });
    grunt.registerTask('phonegap:release', 'Create a distributable release', function() {
      var done, platform;
      helpers.mergeConfig(defaults);
      platform = this.args[0] || _.first(grunt.config.get('phonegap.config.platforms'));
      done = this.async();
      return require('./release').on(platform, function() {
        return done();
      });
    });
    grunt.registerTask('phonegap:login', 'Log into the remote build service', function() {
      var cmd, done, password, username;
      helpers.mergeConfig(defaults);
      grunt.config.requires('phonegap.remote.username');
      grunt.config.requires('phonegap.remote.password');
      username = grunt.config.get('phonegap.remote.username');
      password = grunt.config.get('phonegap.remote.password');
      done = this.async();
      cmd = "phonegap remote login --username " + username + " --password " + password;
      return helpers.exec(cmd, function() {
        return done();
      });
    });
    return grunt.registerTask('phonegap:logout', 'Log out of the remote build service', function() {
      var done;
      helpers.mergeConfig(defaults);
      done = this.async();
      return helpers.exec('phonegap remote logout', function() {
        return done();
      });
    });
  };

}).call(this);
