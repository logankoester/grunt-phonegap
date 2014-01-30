grunt = require 'grunt'
path = require 'path'
_ = require 'lodash'
helpers = require '../../helpers'

module.exports = createTree =
  run: (platforms, fn) ->
    grunt.log.writeln 'Creating directory tree'
    phonegapPath = helpers.config 'path'

    _.each ['plugins', 'platforms', 'www', '.cordova'], (dir) ->
      grunt.file.mkdir path.join(phonegapPath, dir)

    _.each platforms, (platform) =>
      grunt.file.mkdir path.join(phonegapPath, 'merges', platform)

    if fn then fn()
