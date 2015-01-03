path = require 'path'

module.exports = screens = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  build: (fn) ->
    screens = helpers.config 'screens'
    phonegapPath = helpers.config 'path'
    res = path.join phonegapPath, 'platforms', 'wp8'

    if screens?.wp8
      grunt.file.copy screens.wp8, path.join(res, 'SplashScreenImage.jpg'), encoding: null

    if fn then fn()
