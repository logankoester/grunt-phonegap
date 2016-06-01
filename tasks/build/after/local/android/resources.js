(function() {
  var path, resources;

  path = require('path');

  module.exports = resources = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      build: function(fn) {
        var dest, phonegapPath, resource, _i, _len, _ref;
        resources = helpers.config('resources');
        phonegapPath = helpers.config('path');
        dest = path.join(phonegapPath, 'platforms', 'android');
        if (resources != null ? resources.android : void 0) {
          _ref = resources != null ? resources.android : void 0;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            resource = _ref[_i];
            console.log('resource from:' + resource.from + ", to:" + resource.to);
            grunt.file.recurse(resource.from, function(file, root, filepath, filename) {
              console.log("copying " + file + "," + root + "," + filepath + "," + filename);
              if (filepath) {
                return grunt.file.copy(file, path.join(dest, resource.to, filepath, filename));
              } else {
                return grunt.file.copy(file, path.join(dest, resource.to, filename));
              }
            });
          }
        }
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
