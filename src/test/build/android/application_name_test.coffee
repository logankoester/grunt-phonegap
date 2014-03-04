grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'
  exports.phonegap =
    '<application android:name> in AndroidManifest.xml should match config.androidApplicationName': (test) ->
      test.expect 1
      data = grunt.config.get 'phonegap.config.androidApplicationName'

      if grunt.util.kindOf(data) == 'function'
        androidApplicationName = data()
      else
        androidApplicationName = data

      xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
      manifest = xmlParser.toJson xml, object: true
      test.equal androidApplicationName, manifest['manifest']['application']['android:name'], 'android:name value should match'
      test.done()
