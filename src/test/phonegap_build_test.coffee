grunt = require('grunt')

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

  'plugins should be installed': (test) ->
    test.expect 1
    test.ok grunt.file.isDir('test/phonegap/plugins/org.apache.cordova.core.device'), 'should add a local plugin'
    test.done()

  'plugins can accept variables': (test) ->
    test.expect 2
    test.ok phonegap.config.plugins.length
    test.done()

  'android platform should be built': (test) ->
    test.expect 1
    test.ok grunt.file.isFile('test/phonegap/platforms/android/bin/HelloWorld-debug.apk'), 'debug apk should be created'
    test.done()

  'custom config location should be copied': (test) ->
    test.expect 1
    test.ok grunt.file.isFile('test/phonegap/www/config.xml'), 'custom_config.xml should be copied to config.xml'
    test.done()
