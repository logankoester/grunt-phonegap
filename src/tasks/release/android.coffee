module.exports = exports = class ReleaseAndroid
  cp: require 'cp'
  path: require 'path'
  exec: require('child_process').exec

  constructor: (@grunt, @config) ->
    @file = @grunt.file
    @log = @grunt.log
    @warn = @grunt.warn
    @fatal = @grunt.fatal

  release: (fn) ->
    @setAntProperties true
    @antRelease =>
      @copyApk =>
        @setAntProperties false # Scrub passwords
        fn()

  copyApk: (fn) ->
    src = @path.join @config.path, 'platforms', 'android', 'bin', '*-release.apk'
    dest = @path.join @config.releases, 'android', "#{@config.releaseName()}.apk"
    @cp src, dest, -> fn() if fn

  setAntProperties: (includePasswords) ->
    keyStorePath = @path.relative @_platformPath('android'), @config.key.store
    properties = []
    properties.push "key.store=#{keyStorePath}"
    properties.push "key.alias=#{@config.key.alias}"

    if includePasswords
      properties.push "key.store.password=#{@config.key.storePassword()}"
      properties.push "key.alias.password=#{@config.key.aliasPassword()}"

    @file.write @_antPropertiesFile(), properties.join("\n")

  antRelease: (fn) ->
    @_ensureExists @config.key.store, 'You need to create a keystore file to generate a signed release (see http://developer.android.com/tools/publishing/app-signing.html)'
    cmd = 'ant release'
    cwd = @path.join @config.path, 'platforms', 'android'
    childProcess = @exec cmd, cwd: cwd, (err, stdout, stderr) =>
      @fatal err if err
      fn(err) if fn

    childProcess.stdout.on 'data', (out) => @log.write out
    childProcess.stderr.on 'data', (err) => @fatal err

  _platformPath: (platform) ->
    @path.join @config.path, 'platforms', 'android'

  _antPropertiesFile: ->
    @path.join @_platformPath('android'), 'ant.properties'

  _ensureExists: (path, failMessage)->
    failMessage ||= "\"#{path}\" does not exist."
    if @grunt.file.exists(@config.key.store)
      true
    else
      @fatal failMessage
      false
