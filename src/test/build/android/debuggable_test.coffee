# In Phonegap 4.3.x, the release apk is created with debuggable=true regardless
# of whether a debug certificate was used. In Phonegap 4.4.x, this has been corrected.
#
# To ensure we get the intended behavior regardless of Phonegap version,
# grunt-phonegap will post-process AndroidManifest.xml and set
# debuggable=false *UNLESS* `phonegap.config.debuggable` is set to true, in
# which case that value will be forced instead.

grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'

  exports.phonegap =
    'debuggable in AndroidManifest.xml should match config.debuggable': (test) ->
      test.expect 1
      debuggable = grunt.config.get 'phonegap.config.debuggable'
      debuggable = debuggable() if grunt.util.kindOf(debuggable) == 'function'
      xml = grunt.file.read 'test/phonegap/platforms/android/AndroidManifest.xml'
      manifest = xmlParser.toJson xml, object: true
      test.equal debuggable, manifest['manifest']['application']['android:debuggable'], 'debuggable value should match'
      test.done()
