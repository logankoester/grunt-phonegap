module.exports = clean = (grunt) ->
  helpers = require('../../helpers')(grunt)

  run: (fn) ->
    path = helpers.config 'path'
    grunt.log.writeln "Cleaning #{path}"
    helpers.clean(path)
    if fn then fn()
