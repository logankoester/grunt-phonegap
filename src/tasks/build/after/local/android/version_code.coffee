xmldom = require 'xmldom'
path = require 'path'

module.exports = versionCode = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  repair: (fn) ->
    dom = xmldom.DOMParser
    data = helpers.config 'versionCode'
    if data
      versionCode = if grunt.util.kindOf(data) == 'function' then data() else data
      phonegapPath = helpers.config 'path'

      manifestPath = path.join phonegapPath, 'platforms', 'android', 'AndroidManifest.xml'
      manifest = grunt.file.read manifestPath
      doc = new dom().parseFromString manifest, 'text/xml'
      doc.getElementsByTagName('manifest')[0].setAttribute('android:versionCode', versionCode)
      grunt.file.write manifestPath, doc

      if fn then fn()
