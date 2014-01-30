helpers = require './helpers'

class module.exports.Run

  run: (platform, device, fn) ->
    if helpers.isRemote()
      @_runRemote platform, device, fn
    else
      @_runLocal platform, device, fn

  _runLocal: (platform, device, fn) ->
    cmd = "phonegap local run #{platform} #{helpers.setVerbosity()}"
    if device
      if device == 'emulator'
        cmd += ' --emulator'
      else
        cmd += " --device #{device}"
    helpers.exec cmd, fn

  # Use the Phonegap Build service to remotely build and install your application
  # for a specific platform.
  # 
  # @param [String] platform The platform to build and run on
  # @param [String] device Ignored
  # @param [Function] fn Optional callback to run when the child process terminates.
  _runRemote: (platform, device, fn) ->
    cmd = "phonegap remote run #{platform} #{helpers.setVerbosity()}"
    helpers.exec cmd, fn
