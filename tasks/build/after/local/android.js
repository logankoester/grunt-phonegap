(function() {
  var android, fluid;

  fluid = require('fluid');

  module.exports = android = function(grunt) {
    var tasks;
    tasks = {
      repairVersionCode: require('./android/version_code')(grunt).repair,
      buildIcons: require('./android/icons')(grunt).build,
      buildScreens: require('./android/screens')(grunt).build,
      buildResources: require('./android/resources')(grunt).build,
      setMinSdkVersion: require('./android/sdk_version')(grunt).setMin,
      setTargetSdkVersion: require('./android/sdk_version')(grunt).setTarget,
      setPermissions: require('./android/permissions')(grunt).set,
      setAndroidApplicationName: require('./android/application_name')(grunt).set,
      setManfifestParams: require('./android/manifest_params')(grunt).set,
      setScreenOrientation: require('./android/screen_orientation')(grunt).set,
      setDebuggable: require('./android/debuggable')(grunt).set
    };
    return {
      run: function(fn) {
        return fluid(tasks).repairVersionCode().setMinSdkVersion().setTargetSdkVersion().setPermissions().setAndroidApplicationName().setManfifestParams().buildIcons().buildScreens().buildResources().setScreenOrientation().setDebuggable().go(function(err, result) {
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
