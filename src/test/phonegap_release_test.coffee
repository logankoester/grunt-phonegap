grunt = require 'grunt'

exports.phonegap =
  'tree should be created': (test) ->
    test.expect 2
    test.ok grunt.file.isDir('test/releases'), 'should create the releases directory'
    test.ok grunt.file.isDir('test/releases/android'), 'should create the releases platform directory'
    test.done()

  'signed apk should be created': (test) ->
    test.expect 1
    pkg = grunt.file.readJSON 'package.json'
    filename = "#{pkg.name}-#{pkg.version}.apk"
    test.ok grunt.file.isFile("test/releases/android/#{filename}"), "should create #{filename}"
    test.done()
