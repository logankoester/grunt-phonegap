# If you set a `phonegap.config.versionCode` value (function or literal), `grunt phonegap:build` will post-process the generated
# `AndroidManifest.xml` file and set it for you.

grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'

exports.phonegap =
  'versionCode in AndroidManifest.xml should match config.versionCode': (test) ->
    test.expect 1
    data = grunt.config.get 'phonegap.config.versionCode'
    versionCode = data() if grunt.util.kindOf(data) == 'function'
    xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
    manifest = xmlParser.toJson xml, object: true
    test.equal versionCode, manifest['manifest']['android:versionCode'], 'versionCode value should match'
    test.done()
