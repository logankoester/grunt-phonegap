(function() {
  var path, plist, xmldom;

  xmldom = require('xmldom');

  path = require('path');

  module.exports = plist = function(grunt) {
    var helpers;
    helpers = require('../../../../helpers')(grunt);
    return {
      setStatusBar: function(fn) {
        var appName, doc, dom, newNodes, phonegapPath, plistFile, statusBar;
        dom = xmldom.DOMParser;
        statusBar = helpers.config('iosStatusBar');
        if (statusBar === 'WhiteAndTransparent') {
          phonegapPath = helpers.config('path');
          appName = helpers.config('name');
          plistFile = path.join(phonegapPath, 'platforms', 'ios', appName, "" + appName + "-Info.plist");
          plist = grunt.file.read(plistFile);
          grunt.log.writeln("Adding ios white status bar configuration to plist");
          doc = new dom().parseFromString(plist, 'text/xml');
          newNodes = new dom().parseFromString('<key>UIStatusBarStyle</key> <string>UIStatusBarStyleBlackTranslucent</string> <key>UIViewControllerBasedStatusBarAppearance</key> <false/>', 'text/xml');
          doc.getElementsByTagName('dict')[0].appendChild(newNodes);
          grunt.file.write(plistFile, doc);
        }
        if (fn) {
          return fn();
        }
      }
    };
  };

}).call(this);
