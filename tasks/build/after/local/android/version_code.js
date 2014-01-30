(function() {
  var grunt, helpers, path, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  grunt = require('grunt');

  helpers = require('../../../../helpers');

  module.exports = {
    repair: function(fn) {
      var data, doc, dom, manifest, manifestPath, phonegapPath, versionCode;
      dom = xmldom.DOMParser;
      data = helpers.config('versionCode');
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
  };

}).call(this);
