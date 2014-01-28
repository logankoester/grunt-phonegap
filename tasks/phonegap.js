(function() {
  module.exports = function(grunt) {
    var async, defaults, _;
    _ = require('lodash');
    async = require('async');
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
      }
    };
    grunt.registerTask('phonegap:build', 'Build as a Phonegap application', function(platform) {
      var Build, build, config, done, platforms;
      Build = require('./build').Build;
      config = _.defaults(grunt.config.get('phonegap.config'), defaults);
      done = this.async();
      build = new Build(grunt, config).clean().buildTree();
      platforms = platform || config.platforms;
      return async.series([build.cloneRoot, build.cloneCordova, build.compileConfig], function() {
        return async.eachSeries(config.plugins, build.addPlugin, function(err) {
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
      var Run, build, config, device, done, platform;
      Run = require('./run').Run;
      config = _.defaults(grunt.config.get('phonegap.config'), defaults);
      platform = this.args[0] || _.first(config.platforms);
      device = this.args[1] || '';
      done = this.async();
      return build = new Run(grunt, config).run(platform, device, function() {
        return done();
      });
    });
    return grunt.registerTask('phonegap:release', 'Create a distributable release', function() {
      var config, done, platform, release;
      release = require('./release').release;
      config = _.defaults(grunt.config.get('phonegap.config'), defaults);
      platform = this.args[0] || _.first(config.platforms);
      done = this.async();
      return release(grunt, config, platform, function() {
        return done();
      });
    });
  };

}).call(this);
