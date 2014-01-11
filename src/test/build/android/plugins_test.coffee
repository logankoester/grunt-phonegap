grunt = require 'grunt'
path = require 'path'

exports.phonegap =
  'android plugins should be installed': (test) ->
    test.expect 1
    test.ok grunt.file.isDir('test/phonegap/plugins/org.apache.cordova.core.device'), 'should add a local plugin'
    test.done()
