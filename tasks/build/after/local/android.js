(function() {
  var android, fluid;

  fluid = require('fluid');

  module.exports = android = function(grunt) {
    var tasks;
    tasks = {
      repairVersionCode: require('./android/version_code')(grunt).repair,
      buildIcons: require('./android/icons')(grunt).build,
      buildScreens: require('./android/screens')(grunt).build,
      setMinSdkVersion: require('./android/sdk_version')(grunt).setMin,
      setTargetSdkVersion: require('./android/sdk_version')(grunt).setTarget,
      setPermissions: require('./android/permissions')(grunt).set,
      setAndroidApplicationName: require('./android/application_name')(grunt).set
    };
    return {
      run: function(fn) {
        return fluid(tasks).repairVersionCode().setMinSdkVersion().setTargetSdkVersion().setPermissions().setAndroidApplicationName().buildIcons().buildScreens().go(function(err, result) {
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
