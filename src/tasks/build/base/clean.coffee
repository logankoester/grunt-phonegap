grunt = require 'grunt'
helpers = require '../../helpers'

module.exports = clean =
  run: (fn) ->
    path = helpers.config 'path'
    grunt.log.writeln "Cleaning #{path}"
    helpers.clean(path)
    if fn then fn()
