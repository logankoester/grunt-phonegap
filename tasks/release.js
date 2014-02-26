(function() {
  var path, release;

  path = require('path');

  module.exports = release = function(grunt) {
    return {
      on: function(platform, fn) {
        var releaseAdapter;
        releaseAdapter = path.join(__dirname, 'release', "" + platform + ".js");
        if (grunt.file.exists(releaseAdapter)) {
          return require(releaseAdapter)(grunt).release(fn);
        } else {
          grunt.warn("Missing source file '" + releaseAdapter + "'");
          return grunt.fatal("grunt-phonegap does not yet include a release adapter for platform '" + platform + "'");
        }
      }
    };
  };

}).call(this);
