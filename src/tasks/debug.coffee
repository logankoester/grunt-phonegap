path = require 'path'

module.exports = debug = (grunt) ->

  on: (platform, fn) ->
    debugAdapter = path.join __dirname, 'debug', "#{platform}.js"
    if grunt.file.exists debugAdapter
      require(debugAdapter)(grunt).debug fn
    else
      grunt.warn "Missing source file '#{debugAdapter}'"
      grunt.fatal "grunt-phonegap does not yet include a debug adapter for platform '#{platform}'"
