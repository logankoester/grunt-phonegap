# The `phonegap:release:[:platform]` task will create a releases/ directory
# containing a signed application package ready for distribution.
#
# Currently `android` is the only platform supported by this task.

grunt = require 'grunt'
path = require 'path'

exports.phonegap =
  'tree should be created': (test) ->
    test.expect 1
    test.ok grunt.file.isDir('test/releases'), 'should create the releases directory'
    test.done()
