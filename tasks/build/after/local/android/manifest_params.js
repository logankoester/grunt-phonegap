(function() {
  var applicationName, path, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  module.exports = applicationName = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      set: function(fn) {
        var activityParams, applicationElem, applicationParams, doc, dom, key, manifest, manifestParams, manifestPath, phonegapPath, value;
        dom = xmldom.DOMParser;
        manifestParams = helpers.config('androidManifest');
        if (manifestParams) {
          phonegapPath = helpers.config('path');
          manifestPath = path.join(phonegapPath, 'platforms', 'android', 'AndroidManifest.xml');
          manifest = grunt.file.read(manifestPath);
          grunt.log.writeln("Setting manifest params in '" + manifestPath + "' to " + manifestParams);
          doc = new dom().parseFromString(manifest, 'text/xml');
          applicationElem = doc.getElementsByTagName('application')[0];
          applicationParams = manifestParams.application;
          activityParams = manifestParams.activity;
          if (applicationParams) {
            for (key in applicationParams) {
              value = applicationParams[key];
              grunt.log.writeln("Setting manifest application param '" + key + "' to " + value);
              applicationElem.setAttribute(key, value);
            }
          }
          if (activityParams) {
            for (key in activityParams) {
              value = activityParams[key];
              grunt.log.writeln("Setting manifest activity param '" + key + "' to " + value);
              applicationElem.getElementsByTagName('activity')[0].setAttribute(key, value);
            }
          }
          grunt.file.write(manifestPath, doc);
        }
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
