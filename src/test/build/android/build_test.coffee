# When `phonegap:build` is executed and the `phonegap.config.platforms` array
# includes `'android'`, a debug build (APK file) for Android should be created.
#
# Your system (Linux, Windows, or OS X are supported) must have the Android SDK installed.
# @see http://docs.phonegap.com/en/edge/guide_platforms_android_index.md.html#Android%20Platform%20Guide
# @see http://developer.android.com/sdk/index.html
#
# If you set a `phonegap.config.versionCode` value (function or literal), `grunt phonegap:build` will post-process the generated
# `AndroidManifest.xml` file and set it for you.

grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'

exports.phonegap =
  'android platform should be built': (test) ->
    test.expect 1
    name = grunt.config.get('phonegap.config.config.data.name')
    test.ok grunt.file.isFile("test/phonegap/platforms/android/bin/#{name}-debug.apk"), 'debug apk should be created'
    test.done()

  'versionCode in AndroidManifest.xml should match config.versionCode': (test) ->
    test.expect 1
    data = grunt.config.get 'phonegap.config.versionCode'
    versionCode = data() if grunt.util.kindOf(data) == 'function'
    xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
    manifest = xmlParser.toJson xml, object: true
    test.equal versionCode, manifest['manifest']['android:versionCode'], 'versionCode value should match'
    test.done()

  'targetSdkVersion in AndroidManifest.xml should match config.targetSdkVersion': (test) ->
    test.expect 1
    data = grunt.config.get 'phonegap.config.targetSdkVersion'
    targetSdkVersion = data() if grunt.util.kindOf(data) == 'function'
    xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
    manifest = xmlParser.toJson xml, object: true
    test.equal targetSdkVersion, manifest['manifest']['uses-sdk']['android:targetSdkVersion'], 'targetSdkVersion value should match'
    test.done()
