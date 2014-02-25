_ = require 'lodash'
xmldom = require 'xmldom'
path = require 'path'

module.exports = permissions = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  set: (fn) ->
    dom = xmldom.DOMParser
    permissions = helpers.config 'permissions'
    if permissions
      phonegapPath = helpers.config 'path'

      manifestPath = path.join phonegapPath, 'platforms', 'android', 'AndroidManifest.xml'
      manifest = grunt.file.read manifestPath
      grunt.log.writeln "Adding permissions to '#{manifestPath}'"
      doc = new dom().parseFromString manifest, 'text/xml'

      # Remove existing permissions (added by Cordova + plugins). You should add these
      # back in your grunt-phonegap config, unless you are absolutely sure you want to remove them.
      _.each doc.getElementsByTagName('uses-permission'), (el) ->
        el.parentNode.removeChild(el)

      manifestElement = doc.getElementsByTagName('manifest').item(0)
      _.each permissions, (permission) ->
        p = doc.createElement('uses-permission')
        p.setAttribute('android:name', "android.permission.#{permission}")
        manifestElement.appendChild p

      grunt.file.write manifestPath, doc

    if fn then fn()
