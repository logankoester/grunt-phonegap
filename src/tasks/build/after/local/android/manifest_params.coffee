xmldom = require 'xmldom'
path = require 'path'

module.exports = applicationName = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  set: (fn) ->
    dom = xmldom.DOMParser
    manifestParams = helpers.config 'androidManifest'
    if manifestParams
      phonegapPath = helpers.config 'path'

      manifestPath = path.join phonegapPath, 'platforms', 'android', 'AndroidManifest.xml'
      manifest = grunt.file.read manifestPath
      grunt.log.writeln "Setting manifest params in '#{manifestPath}' to #{manifestParams}"
      doc = new dom().parseFromString manifest, 'text/xml'
      applicationElem = doc.getElementsByTagName('application')[0];
      applicationParams = manifestParams.application
      activityParams = manifestParams.activity
      if applicationParams 
        for key, value of applicationParams
          grunt.log.writeln "Setting manifest application param '#{key}' to #{value}"
          applicationElem.setAttribute(key, value)
      if activityParams
        for key, value of activityParams
          grunt.log.writeln "Setting manifest activity param '#{key}' to #{value}"
          applicationElem.getElementsByTagName('activity')[0].setAttribute(key, value)
      grunt.file.write manifestPath, doc

    if fn then fn()
