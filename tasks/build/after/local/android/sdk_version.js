(function() {
  var path, sdkVersion, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  module.exports = sdkVersion = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      setTarget: function(fn) {
        var doc, dom, manifest, manifestPath, phonegapPath, targetSdkVersion;
        dom = xmldom.DOMParser;
        targetSdkVersion = helpers.config('targetSdkVersion');
        if (targetSdkVersion) {
          phonegapPath = helpers.config('path');
          manifestPath = path.join(phonegapPath, 'platforms', 'android', 'AndroidManifest.xml');
          manifest = grunt.file.read(manifestPath);
          doc = new dom().parseFromString(manifest, 'text/xml');
          doc.getElementsByTagName('uses-sdk')[0].setAttribute('android:targetSdkVersion', targetSdkVersion);
          grunt.file.write(manifestPath, doc);
          if (fn) {
            return fn();
          }
        }
      }
    };
  };

}).call(this);
