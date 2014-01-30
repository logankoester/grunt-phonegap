# The `phonegap:release:android` task will create a `releases/android` directory
# containing a signed application package ready for distribution.
#
# You will need to specify a keystore file at `phonegap.config.key.store`.

grunt = require 'grunt'
pkg = grunt.file.readJSON 'package.json'
path = require 'path'
fs = require 'fs'

exports.phonegap =
  'tree should be created': (test) ->
    test.expect 1
    test.ok grunt.file.isDir('test/releases/android'), 'should create the releases platform directory'
    test.done()

  'signed apk should be created': (test) ->
    test.expect 2
    apk = path.join 'test', 'releases', 'android', 'TestFixtureApp-0.0.0.apk'
    test.ok grunt.file.isFile(apk), "#{apk} does not exist"
    fs.stat apk, (err, stats) =>
      test.notEqual stats.size, 0, "#{apk} is an empty file"
      test.done()
