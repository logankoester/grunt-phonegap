grunt = require 'grunt'
xmldom = require 'xmldom'
path = require 'path'
_ = require 'lodash'
dom = xmldom.DOMParser
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'

  exports.phonegap =
    'The INTERNET permission should be removed': (test) ->
      test.expect 1

      manifest = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
      doc = new dom().parseFromString manifest, 'text/xml'
      permissions = doc.getElementsByTagName('uses-permission')

      matches = _.find permissions, (permission) ->
        permission.getAttribute('android:name') == 'android.permission.INTERNET'
      test.equal matches, undefined

      test.done()

    'The ACCESS_NETWORK_STATE permission should be added': (test) ->
      test.expect 2

      manifest = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
      doc = new dom().parseFromString manifest, 'text/xml'
      permissions = doc.getElementsByTagName('uses-permission')

      matches = _.find permissions, (permission) ->
        permission.getAttribute('android:name') == 'android.permission.ACCESS_NETWORK_STATE'
      test.ok matches
      test.equal matches.nodeName, 'uses-permission'

      test.done()

