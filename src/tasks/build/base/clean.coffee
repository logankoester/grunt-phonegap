module.exports = clean = (grunt) ->
  helpers = require('../../helpers')(grunt)

  run: (fn) ->
    path = helpers.config 'path'
    grunt.file.mkdir path unless grunt.file.exists path
    grunt.log.writeln "Cleaning #{path}"
    helpers.clean(path)
    if fn then fn()
