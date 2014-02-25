(function() {
  var path, permissions, xmldom, _;

  _ = require('lodash');

  xmldom = require('xmldom');

  path = require('path');

  module.exports = permissions = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      set: function(fn) {
        var doc, dom, manifest, manifestElement, manifestPath, phonegapPath;
        dom = xmldom.DOMParser;
        permissions = helpers.config('permissions');
        if (permissions) {
          phonegapPath = helpers.config('path');
          manifestPath = path.join(phonegapPath, 'platforms', 'android', 'AndroidManifest.xml');
          manifest = grunt.file.read(manifestPath);
          grunt.log.writeln("Adding permissions to '" + manifestPath + "'");
          doc = new dom().parseFromString(manifest, 'text/xml');
          _.each(doc.getElementsByTagName('uses-permission'), function(el) {
            return el.parentNode.removeChild(el);
          });
          manifestElement = doc.getElementsByTagName('manifest').item(0);
          _.each(permissions, function(permission) {
            var p;
            p = doc.createElement('uses-permission');
            p.setAttribute('android:name', "android.permission." + permission);
            return manifestElement.appendChild(p);
          });
          grunt.file.write(manifestPath, doc);
        }
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
