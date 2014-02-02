path = require 'path'

module.exports = icons = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  build: (fn) ->
    icons = helpers.config 'icons'
    phonegapPath = helpers.config 'path'
    appName = helpers.config 'name'

    res = path.join phonegapPath, 'platforms', 'ios', appName, 'Resources', 'icons'

    if icons?.ios?.icon29
      grunt.file.copy icons.ios.icon29, path.join(res, 'icon-small.png'), encoding: null

    if icons?.ios?.icon29x2
      grunt.file.copy icons.ios.icon29x2, path.join(res, 'icon-small@2x.png'), encoding: null

    if icons?.ios?.icon40
      grunt.file.copy icons.ios.icon40, path.join(res, 'icon-40.png'), encoding: null

    if icons?.ios?.icon40x2
      grunt.file.copy icons.ios.icon40x2, path.join(res, 'icon-40@2x.png'), encoding: null

    if icons?.ios?.icon57
      grunt.file.copy icons.ios.icon57, path.join(res, 'icon.png'), encoding: null

    if icons?.ios?.icon57x2
      grunt.file.copy icons.ios.icon57x2, path.join(res, 'icon@2x.png'), encoding: null

    if icons?.ios?.icon60x2
      grunt.file.copy icons.ios.icon60x2, path.join(res, 'icon-60@2x.png'), encoding: null

    if icons?.ios?.icon72
      grunt.file.copy icons.ios.icon72, path.join(res, 'icon-72.png'), encoding: null

    if icons?.ios?.icon72x2
      grunt.file.copy icons.ios.icon72x2, path.join(res, 'icon-72@2x.png'), encoding: null

    if icons?.ios?.icon76
      grunt.file.copy icons.ios.icon76, path.join(res, 'icon-76.png'), encoding: null

    if icons?.ios?.icon76x2
      grunt.file.copy icons.ios.icon76x2, path.join(res, 'icon-76@2x.png'), encoding: null

    if fn then fn()
