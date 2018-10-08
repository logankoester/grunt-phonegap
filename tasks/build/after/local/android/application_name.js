(function() {
  var applicationName, path, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  module.exports = applicationName = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      set: function(fn) {
        var doc, dom, manifest, manifestPath, name, phonegapPath;
        dom = xmldom.DOMParser;
        name = helpers.config('androidApplicationName');
        if (name) {
          phonegapPath = helpers.config('path');
          manifestPath = path.join(phonegapPath, 'platforms', 'android', 'AndroidManifest.xml');
          manifest = grunt.file.read(manifestPath);
          grunt.log.writeln(`Setting application name in '${manifestPath}' to ${name}`);
          doc = new dom().parseFromString(manifest, 'text/xml');
          doc.getElementsByTagName('application')[0].setAttribute('android:name', name);
          grunt.file.write(manifestPath, doc);
        }
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
