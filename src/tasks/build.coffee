class module.exports.Build
  copy: require 'directory-copy'
  cp: require 'cp'
  path: require 'path'
  exec: require('child_process').exec
  each: require('lodash').each

  constructor: (@grunt, @config) ->
    @file = @grunt.file
    @log = @grunt.log
    @warn = @grunt.warn
    @fatal = @grunt.fatal

  clean: (path = @config.path) ->
    if @file.exists(path) then @file.delete(path)
    @

  buildTree: (platforms)->
    path = @config.path
    @file.mkdir @path.join(path, 'plugins')
    @file.mkdir @path.join(path, 'platforms')
    @file.mkdir @path.join(path, 'www')
    @file.mkdir @path.join(path, '.cordova')

    @each platforms, (platform) =>
      @file.mkdir @path.join(path, 'merges', platform)

    @

  cloneCordova: (fn) =>
    @copy src: @config.cordova, dest: @path.join(@config.path, '.cordova'), (err) =>
      @warn(err) if err
      fn(err) if fn

  cloneRoot: (fn) =>
    @copy src: @config.root, dest: @path.join(@config.path, 'www'), (err) =>
      @warn(err) if err
      fn(err) if fn

  compileConfig: (fn) =>
    dest = @path.join(@config.path, 'www', 'config.xml')
    if @grunt.util.kindOf(@config.config) == 'string'
      @log.writeln "Copying static #{@config.config}"
      @cp @config.config, dest, -> fn()
    else
      @log.writeln "Compiling template #{@config.config.template}"
      template = @grunt.file.read @config.config.template
      compiled = @grunt.template.process template, data: @config.config.data
      @grunt.file.write dest, compiled
      fn()

  addPlugin: (plugin, fn) =>
    cmd = "phonegap plugin add #{plugin} #{@_setVerbosity()}"
    proc = @exec cmd, {
      cwd: @config.path,
      maxBuffer: @config.maxBuffer * 1024
    }, (err, stdout, stderr) =>
      @fatal err if err
      fn(err) if fn

    proc.stdout.on 'data', (out) => @log.write(out)
    proc.stderr.on 'data', (err) => @fatal(err)

  postProcessPlatform: (platform, fn) =>
    switch platform
      when 'android'
        @_fixAndroidVersionCode() unless @_isRemote()
    fn() if fn

  buildPlatform: (platform, fn) =>
    if @_isRemote()
      @_buildPlatformRemote platform, fn
    else
      @_buildPlatformLocal platform, fn

  buildIcons: (platform, fn) =>
    if @config.icons
      switch platform
        when 'android'
          @buildAndroidIcons(@config.icons)
        when 'wp8'
          @buildWindowsPhone8Icons(@config.icons)
        else
          @warn "You have set `phonegap.config.icons`, but #{platform} does not support it. Skipped..."
    else
      @log.writeln "No `phonegap.config.icons` specified. Skipped."
    fn() if fn

  buildAndroidIcons: (icons) ->
    res = @path.join @config.path, 'platforms', 'android', 'res'
    best = null

    if icons?.ldpi || icons?.mdpi || icons?.hdpi || icons?.xhdpi
      @warn "`phonegap.config.icons` has moved to `phonegap.config.icons.<platform>`.\nCheck the example in the grunt-phonegap README and update your Gruntfile accordingly.\n"
      icons.android = icons

    if icons?.android?.ldpi
      best = icons.android.ldpi
      @file.copy icons.android.ldpi, @path.join(res, 'drawable-ldpi', 'icon.png'), encoding: null

    if icons?.android?.mdpi
      best = icons.android.mdpi
      @file.copy icons.android.mdpi, @path.join(res, 'drawable-mdpi', 'icon.png'), encoding: null

    if icons?.android?.hdpi
      best = icons.android.hdpi
      @file.copy icons.android.hdpi, @path.join(res, 'drawable-hdpi', 'icon.png'), encoding: null

    if icons?.android?.xhdpi
      best = icons.android.xhdpi
      @file.copy icons.android.xhdpi, @path.join(res, 'drawable-xhdpi', 'icon.png'), encoding: null

    if best
      @file.copy best, @path.join(res, 'drawable', 'icon.png'), encoding: null

  buildWindowsPhone8Icons: (icons) ->
    res = @path.join @config.path, 'platforms', 'wp8'

    if icons?.wp8?.app
      @file.copy icons.wp8.app, @path.join(res, 'ApplicationIcon.png'), encoding: null

    if icons?.wp8?.tile
      @file.copy icons.wp8.tile, @path.join(res, 'Background.png'), encoding: null

  buildScreens: (platform, fn) =>
    if @config.screens
      switch platform
        when 'android'
          @buildAndroidScreens(@config.screens)
        else
          @warn "You have set `phonegap.config.screens`, but #{platform} does not support it. Skipped..."
    else
      @log.writeln "No `phonegap.config.screens` specified. Skipped."
    fn() if fn

  buildAndroidScreens: (screens) ->
    res = @path.join @config.path, 'platforms', 'android', 'res'
    best = null
    bestLand = null

    if screens?.android?.ldpi
      best = screens.android.ldpi
      @file.copy screens.android.ldpi, @path.join(res, 'drawable-ldpi', 'splash.png'), encoding: null

    if screens?.android?.ldpiLand
      bestLand = screens.android.ldpiLand
      @file.copy screens.android.ldpiLand, @path.join(res, 'drawable-land-ldpi', 'splash.png'), encoding: null

    if screens?.android?.mdpi
      best = screens.android.mdpi
      @file.copy screens.android.mdpi, @path.join(res, 'drawable-mdpi', 'splash.png'), encoding: null

    if screens?.android?.mdpiLand
      bestLand = screens.android.mdpiLand
      @file.copy screens.android.mdpiLand, @path.join(res, 'drawable-land-mdpi', 'splash.png'), encoding: null

    if screens?.android?.hdpi
      best = screens.android.hdpi
      @file.copy screens.android.hdpi, @path.join(res, 'drawable-hdpi', 'splash.png'), encoding: null

    if screens?.android?.hdpiLand
      bestLand = screens.android.hdpiLand
      @file.copy screens.android.hdpiLand, @path.join(res, 'drawable-land-hdpi', 'splash.png'), encoding: null

    if screens?.android?.xhdpi
      best = screens.android.xhdpi
      @file.copy screens.android.xhdpi, @path.join(res, 'drawable-xhdpi', 'splash.png'), encoding: null

    if screens?.android?.xhdpiLand
      bestLand = screens.android.xhdpiLand
      @file.copy screens.android.xhdpiLand, @path.join(res, 'drawable-land-xhdpi', 'splash.png'), encoding: null

    if best
      @file.copy best, @path.join(res, 'drawable', 'splash.png'), encoding: null

    if bestLand
      @file.copy bestLand, @path.join(res, 'drawable-land', 'splash.png'), encoding: null

  _buildPlatformRemote: (platform, fn) =>
    @grunt.task.run 'phonegap:login'
    @_childExec "phonegap remote build #{platform} #{@_setVerbosity()}", fn
    @grunt.task.run 'phonegap:logout'

  _buildPlatformLocal: (platform, fn) =>
    @_childExec "phonegap local build #{platform} #{@_setVerbosity()}", fn

  _childExec: (cmd, fn) =>
    childProcess = @exec cmd, {
      cwd: @config.path,
      maxBuffer: @config.maxBuffer * 1024
    }, (err, stdout, stderr) =>
      @fatal err if err
      fn(err) if fn

    childProcess.stdout.on 'data', (out) => @log.write(out)
    childProcess.stderr.on 'data', (err) => @fatal(err)

  _setVerbosity: ->
    if @config.verbose then '-V' else ''

  _fixAndroidVersionCode: =>
    dom = require('xmldom').DOMParser
    data = @config.versionCode
    versionCode = if @grunt.util.kindOf(data) == 'function' then data() else data

    manifestPath = @path.join @config.path, 'platforms', 'android', 'AndroidManifest.xml'
    manifest = @grunt.file.read manifestPath
    doc = new dom().parseFromString manifest, 'text/xml'
    doc.getElementsByTagName('manifest')[0].setAttribute('android:versionCode', versionCode)
    @grunt.file.write manifestPath, doc

  _isRemote: (platform) ->
    if @config.remote?.platforms? && platform in @config.remote?.platforms
      @grunt.config.requires 'phonegap.remote.username'
      @grunt.config.requires 'phonegap.remote.password'
      return true
    else
      return false
