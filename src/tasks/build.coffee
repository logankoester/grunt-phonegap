class module.exports.Build
  copy: require 'directory-copy'
  cp: require 'cp'
  path: require 'path'
  exec: require('child_process').exec

  constructor: (@grunt, @config) ->
    @file = @grunt.file
    @log = @grunt.log
    @warn = @grunt.warn
    @fatal = @grunt.fatal

  clean: (path = @config.path) ->
    if @file.exists(path) then @file.delete(path)
    @

  buildTree: ->
    path = @config.path
    @file.mkdir @path.join(path, 'plugins')
    @file.mkdir @path.join(path, 'platforms')
    @file.mkdir @path.join(path, 'merges', 'android')
    @file.mkdir @path.join(path, 'www')
    @file.mkdir @path.join(path, '.cordova')
    @

  cloneCordova: (fn) =>
    @copy src: @config.cordova, dest: @path.join(@config.path, '.cordova'), (err) =>
      @warn(err) if err
      fn(err) if fn

  cloneRoot: (fn) =>
    @copy src: @config.root, dest: @path.join(@config.path, 'www'), (err) =>
      @warn(err) if err
      fn(err) if fn

  copyConfig: (fn) =>
    @cp @config.config, @path.join(@config.path, 'www', 'config.xml'), -> fn()

  addPlugin: (plugin, fn) =>
    if typeof plugin is 'object'
      cmd = "phonegap local plugin add #{plugin.plugin}"
      cmd += " --variable #{variable.name}=\"#{variable.value}\"" for variable in plugin.variables
      cmd += " #{@_setVerbosity()}"
    else
      cmd = "phonegap local plugin add #{plugin} #{@_setVerbosity()}"
    @grunt.log.writeln cmd
    proc = @exec cmd, {cwd: @config.path, maxBuffer: @config.maxBuffer * 1024}, (err, stdout, stderr) =>
      @fatal err if err
      fn(err) if fn

    proc.stdout.on 'data', (out) => @log.write(out)
    proc.stderr.on 'data', (err) => @fatal(err)

  buildPlatform: (platform, fn) =>
    cmd = "phonegap local build #{platform} #{@_setVerbosity()}"
    childProcess = @exec cmd, {cwd: @config.path, maxBuffer: @config.maxBuffer * 1024}, (err, stdout, stderr) =>
      @fatal err if err
      fn(err) if fn

    childProcess.stdout.on 'data', (out) => @log.write(out)
    childProcess.stderr.on 'data', (err) => @fatal(err)

  _setVerbosity: ->
    if @config.verbose then '-V' else ''
