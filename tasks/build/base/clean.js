(function() {
  var clean, grunt, helpers;

  grunt = require('grunt');

  helpers = require('../../helpers');

  module.exports = clean = {
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

}).call(this);
