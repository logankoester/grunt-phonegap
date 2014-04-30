path = require 'path'

module.exports = android = (grunt) ->
  helpers = require('../helpers')(grunt)

  copyApk = (fn) ->
    phonegapPath = helpers.config 'path'
    srcDir = path.join phonegapPath, 'platforms', 'android', 'bin'
    releaseName = helpers.config 'releaseName'
    src = grunt.file.expand("#{srcDir}/*-debug.apk")[0]
    dest = path.join helpers.config('releases'), 'android', "#{releaseName}.apk"
    grunt.file.copy src, dest, encoding: null
    fn() if fn

  antDebug = (fn) ->
    phonegapPath = helpers.config 'path'
    
    cmd = 'ant debug'
    cwd = path.join phonegapPath, 'platforms', 'android'
    helpers.exec cmd, fn, cwd

  createDebugPath = (platform) ->
    releasesPath = helpers.config 'releases'
    grunt.file.mkdir path.join(releasesPath, platform)

  debug: (fn) ->
    grunt.log.writeln 'Creating debug build for \'android\' platform'
    createDebugPath 'android'
    antDebug ->
      copyApk ->
        fn()
