path = require 'path'

module.exports = icons = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  build: (fn) ->
    icons = helpers.config 'icons'
    phonegapPath = helpers.config 'path'
    res = path.join phonegapPath, 'platforms', 'wp8'

    if icons?.wp8?.app
      grunt.file.copy icons.wp8.app, path.join(res, 'ApplicationIcon.png'), encoding: null

    if icons?.wp8?.tile
      grunt.file.copy icons.wp8.tile, path.join(res, 'Background.png'), encoding: null
    if fn then fn()
