xmldom = require 'xmldom'
path = require 'path'

module.exports = sdkVersion = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  setTarget: (fn) ->
    dom = xmldom.DOMParser
    targetSdkVersion = helpers.config 'targetSdkVersion'
    if targetSdkVersion
      phonegapPath = helpers.config 'path'

      manifestPath = path.join phonegapPath, 'platforms', 'android', 'AndroidManifest.xml'
      manifest = grunt.file.read manifestPath
      doc = new dom().parseFromString manifest, 'text/xml'
      doc.getElementsByTagName('uses-sdk')[0].setAttribute('android:targetSdkVersion', targetSdkVersion)
      grunt.file.write manifestPath, doc

      if fn then fn()
