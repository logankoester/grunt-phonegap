grunt = require 'grunt'
path = require 'path'
helpers = require '../helpers'

copyApk = (fn) ->
  phonegapPath = helpers.config 'path'
  srcDir = path.join phonegapPath, 'platforms', 'android', 'bin'
  releaseName = helpers.config 'releaseName'
  src = grunt.file.expand("#{srcDir}/*-release.apk")[0]
  dest = path.join helpers.config('releases'), 'android', "#{releaseName}.apk"
  grunt.file.copy src, dest, encoding: null
  fn() if fn

setAntProperties = (includePasswords) ->
  key = helpers.config 'key'
  keyStorePath = path.relative platformPath('android'), key.store
  properties = []
  properties.push "key.store=#{keyStorePath}"
  properties.push "key.store=#{if path.sep == '\\' then keyStorePath.replace /\\/g, '\\\\' else keyStorePath}" # Path must be escaped in the file as well
  properties.push "key.alias=#{key.alias}"

  if includePasswords
    properties.push "key.store.password=#{key.storePassword()}"
    properties.push "key.alias.password=#{key.aliasPassword()}"

  grunt.file.write antPropertiesFile(), properties.join("\n")

antRelease = (fn) ->
  phonegapPath = helpers.config 'path'
  keyStore = helpers.config 'key.store'

  helpers.ensureExists keyStore, 'You need to create a keystore file to generate a signed release (see http://developer.android.com/tools/publishing/app-signing.html)'
  cmd = 'ant release'
  cwd = path.join phonegapPath, 'platforms', 'android'
  helpers.exec cmd, fn, cwd

platformPath = (platform) ->
  path.join helpers.config('path'), 'platforms', 'android'

antPropertiesFile = ->
  path.join platformPath('android'), 'ant.properties'

createReleasesPath = (platform) ->
  releasesPath = helpers.config 'releases'
  grunt.file.mkdir path.join(releasesPath, platform)

module.exports =
  release: (fn) ->
    grunt.log.writeln 'Creating release for \'android\' platform'
    createReleasesPath 'android'
    setAntProperties true
    antRelease ->
      copyApk ->
        setAntProperties false # Scrub passwords
        fn()
