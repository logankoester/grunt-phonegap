(function() {
  var debug, path;

  path = require('path');

  module.exports = debug = function(grunt) {
    return {
      on: function(platform, fn) {
        var releaseAdapter;
        releaseAdapter = path.join(__dirname, 'debug', "" + platform + ".js");
        if (grunt.file.exists(releaseAdapter)) {
          return require(releaseAdapter)(grunt).debug(fn);
        } else {
          grunt.warn("Missing source file '" + releaseAdapter + "'");
          return grunt.fatal("grunt-phonegap does not yet include a release adapter for platform '" + platform + "'");
        }
      }
    };
  };

}).call(this);
