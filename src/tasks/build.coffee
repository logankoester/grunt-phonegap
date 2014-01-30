grunt = require 'grunt'
copy = require 'directory-copy'
cp = require 'cp'
path = require 'path'
exec = require('child_process').exec
_ = require 'lodash'
helpers = require './helpers'

class module.exports.Build

  buildTree: (platforms) ->
    phonegapPath = helpers.config 'path'

    _.each ['plugins', 'platforms', 'www', '.cordova'], (dir) ->
      grunt.file.mkdir path.join(phonegapPath, dir)

    _.each platforms, (platform) =>
      grunt.file.mkdir path.join(phonegapPath, 'merges', platform)

  cloneCordova: (fn) =>
    cordovaPath = helpers.config 'cordova'
    phonegapPath = helpers.config 'path'
    
    copy src: cordovaPath, dest: path.join(phonegapPath, '.cordova'), (err) =>
      grunt.warn(err) if err
      fn(err) if fn

  cloneRoot: (fn) =>
    rootPath = helpers.config 'root'
    phonegapPath = helpers.config 'path'

    copy src: rootPath, dest: path.join(phonegapPath, 'www'), (err) =>
      grunt.warn(err) if err
      fn(err) if fn

  compileConfig: (fn) =>
    phonegapPath = helpers.config 'path'
    configXml = helpers.config 'config'

    dest = path.join phonegapPath, 'www', 'config.xml'

    if grunt.util.kindOf(configXml) == 'string'
      grunt.logc.writeln "Copying static #{configXml}"
      cp configXml, dest, -> fn()
    else
      grunt.log.writeln "Compiling template #{configXml.template}"
      template = grunt.file.read configXml.template
      compiled = grunt.template.process template, data: configXml.data
      grunt.file.write dest, compiled
      fn()

  addPlugin: (plugin, fn) =>
    cmd = "phonegap plugin add #{plugin} #{helpers.setVerbosity()}"
    helpers.exec cmd, fn

  postProcessPlatform: (platform, fn) =>
    switch platform
      when 'android'
        @_fixAndroidVersionCode() unless helpers.isRemote()
    fn() if fn

  buildPlatform: (platform, fn) =>
    if helpers.isRemote()
      @_buildPlatformRemote platform, fn
    else
      @_buildPlatformLocal platform, fn

  buildIcons: (platform, fn) =>
    icons = helpers.config 'icons'
    if icons
      switch platform
        when 'android'
          @buildAndroidIcons icons
        when 'wp8'
          @buildWindowsPhone8Icons icons
        else
          grunt.warn "You have set `phonegap.config.icons`, but #{platform} does not support it. Skipped..."
    else
      grunt.log.writeln "No `phonegap.config.icons` specified. Skipped."
    fn() if fn

  buildAndroidIcons: (icons) ->
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

  buildWindowsPhone8Icons: (icons) ->
    phonegapPath = helpers.config 'path'
    res = path.join phonegapPath, 'platforms', 'wp8'

    if icons?.wp8?.app
      grunt.file.copy icons.wp8.app, path.join(res, 'ApplicationIcon.png'), encoding: null

    if icons?.wp8?.tile
      grunt.file.copy icons.wp8.tile, path.join(res, 'Background.png'), encoding: null

  buildScreens: (platform, fn) =>
    screens = helpers.config 'screens'
    if screens
      switch platform
        when 'android'
          @buildAndroidScreens screens
        else
          grunt.warn "You have set `phonegap.config.screens`, but #{platform} does not support it. Skipped..."
    else
      grunt.log.writeln "No `phonegap.config.screens` specified. Skipped."
    fn() if fn

  buildAndroidScreens: (screens) ->
    phonegapPath = helpers.config 'path'
    res = path.join phonegapPath, 'platforms', 'android', 'res'
    best = null
    bestLand = null

    if screens?.android?.ldpi
      best = screens.android.ldpi
      grunt.file.copy screens.android.ldpi, path.join(res, 'drawable-ldpi', 'splash.png'), encoding: null

    if screens?.android?.ldpiLand
      bestLand = screens.android.ldpiLand
      grunt.file.copy screens.android.ldpiLand, path.join(res, 'drawable-land-ldpi', 'splash.png'), encoding: null

    if screens?.android?.mdpi
      best = screens.android.mdpi
      grunt.file.copy screens.android.mdpi, path.join(res, 'drawable-mdpi', 'splash.png'), encoding: null

    if screens?.android?.mdpiLand
      bestLand = screens.android.mdpiLand
      grunt.file.copy screens.android.mdpiLand, path.join(res, 'drawable-land-mdpi', 'splash.png'), encoding: null

    if screens?.android?.hdpi
      best = screens.android.hdpi
      grunt.file.copy screens.android.hdpi, path.join(res, 'drawable-hdpi', 'splash.png'), encoding: null

    if screens?.android?.hdpiLand
      bestLand = screens.android.hdpiLand
      grunt.file.copy screens.android.hdpiLand, path.join(res, 'drawable-land-hdpi', 'splash.png'), encoding: null

    if screens?.android?.xhdpi
      best = screens.android.xhdpi
      grunt.file.copy screens.android.xhdpi, path.join(res, 'drawable-xhdpi', 'splash.png'), encoding: null

    if screens?.android?.xhdpiLand
      bestLand = screens.android.xhdpiLand
      grunt.file.copy screens.android.xhdpiLand, path.join(res, 'drawable-land-xhdpi', 'splash.png'), encoding: null

    if best
      grunt.file.copy best, path.join(res, 'drawable', 'splash.png'), encoding: null

    if bestLand
      grunt.file.copy bestLand, path.join(res, 'drawable-land', 'splash.png'), encoding: null

  _buildPlatformRemote: (platform, fn) =>
    grunt.task.run 'phonegap:login'
    helpers.exec "phonegap remote build #{platform} #{helpers.setVerbosity()}", fn
    grunt.task.run 'phonegap:logout'

  _buildPlatformLocal: (platform, fn) =>
    helpers.exec "phonegap local build #{platform} #{helpers.setVerbosity()}", fn

  _fixAndroidVersionCode: =>
    dom = require('xmldom').DOMParser
    data = helpers.config 'versionCode'
    versionCode = if grunt.util.kindOf(data) == 'function' then data() else data
    phonegapPath = helpers.config 'path'

    manifestPath = path.join phonegapPath, 'platforms', 'android', 'AndroidManifest.xml'
    manifest = grunt.file.read manifestPath
    doc = new dom().parseFromString manifest, 'text/xml'
    doc.getElementsByTagName('manifest')[0].setAttribute('android:versionCode', versionCode)
    grunt.file.write manifestPath, doc
