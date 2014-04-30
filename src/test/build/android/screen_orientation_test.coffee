grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'

  exports.phonegap =
    '<activity android:screenOrientation> in AndroidManifest.xml should match config.screenOrientation': (test) ->
      test.expect 1
      data = grunt.config.get 'phonegap.config.screenOrientation'
      screenOrientation = if grunt.util.kindOf(data) == 'function' then data() else data
      xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
      manifest = xmlParser.toJson xml, object: true
      manifestActivityScreenOrientation = manifest['manifest']['application']['activity']['android:screenOrientation']
      test.equal screenOrientation, manifestActivityScreenOrientation, 'android:screenOrientation value should match'
      test.done()
