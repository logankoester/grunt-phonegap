(function() {
  var grunt, path;

  grunt = require('grunt');

  path = require('path');

  module.exports = {
    on: function(platform, fn) {
      var releaseAdapter;
      releaseAdapter = path.join(__dirname, 'release', "" + platform + ".js");
      if (grunt.file.exists(releaseAdapter)) {
        return require(releaseAdapter).release(fn);
      } else {
        grunt.warn("Missing source file '" + releaseAdapter + "'");
        return grunt.fatal("grunt-phonegap does not yet include a release adapter for platform '" + platform + "'");
      }
    }
  };

}).call(this);
