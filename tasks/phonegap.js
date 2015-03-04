(function() {
  var async, _;

  _ = require('lodash');

  async = require('async');

  module.exports = function(grunt) {
    var defaults;
    defaults = {
      cli: 'phonegap local',
      root: 'www',
      config: 'www/config.xml',
      configXml: 'www/config.xml',
      path: 'build',
      cleanBeforeBuild: true,
      cordova: '.cordova',
      plugins: [],
      platforms: [],
      maxBuffer: 200,
      name: function() {
        var pkg;
        pkg = grunt.file.readJSON('package.json');
        return pkg.name;
      },
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
      debuggable: false,
      remote: {}
    };
    grunt.registerTask('phonegap:build', 'Build as a Phonegap application', function(platform) {
      var build, done, helpers, platforms;
      helpers = require('./helpers')(grunt);
      helpers.mergeConfig(defaults);
      build = require('./build')(grunt);
      platforms = platform ? [platform] : helpers.config('platforms');
      done = this.async();
      return build.run(platforms, function(err, result) {
        if (err) {
          grunt.fatal(err);
        }
        return done();
      });
    });
    grunt.registerTask('phonegap:run', 'Run a Phonegap application', function() {
      var device, done, helpers, platform, run;
      helpers = require('./helpers')(grunt);
      helpers.mergeConfig(defaults);
      run = require('./run')(grunt);
      platform = this.args[0] || _.first(grunt.config.get('phonegap.config.platforms'));
      device = this.args[1] || '';
      done = this.async();
      return run.run(platform, device, function() {
        return done();
      });
    });
    grunt.registerTask('phonegap:release', 'Create a distributable release', function() {
      var done, helpers, platform, release;
      helpers = require('./helpers')(grunt);
      helpers.mergeConfig(defaults);
      release = require('./release')(grunt);
      platform = this.args[0] || _.first(grunt.config.get('phonegap.config.cli'));
      done = this.async();
      return release.on(platform, function() {
        return done();
      });
    });
    grunt.registerTask('phonegap:debug', 'Create a debug release', function() {
      var debug, done, helpers, platform;
      helpers = require('./helpers')(grunt);
      helpers.mergeConfig(defaults);
      debug = require('./debug')(grunt);
      platform = this.args[0] || _.first(grunt.config.get('phonegap.config.platforms'));
      done = this.async();
      return debug.on(platform, function() {
        return done();
      });
    });
    grunt.registerTask('phonegap:login', 'Log into the remote build service', function() {
      var cmd, done, helpers, password, username;
      helpers = require('./helpers')(grunt);
      helpers.mergeConfig(defaults);
      grunt.config.requires('phonegap.config.remote.username');
      grunt.config.requires('phonegap.config.remote.password');
      username = grunt.config.get('phonegap.config.remote.username');
      password = grunt.config.get('phonegap.config.remote.password');
      done = this.async();
      cmd = "phonegap remote login --username " + username + " --password " + password;
      return helpers.exec(cmd, function() {
        return done();
      });
    });
    return grunt.registerTask('phonegap:logout', 'Log out of the remote build service', function() {
      var done, helpers;
      helpers = require('./helpers')(grunt);
      helpers.mergeConfig(defaults);
      done = this.async();
      return helpers.exec('phonegap remote logout', function() {
        return done();
      });
    });
  };

}).call(this);
