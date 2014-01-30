(function() {
  var cloneRoot, copy, grunt, helpers, path;

  grunt = require('grunt');

  path = require('path');

  copy = require('directory-copy');

  helpers = require('../../helpers');

  module.exports = cloneRoot = {
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

}).call(this);
