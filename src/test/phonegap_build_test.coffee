grunt = require 'grunt'
xmlParser = require 'xml2json'
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

  'plugins should be installed': (test) ->
    test.expect 1
    test.ok grunt.file.isDir('test/phonegap/plugins/org.apache.cordova.core.device'), 'should add a local plugin'
    test.done()

  'android platform should be built': (test) ->
    test.expect 1
    name = grunt.config.get('phonegap.config.config.data.name')
    test.ok grunt.file.isFile("test/phonegap/platforms/android/bin/#{name}-debug.apk"), 'debug apk should be created'
    test.done()

  'the specified config.xml template should be compiled': (test) ->
    test.expect 1
    test.ok grunt.file.isFile('test/phonegap/www/config.xml'), 'a file should be written to config.xml'
    test.done()

  'configData should be interpolated in config.xml': (test) ->
    test.expect 2
    data = grunt.config.get('phonegap.config.config.data')
    xml = grunt.file.read 'test/phonegap/www/config.xml'
    config = xmlParser.toJson xml, object: true
    test.equal config.widget.id, data.id, 'id should match config.id'
    test.equal config.widget.version, data.version, 'version should match config.version'
    test.done()
