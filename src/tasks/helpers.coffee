_ = require 'lodash'
exec = require('child_process').exec

module.exports = helpers = (grunt) ->

  # Merge a default config object into the grunt-phonegap configuration.
  #
  # @param [Object] defaults The default config object
  # @return [Object] The merged config object
  mergeConfig: (defaults) ->
    _.defaults grunt.config.get('phonegap.config'), defaults

  # Execute the given command in a child process, and then run the
  # callback function if one is provided.
  #
  # STDOUT will be written to the Grunt logger.
  # STDERR will be displayed and then Grunt will be aborted immediately.
  #
  # @param [String] cmd The shell command to execute
  # @param [Function] fn An optional function to call when the child process terminates.
  exec: (cmd, fn, cwd = grunt.config.get('phonegap.config.path')) ->
    options =
      maxBuffer: (grunt.config.get('phonegap.config.maxBuffer') * 1024)
      cwd: cwd

    proc = exec cmd, options, (err, stdout, stderr) =>
      grunt.fatal err if err
      fn(err) if fn

    proc.stdout.on 'data', (out) => grunt.log.write(out)
    proc.stderr.on 'data', (err) => grunt.fatal(err)

  # Delete a target file path if it exists.
  #
  # @param [String] target File path to be deleted.
  clean: (target) ->
    if grunt.file.exists(target) then grunt.file.delete(target)

  setVerbosity: ->
    if grunt.config.get('phonegap.config.verbose') then '-V' else ''

  isRemote: (platform) ->
    remote = helpers(grunt).config 'remote'
    if remote?.platforms? && platform in remote.platforms
      grunt.config.requires 'phonegap.config.remote.username'
      grunt.config.requires 'phonegap.config.remote.password'
      return true
    else
      return false

  ensureExists: (path, failMessage) ->
    failMessage ||= "\"#{path}\" does not exist."
    if grunt.file.exists path
      true
    else
      grunt.fatal failMessage
      false

  config: (property) ->
    value = grunt.config.get("phonegap.config.#{property}")
    if typeof value == 'Function'
      return value()
    else
      return value
