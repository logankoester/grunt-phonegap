(function() {
  var applicationName, path, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  module.exports = applicationName = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      set: function(fn) {
        var debuggable, doc, dom, manifest, manifestPath, phonegapPath;
        dom = xmldom.DOMParser;
        debuggable = helpers.config('debuggable');
        phonegapPath = helpers.config('path');
        manifestPath = path.join(phonegapPath, 'platforms', 'android', 'AndroidManifest.xml');
        manifest = grunt.file.read(manifestPath);
        grunt.log.writeln("Setting debuggable in '" + manifestPath + "' to " + debuggable);
        doc = new dom().parseFromString(manifest, 'text/xml');
        doc.getElementsByTagName('application')[0].setAttribute('android:debuggable', debuggable);
        grunt.file.write(manifestPath, doc);
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
