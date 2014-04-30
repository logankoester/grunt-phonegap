# The `phonegap:debug:[:platform]` task will create a releases/debug directory
# containing an application package with debugging enabled.
#
# Currently `android` is the only platform supported by this task.

grunt = require 'grunt'
pkg = grunt.file.readJSON 'package.json'
path = require 'path'
fs = require 'fs'
helpers = require(path.join __dirname, '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'

  exports.phonegap =
    'tree should be created': (test) ->
      test.expect 1
      test.ok grunt.file.isDir('test/releases/debug/android'), 'should create the debug releases platform directory'
      test.done()

    'unsigned apk should be created': (test) ->
      test.expect 2
      
      apk = path.join 'test', 'phonegap', 'platforms', 'android', 'bin', 'TestFixtureApp-debug.apk'
      test.ok grunt.file.isFile(apk), "#{apk} does not exist"
      fs.stat apk, (err, stats) =>
        test.notEqual stats.size, 0, "#{apk} is an empty file"
        test.done()

    'unsigned apk should be copied': (test) ->
      test.expect 2
      
      apk = path.join 'test', 'releases', 'debug', 'android', 'TestFixtureApp-0.0.0.apk'
      test.ok grunt.file.isFile(apk), "#{apk} does not exist"
      fs.stat apk, (err, stats) =>
        test.notEqual stats.size, 0, "#{apk} is an empty file"
        test.done()
