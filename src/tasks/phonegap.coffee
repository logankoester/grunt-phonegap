module.exports = (grunt) ->
  Build = require('./build').Build
  Run = require('./run').Run

  _ = grunt.util._
  async = grunt.util.async
  async.eachSeries = require('async').eachSeries

  defaults =
    root: 'www'
    config: 'www/config.xml'
    path: 'build'
    cordova: '.cordova'
    releases: 'releases'
    plugins: []
    platforms: []
    maxBuffer: 200
    verbose: false

  grunt.registerTask 'phonegap:build', 'Build as a Phonegap application', ->
    # Set default options
    config = _.defaults grunt.config.get('phonegap.config'), defaults


    done = @async()
    build = new Build(grunt, config).clean().buildTree()

    async.series [
      build.cloneRoot,
      build.cloneCordova,
      build.copyConfig
    ], ->
      async.eachSeries config.plugins, build.addPlugin, (err) ->
        async.eachSeries config.platforms, build.buildPlatform, (err) ->
          done()

  grunt.registerTask 'phonegap:run', 'Run a Phonegap application', ->
    # Set default options
    config = _.defaults grunt.config.get('phonegap.config'), defaults

    platform = @args[0] || _.first(config.platforms)
    device  = @args[1] || ''

    done = @async()
    build = new Run(grunt, config).run platform, device, -> done()
