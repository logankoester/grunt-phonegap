grunt = require 'grunt'
path = require 'path'

module.exports =
  on: (platform, fn) ->
    releaseAdapter = path.join __dirname, 'release', "#{platform}.js"
    if grunt.file.exists releaseAdapter
      require(releaseAdapter).release fn
    else
      grunt.warn "Missing source file '#{releaseAdapter}'"
      grunt.fatal "grunt-phonegap does not yet include a release adapter for platform '#{platform}'"
