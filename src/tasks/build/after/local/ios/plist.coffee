xmldom = require 'xmldom'
path = require 'path'

module.exports = plist = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  setWhiteStatusBar: (fn) ->
    dom = xmldom.DOMParser
    statusBar = helpers.config 'iosWhiteStatusBar'
    if statusBar
      phonegapPath = helpers.config 'path'
      appName = helpers.config 'name'

      plistFile = path.join phonegapPath, 'platforms', 'ios', appName, "#{appName}-Info.plist"

      plist = grunt.file.read plistFile
      grunt.log.writeln "Adding ios white status bar configuration to plist"
      doc = new dom().parseFromString plist, 'text/xml'

      newNodes = new dom().parseFromString('<key>UIStatusBarStyle</key>
      <string>UIStatusBarStyleBlackTranslucent</string>
      <key>UIViewControllerBasedStatusBarAppearance</key>
      <false/>', 'text/xml')

      doc.getElementsByTagName('dict')[0].appendChild(newNodes);

      grunt.file.write plistFile, doc

    if fn then fn()
