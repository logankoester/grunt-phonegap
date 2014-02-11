xmldom = require 'xmldom'
path = require 'path'

module.exports = versionCode = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  repair: (fn) ->
    dom = xmldom.DOMParser
    versionCode = helpers.config 'versionCode'
    if versionCode
      phonegapPath = helpers.config 'path'

      manifestPath = path.join phonegapPath, 'platforms', 'android', 'AndroidManifest.xml'
      manifest = grunt.file.read manifestPath
      doc = new dom().parseFromString manifest, 'text/xml'
      doc.getElementsByTagName('manifest')[0].setAttribute('android:versionCode', versionCode)
      grunt.file.write manifestPath, doc

      if fn then fn()
