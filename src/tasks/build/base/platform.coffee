async = require 'async'
path = require 'path'

module.exports = platform = (grunt) ->

  getArgs = ->
    args = grunt.config.get('phonegap.config.args')
    if args
      return ' --' + args.map((arg) -> arg.name + '=' + arg.value).join(' --')
    else
      return ''

  helpers = require('../../helpers')(grunt)

  remote = (platform, fn) ->
    helpers.exec grunt.config.get('phonegap.config.cli') + " remote build #{platform}#{getArgs()} #{helpers.setVerbosity()}", fn

  local = (platform, fn) ->
    helpers.exec grunt.config.get('phonegap.config.cli') + " build #{platform}#{getArgs()} #{helpers.setVerbosity()}", fn

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
