(function() {
  var path, versionCode, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  module.exports = versionCode = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      repair: function(fn) {
        var data, doc, dom, manifest, manifestPath, phonegapPath;
        dom = xmldom.DOMParser;
        data = helpers.config('versionCode');
        if (data) {
          versionCode = grunt.util.kindOf(data) === 'function' ? data() : data;
          phonegapPath = helpers.config('path');
          manifestPath = path.join(phonegapPath, 'platforms', 'android', 'AndroidManifest.xml');
          manifest = grunt.file.read(manifestPath);
          doc = new dom().parseFromString(manifest, 'text/xml');
          doc.getElementsByTagName('manifest')[0].setAttribute('android:versionCode', versionCode);
          grunt.file.write(manifestPath, doc);
          if (fn) {
            return fn();
          }
        }
      }
    };
  };

}).call(this);
