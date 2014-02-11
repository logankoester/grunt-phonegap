(function() {
  var android, fluid;

  fluid = require('fluid');

  module.exports = android = function(grunt) {
    var tasks;
    tasks = {
      repairVersionCode: require('./android/version_code')(grunt).repair,
      buildIcons: require('./android/icons')(grunt).build,
      buildScreens: require('./android/screens')(grunt).build,
      setTargetSdkVersion: require('./android/sdk_version')(grunt).setTarget
    };
    return {
      run: function(fn) {
        return fluid(tasks).repairVersionCode().setTargetSdkVersion().buildIcons().buildScreens().go(function(err, result) {
          if (err) {
            grunt.fatal(err);
          }
          if (fn) {
            return fn();
          }
        });
      }
    };
  };

}).call(this);
