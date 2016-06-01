(function() {
  var cloneRoot, ncp, path;

  path = require('path');

  ncp = require('ncp').ncp;

  module.exports = cloneRoot = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var phonegapPath, rootPath;
        grunt.log.writeln('Cloning root directory');
        rootPath = helpers.config('root');
        phonegapPath = helpers.config('path');
        return ncp(rootPath, path.join(phonegapPath, 'www'), {
          stopOnError: true
        }, (function(_this) {
          return function(err) {
            if (err) {
              grunt.warn(err);
            }
            if (fn) {
              return fn(err);
            }
          };
        })(this));
      }
    };
  };

}).call(this);
