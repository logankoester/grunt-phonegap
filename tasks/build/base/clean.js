(function() {
  var clean;

  module.exports = clean = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var path;
        path = helpers.config('path');
        grunt.log.writeln("Cleaning " + path);
        helpers.clean(path);
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
