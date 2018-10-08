(function() {
  var debug, path;

  path = require('path');

  module.exports = debug = function(grunt) {
    return {
      on: function(platform, fn) {
        var debugAdapter;
        debugAdapter = path.join(__dirname, 'debug', `${platform}.js`);
        if (grunt.file.exists(debugAdapter)) {
          return require(debugAdapter)(grunt).debug(fn);
        } else {
          grunt.warn(`Missing source file '${debugAdapter}'`);
          return grunt.fatal(`grunt-phonegap does not yet include a debug adapter for platform '${platform}'`);
        }
      }
    };
  };

}).call(this);
