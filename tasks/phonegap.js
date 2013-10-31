(function() {
  module.exports = function(grunt) {
    var Build, Run, async, defaults, _;
    Build = require('./build').Build;
    Run = require('./run').Run;
    _ = grunt.util._;
    async = grunt.util.async;
    async.eachSeries = require('async').eachSeries;
    defaults = {
      root: 'www',
      config: 'www/config.xml',
      path: 'build',
      cordova: '.cordova',
      plugins: [],
      platforms: [],
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
      }
    };
    grunt.registerTask('phonegap:build', 'Build as a Phonegap application', function() {
      var build, config, done;
      config = _.defaults(grunt.config.get('phonegap.config'), defaults);
      done = this.async();
      build = new Build(grunt, config).clean().buildTree();
      return async.series([build.cloneRoot, build.cloneCordova, build.compileConfig], function() {
        return async.eachSeries(config.plugins, build.addPlugin, function(err) {
          return async.eachSeries(config.platforms, build.buildPlatform, function(err) {
            return async.eachSeries(config.platforms, build.buildIcons, function(err) {
              return done();
            });
          });
        });
      });
    });
    grunt.registerTask('phonegap:run', 'Run a Phonegap application', function() {
      var build, config, device, done, platform;
      config = _.defaults(grunt.config.get('phonegap.config'), defaults);
      platform = this.args[0] || _.first(config.platforms);
      device = this.args[1] || '';
      done = this.async();
      return build = new Run(grunt, config).run(platform, device, function() {
        return done();
      });
    });
    return grunt.registerTask('phonegap:release', 'Create a distributable release', function() {
      var config, done, platform;
      config = _.defaults(grunt.config.get('phonegap.config'), defaults);
      platform = this.args[0] || _.first(config.platforms);
      done = this.async();
      return require('./release').release(grunt, config, platform, function() {
        return done();
      });
    });
  };

}).call(this);
