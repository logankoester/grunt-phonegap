(function() {
  var cloneRoot, copy, path;

  path = require('path');

  copy = require('directory-copy');

  module.exports = cloneRoot = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var phonegapPath, rootPath,
          _this = this;
        grunt.log.writeln('Cloning root directory');
        rootPath = helpers.config('root');
        phonegapPath = helpers.config('path');
        return copy({
          src: rootPath,
          dest: path.join(phonegapPath, 'www')
        }, function(err) {
          if (err) {
            grunt.warn(err);
          }
          if (fn) {
            return fn(err);
          }
        });
      }
    };
  };

}).call(this);
