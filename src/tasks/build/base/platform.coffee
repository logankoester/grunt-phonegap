async = require 'async'
path = require 'path'

module.exports = platform = (grunt) ->
  helpers = require('../../helpers')(grunt)

  remote = (platform, fn) ->
    helpers.exec "phonegap remote build #{platform} #{helpers.setVerbosity()}", fn

  local = (platform, fn) ->
    helpers.exec "phonegap build #{platform} #{helpers.setVerbosity()}", fn

  runAfter = (provider, platform, fn) ->
    adapter = path.join __dirname, '..', 'after', provider, "#{platform}.js"
    if grunt.file.exists adapter
      require(adapter)(grunt).run(fn)
    else
      grunt.log.writeln "No post-build tasks at '#{adapter}'"
      if fn then fn()

  buildPlatform = (platform, fn) ->
    if helpers.isRemote(platform)
      remote platform, ->
        runAfter 'remote', platform, fn
    else
      local platform, ->
        runAfter 'local', platform, fn

  build: (platforms, fn) ->
    grunt.log.writeln 'Building platforms'
    async.eachSeries platforms, buildPlatform, (err) ->
      if fn then fn err
