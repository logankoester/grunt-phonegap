(function() {
  var fluid, ios;

  fluid = require('fluid');

  module.exports = ios = function(grunt) {
    var tasks;
    tasks = {
      buildIcons: require('./ios/icons')(grunt).build,
      buildScreens: require('./ios/screens')(grunt).build,
      buildResources: require('./ios/resources')(grunt).build,
      setStatusBar: require('./ios/plist')(grunt).setStatusBar
    };
    return {
      run: function(fn) {
        return fluid(tasks).buildIcons().buildScreens().buildResources().setStatusBar().go(function(err, result) {
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
