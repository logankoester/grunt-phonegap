grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'

exports.phonegap =
  'targetSdkVersion in AndroidManifest.xml should match config.targetSdkVersion': (test) ->
    test.expect 1
    data = grunt.config.get 'phonegap.config.targetSdkVersion'
    targetSdkVersion = data() if grunt.util.kindOf(data) == 'function'
    xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
    manifest = xmlParser.toJson xml, object: true
    test.equal targetSdkVersion, manifest['manifest']['uses-sdk']['android:targetSdkVersion'], 'targetSdkVersion value should match'
    test.done()

  'minSdkVersion in AndroidManifest.xml should match config.minSdkVersion': (test) ->
    test.expect 1
    data = grunt.config.get 'phonegap.config.minSdkVersion'
    minSdkVersion = data() if grunt.util.kindOf(data) == 'function'
    xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
    manifest = xmlParser.toJson xml, object: true
    test.equal minSdkVersion, manifest['manifest']['uses-sdk']['android:minSdkVersion'], 'targetSdkVersion value should match'
    test.done()
