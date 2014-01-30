(function() {
  var fluid, grunt, tasks;

  fluid = require('fluid');

  grunt = require('grunt');

  tasks = {
    buildIcons: require('./wp8/icons').build
  };

  module.exports = {
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

}).call(this);
