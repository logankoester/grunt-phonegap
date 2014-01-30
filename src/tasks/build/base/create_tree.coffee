path = require 'path'
_ = require 'lodash'

module.exports = createTree = (grunt) ->
  helpers = require('../../helpers')(grunt)

  run: (platforms, fn) ->
    grunt.log.writeln 'Creating directory tree'
    phonegapPath = helpers.config 'path'

    _.each ['plugins', 'platforms', 'www', '.cordova'], (dir) ->
      grunt.file.mkdir path.join(phonegapPath, dir)

    _.each platforms, (platform) =>
      grunt.file.mkdir path.join(phonegapPath, 'merges', platform)

    if fn then fn()
