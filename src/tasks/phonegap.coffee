#
# * grunt-phonegap
# * https://github.com/logankoester/grunt-phonegap
# *
# * Copyright (c) 2013 Logan Koester
# * Licensed under the MIT license.
#

module.exports = (grunt) ->
  Build = require('./build').Build
  Run = require('./run').Run

  _ = grunt.util._
  async = grunt.util.async
  async.eachSeries = require('async').eachSeries

  defaults =
    root: 'www'
    path: 'build'
    cordova: '.cordova'
    releases: 'releases'
    plugins: []
    platforms: []
    verbose: false

  grunt.registerTask 'phonegap:build', 'Build as a Phonegap application', ->
    # Set default options
    config = _.defaults grunt.config.get('phonegap.config'), defaults


    done = @async()
    build = new Build(grunt, config).clean().buildTree()

    async.series [
      build.cloneRoot,
      build.cloneCordova
    ], ->
      async.eachSeries config.plugins, build.addPlugin, (err) ->
        async.eachSeries config.platforms, build.buildPlatform, (err) ->
          done()

  grunt.registerTask 'phonegap:run', 'Run a Phonegap application', ->
    # Set default options
    config = _.defaults grunt.config.get('phonegap.config'), defaults

    platform = @args[0] || _.first(config.platforms)
    device  = @args[1] || 'device'

    done = @async()
    build = new Run(grunt, config).run platform, device, -> done()
