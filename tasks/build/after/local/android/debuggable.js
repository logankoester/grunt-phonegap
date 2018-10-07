(function() {
  // In Phonegap 4.3.x, the release apk is created with debuggable=true regardless
  // of whether a debug certificate was used. In Phonegap 4.4.x, this has been corrected.

  // To ensure we get the intended behavior regardless of Phonegap version,
  // grunt-phonegap will post-process AndroidManifest.xml and set
  // debuggable=false *UNLESS* `phonegap.config.debuggable` is set to true, in
  // which case that value will be forced instead.
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
        grunt.log.writeln(`Setting debuggable in '${manifestPath}' to ${debuggable}`);
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
