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
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'

  exports.phonegap =
    'android platform should be built': (test) ->
      test.expect 1
      name = grunt.config.get('phonegap.config.config.data.name')
      test.ok grunt.file.isFile("test/phonegap/platforms/android/bin/#{name}-debug.apk"), 'debug apk should be created'
      test.done()
