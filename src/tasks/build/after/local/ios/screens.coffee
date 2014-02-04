path = require 'path'

module.exports = screens = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  build: (fn) ->
    screens = helpers.config 'screens'
    phonegapPath = helpers.config 'path'
    appName = helpers.config 'name'

    res = path.join phonegapPath, 'platforms', 'ios', appName, 'Resources', 'splash'

    if screens?.ios?.ipadLand?
      grunt.file.copy screens.ios.ipadLand, path.join(res, 'Default-Landscape~ipad.png'), encoding: null

    if screens?.ios?.ipadLandx2?
      grunt.file.copy screens.ios.ipadLandx2, path.join(res, 'Default-Landscape@2x~ipad.png'), encoding: null

    if screens?.ios?.ipadPortraitx2?
      grunt.file.copy screens.ios.ipadPortraitx2, path.join(res, 'Default-Portrait@2x~ipad.png'), encoding: null

    if screens?.ios?.ipadPortrait?
      grunt.file.copy screens.ios.ipadPortrait, path.join(res, 'Default-Portrait~ipad.png'), encoding: null

    if screens?.ios?.iphonePortrait?
      grunt.file.copy screens.ios.iphonePortrait, path.join(res, 'Default~iphone.png'), encoding: null

    if screens?.ios?.iphonePortraitx2?
      grunt.file.copy screens.ios.iphonePortraitx2, path.join(res, 'Default@2x~iphone.png'), encoding: null

    if screens?.ios?.iphone568hx2?
      grunt.file.copy screens.ios.iphone568hx2, path.join(res, 'Default-568h@2x~iphone.png'), encoding: null

    if fn then fn()
