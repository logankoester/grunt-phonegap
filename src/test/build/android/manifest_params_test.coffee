grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'
  exports.phonegap =
    '<application ?param?> in AndroidManifest.xml should match config.androidManifest': (test) ->
      test.expect 2
      data = grunt.config.get 'phonegap.config.androidManifest'

      if grunt.util.kindOf(data) == 'function'
        androidManifest = data()
      else
        androidManifest = data

      xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
      manifest = xmlParser.toJson xml, object: true
      for key, value of androidManifest.application
        test.equal value, manifest['manifest']['application'][key], 'application ' + key + ' value should match'
      for key, value of androidManifest.activity
        test.equal value, manifest['manifest']['application']['activity'][key], 'activity ' + key + ' value should match'
      test.done()
