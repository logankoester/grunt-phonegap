_ = require 'lodash'
async = require 'async'

module.exports = (grunt) ->
  helpers = require('./helpers')(grunt)
  build = require('./build')(grunt)
  run = require('./run')(grunt)
  release = require('./release')(grunt)

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
    remote: {}

  grunt.registerTask 'phonegap:build', 'Build as a Phonegap application', (platform) ->
    helpers.mergeConfig defaults

    platforms = if platform then [platform] else helpers.config 'platforms'

    done = @async()
    build.run platforms, (err, result) ->
      if err then grunt.fatal err
      done()

  grunt.registerTask 'phonegap:run', 'Run a Phonegap application', ->
    helpers.mergeConfig defaults

    platform = @args[0] || _.first(grunt.config.get('phonegap.config.platforms'))
    device  = @args[1] || ''

    done = @async()
    run.run platform, device, -> done()

  grunt.registerTask 'phonegap:release', 'Create a distributable release', ->
    helpers.mergeConfig defaults
    platform = @args[0] || _.first(grunt.config.get('phonegap.config.platforms'))
    done = @async()
    release.on platform, -> done()

  grunt.registerTask 'phonegap:login', 'Log into the remote build service', ->
    helpers.mergeConfig defaults

    grunt.config.requires 'phonegap.remote.username'
    grunt.config.requires 'phonegap.remote.password'

    username = grunt.config.get 'phonegap.remote.username'
    password = grunt.config.get 'phonegap.remote.password'

    done = @async()
    cmd = "phonegap remote login --username #{username} --password #{password}"
    helpers.exec cmd, -> done()

  grunt.registerTask 'phonegap:logout', 'Log out of the remote build service', ->
    helpers.mergeConfig defaults
    done = @async()
    helpers.exec 'phonegap remote logout', -> done()
