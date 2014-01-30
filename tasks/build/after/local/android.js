(function() {
  var fluid, grunt, tasks;

  fluid = require('fluid');

  grunt = require('grunt');

  tasks = {
    repairVersionCode: require('./android/version_code').repair,
    buildIcons: require('./android/icons').build,
    buildScreens: require('./android/screens').build
  };

  module.exports = {
    run: function(fn) {
      return fluid(tasks).repairVersionCode().buildIcons().buildScreens().go(function(err, result) {
        if (err) {
          grunt.fatal(err);
        }
        if (fn) {
          return fn();
        }
      });
    }
  };

}).call(this);
