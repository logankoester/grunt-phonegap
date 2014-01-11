# Beginning with **v0.4.1**, `phonegap.config.config` may be either a string or an object.
# 
# As a string, the file is copied directly, as with previous versions.
# 
# As an object with the keys `template<String>` and `data<Object>`, the file at `template` will
# be processed using [grunt.template](http://gruntjs.com/api/grunt.template).

grunt = require 'grunt'
xmlParser = require 'xml2json'
path = require 'path'

exports.phonegap =
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
