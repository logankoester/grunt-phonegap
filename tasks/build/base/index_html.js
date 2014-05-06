(function() {
  var fs, indexHtml, path;

  path = require('path');

  fs = require('fs');

  module.exports = indexHtml = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
        var html, phonegapPath;
        grunt.log.writeln('fixing index.html');
        html = helpers.config('html');
        phonegapPath = helpers.config('path');
        if (html) {
          fs.renameSync(path.join(phonegapPath, 'www', html), path.join(phonegapPath, 'www', 'index.html'));
        } else {
          console.log('config.html undefined');
        }
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
