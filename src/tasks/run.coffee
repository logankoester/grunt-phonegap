class module.exports.Run
  exec: require('child_process').exec

  constructor: (@grunt, @config) ->

  run: (platform, device, fn) =>
    if @_isRemote()
      @_runRemote platform, fn
    else
      @_runLocal platform, fn

  _runLocal: (platform, fn) =>
    @_childExec "phonegap local run #{platform} #{@_setVerbosity()}", fn

  _runRemote: (platform, fn) =>
    @_childExec "phonegap remote run #{platform} #{@_setVerbosity()}", fn

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

  _isRemote: (platform) ->
    if @config.remote?.platforms? && platform in @config.remote?.platforms
      @grunt.config.requires 'phonegap.remote.username'
      @grunt.config.requires 'phonegap.remote.password'
      return true
    else
      return false
