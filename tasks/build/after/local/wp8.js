(function() {
  var fluid, wp8;

  fluid = require('fluid');

  module.exports = wp8 = function(grunt) {
    var tasks;
    tasks = {
      buildIcons: require('./wp8/icons')(grunt).build
    };
    return {
      run: function(fn) {
        return fluid(tasks).buildIcons().go(function(err, result) {
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
