grunt = require 'grunt'
path = require 'path'
cp = require 'cp'
helpers = require '../../helpers'

module.exports = compileConfig =
  run: (fn) ->
    grunt.log.writeln 'Compiling config.xml'
    phonegapPath = helpers.config 'path'
    configXml = helpers.config 'config'

    dest = path.join phonegapPath, 'www', 'config.xml'

    if grunt.util.kindOf(configXml) == 'string'
      grunt.logc.writeln "Copying static #{configXml}"
      cp configXml, dest, (err) ->
        if fn then fn(err)

    else
      grunt.log.writeln "Compiling template #{configXml.template}"
      template = grunt.file.read configXml.template
      compiled = grunt.template.process template, data: configXml.data
      grunt.file.write dest, compiled
      if fn then fn()
