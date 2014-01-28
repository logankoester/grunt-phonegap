module.exports = (grunt) ->
  _ = require 'lodash'
  async = require 'async'

  defaults =
    root: 'www'
    config: 'www/config.xml'
    path: 'build'
    cordova: '.cordova'
    plugins: []
    platforms: []
    maxBuffer: 200
    verbose: false
    releases: 'releases'
    releaseName: ->
      pkg = grunt.file.readJSON 'package.json'
      "#{pkg.name}-#{pkg.version}"
    key:
      store: 'release.keystore'
      alias: 'release'
      aliasPassword: -> ''
      storePassword: -> ''
    versionCode: -> 1

  grunt.registerTask 'phonegap:build', 'Build as a Phonegap application', (platform) ->
    Build = require('./build').Build

    # Set default options
    config = _.defaults grunt.config.get('phonegap.config'), defaults

    done = @async()
    build = new Build(grunt, config).clean().buildTree()
    platforms = if platform then [platform] else config.platforms

    async.series [
      build.cloneRoot,
      build.cloneCordova,
      build.compileConfig
    ], ->
      async.eachSeries config.plugins, build.addPlugin, (err) ->
        async.eachSeries platforms, build.buildPlatform, (err) ->
          async.eachSeries platforms, build.postProcessPlatform, ->
            async.eachSeries platforms, build.buildIcons, (err) ->
              async.eachSeries platforms, build.buildScreens, (err) ->
                done()

  grunt.registerTask 'phonegap:run', 'Run a Phonegap application', ->
    Run = require('./run').Run

    # Set default options
    config = _.defaults grunt.config.get('phonegap.config'), defaults

    platform = @args[0] || _.first(config.platforms)
    device  = @args[1] || ''

    done = @async()
    build = new Run(grunt, config).run platform, device, -> done()

  grunt.registerTask 'phonegap:release', 'Create a distributable release', ->
    release = require('./release').release

    # Set default options
    config = _.defaults grunt.config.get('phonegap.config'), defaults

    platform = @args[0] || _.first(config.platforms)

    done = @async()
    release grunt, config, platform, -> done()
