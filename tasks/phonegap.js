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
      },
      remote: {}
    };
    grunt.registerTask('phonegap:build', 'Build as a Phonegap application', function(platform) {
      var Build, build, config, done, platforms;
      Build = require('./build').Build;
      config = _.defaults(grunt.config.get('phonegap.config'), defaults);
      done = this.async();
      platforms = platform ? [platform] : config.platforms;
      build = new Build(grunt, config).clean().buildTree(platforms);
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
    grunt.registerTask('phonegap:release', 'Create a distributable release', function() {
      var config, done, platform, release;
      release = require('./release').release;
      config = _.defaults(grunt.config.get('phonegap.config'), defaults);
      platform = this.args[0] || _.first(config.platforms);
      done = this.async();
      return release(grunt, config, platform, function() {
        return done();
      });
    });
    grunt.registerTask('phonegap:login', 'Log into the remote build service', function() {
      var childProcess, cmd, password, username,
        _this = this;
      grunt.config.requires('phonegap.remote.username');
      grunt.config.requires('phonegap.remote.password');
      username = grunt.config.get('phonegap.remote.username');
      password = grunt.config.get('phonegap.remote.password');
      cmd = "phonegap remote login --username " + username + " --password " + password;
      childProcess = require('child_process').exec(cmd, {
        cwd: grunt.config.get('phonegap.path'),
        maxBuffer: grunt.config.get('phonegap.maxBuffer') * 1024
      }, function(err, stdout, stderr) {
        if (err) {
          grunt.fatal(err);
        }
        if (fn) {
          return fn(err);
        }
      });
      childProcess.stdout.on('data', function(out) {
        return grunt.log.write(out);
      });
      return childProcess.stderr.on('data', function(err) {
        return grunt.fatal(err);
      });
    });
    return grunt.registerTask('phonegap:logout', 'Log out of the remote build service', function() {
      var childProcess, cmd,
        _this = this;
      cmd = 'phonegap remote logout';
      childProcess = require('child_process').exec(cmd, {
        cwd: grunt.config.get('phonegap.path'),
        maxBuffer: grunt.config.get('phonegap.maxBuffer') * 1024
      }, function(err, stdout, stderr) {
        if (err) {
          grunt.fatal(err);
        }
        if (fn) {
          return fn(err);
        }
      });
      childProcess.stdout.on('data', function(out) {
        return grunt.log.write(out);
      });
      return childProcess.stderr.on('data', function(err) {
        return grunt.fatal(err);
      });
    });
  };

}).call(this);
