path = require 'path'

module.exports = debug = (grunt) ->

  on: (platform, fn) ->
    releaseAdapter = path.join __dirname, 'debug', "#{platform}.js"
    if grunt.file.exists releaseAdapter
      require(releaseAdapter)(grunt).debug fn
    else
      grunt.warn "Missing source file '#{releaseAdapter}'"
      grunt.fatal "grunt-phonegap does not yet include a release adapter for platform '#{platform}'"
