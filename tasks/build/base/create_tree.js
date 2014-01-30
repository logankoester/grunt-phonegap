(function() {
  var createTree, grunt, helpers, path, _;

  grunt = require('grunt');

  path = require('path');

  _ = require('lodash');

  helpers = require('../../helpers');

  module.exports = createTree = {
    run: function(platforms, fn) {
      var phonegapPath,
        _this = this;
      grunt.log.writeln('Creating directory tree');
      phonegapPath = helpers.config('path');
      _.each(['plugins', 'platforms', 'www', '.cordova'], function(dir) {
        return grunt.file.mkdir(path.join(phonegapPath, dir));
      });
      _.each(platforms, function(platform) {
        return grunt.file.mkdir(path.join(phonegapPath, 'merges', platform));
      });
      if (fn) {
        return fn();
      }
    }
  };

}).call(this);
