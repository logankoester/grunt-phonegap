(function() {
  var cloneCordova, copy, grunt, helpers, path;

  grunt = require('grunt');

  path = require('path');

  copy = require('directory-copy');

  helpers = require('../../helpers');

  module.exports = cloneCordova = {
    run: function(fn) {
      var cordovaPath, phonegapPath,
        _this = this;
      grunt.log.writeln('Cloning .cordova directory');
      cordovaPath = helpers.config('cordova');
      phonegapPath = helpers.config('path');
      return copy({
        src: cordovaPath,
        dest: path.join(phonegapPath, '.cordova')
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
