(function() {
  var clean;

  module.exports = clean = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var cleanBeforeBuild, path;
        path = helpers.config('path');
        cleanBeforeBuild = helpers.config('cleanBeforeBuild');
        if (!grunt.file.exists(path)) {
          grunt.file.mkdir(path);
        }
        if (cleanBeforeBuild) {
          grunt.log.writeln("Cleaning " + path);
          helpers.clean(path);
        }
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
