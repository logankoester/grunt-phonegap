path = require 'path'
grunt = require 'grunt'
helpers = require '../../../../helpers'

module.exports =
  build: (fn) ->
    icons = helpers.config 'icons'
    phonegapPath = helpers.config 'path'
    res = path.join phonegapPath, 'platforms', 'android', 'res'
    best = null

    if icons?.ldpi || icons?.mdpi || icons?.hdpi || icons?.xhdpi
      grunt.warn "`phonegap.config.icons` has moved to `phonegap.config.icons.<platform>`.\nCheck the example in the grunt-phonegap README and update your Gruntfile accordingly.\n"
      icons.android = icons

    if icons?.android?.ldpi
      best = icons.android.ldpi
      grunt.file.copy icons.android.ldpi, path.join(res, 'drawable-ldpi', 'icon.png'), encoding: null

    if icons?.android?.mdpi
      best = icons.android.mdpi
      grunt.file.copy icons.android.mdpi, path.join(res, 'drawable-mdpi', 'icon.png'), encoding: null

    if icons?.android?.hdpi
      best = icons.android.hdpi
      grunt.file.copy icons.android.hdpi, path.join(res, 'drawable-hdpi', 'icon.png'), encoding: null

    if icons?.android?.xhdpi
      best = icons.android.xhdpi
      grunt.file.copy icons.android.xhdpi, path.join(res, 'drawable-xhdpi', 'icon.png'), encoding: null

    if best
      grunt.file.copy best, path.join(res, 'drawable', 'icon.png'), encoding: null

    if fn then fn()
