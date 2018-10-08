# Rather than polluting the top-level of your project, `grunt-phonegap` copies
# your files into a subdirectory containing the Phonegap project, which gets
# regenerated every time the task `phonegap:build` is executed.

grunt = require 'grunt'
path = require 'path'

exports.phonegap =
  'tree should be created': (test) ->
    test.expect 6
    test.ok grunt.file.isDir('test/phonegap'), 'should create the output directory'
    test.ok grunt.file.isDir('test/phonegap/merges'), 'should create the merges directory'
    test.ok grunt.file.isDir('test/phonegap/platforms'), 'should create the platforms directory'
    test.ok grunt.file.isDir('test/phonegap/plugins'), 'should create the plugins directory'
    test.ok grunt.file.isDir('test/phonegap/www'), 'should create the www directory'
    test.ok grunt.file.isDir('test/phonegap/.cordova'), 'should create the .cordova directory'
    test.done()

  'files should be copied': (test) ->
    test.expect 2
    test.ok grunt.file.isFile('test/phonegap/www/config.xml'), 'should copy files from root'
    test.ok grunt.file.isFile('test/phonegap/.cordova/config.json'), 'should copy files from cordova'
    test.done()
