# The `phonegap:debug:[:platform]` task will create a releases/ directory
# containing an application package with debugging enabled.
#
# Currently `android` is the only platform supported by this task.

grunt = require 'grunt'
path = require 'path'
helpers = require(path.join __dirname, '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'

  exports.phonegap =
    'tree should be created': (test) ->
      test.expect 1
      test.ok grunt.file.isDir('test/phonegap/platforms/android/bin'), 'should create the debug release directory'
      test.done()
