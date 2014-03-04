_ = require 'lodash'
exec = require('child_process').exec

# Check SDK compatibility for a target platform from the current environment.
#
# Note that this does not guarantee that the required SDK is installed on the system,
# nor that any particular `grunt-phonegap` features support the platform.
#
# @see http://docs.phonegap.com/en/3.3.0/guide_support_index.md.html#Platform%20Support
#
# @param [String] targetPlatform The target mobile platform.
# @return [Boolean] true When it is possible to build from this environment.
# @return [Boolean] false When it is not possible to build from this environment from this environment.
canBuild = (targetPlatform) ->
  compatibility = 
    'amazon-fireos': ['darwin', 'windows', 'linux']
    'android': ['darwin', 'windows', 'linux']
    'blackberry10': ['darwin', 'windows']
    'ios': ['darwin']
    'ubuntu': ['linux'] # Specifically Ubuntu
    'wp7': ['windows']
    'wp8': ['windows'] # Specifically Windows 8
    'win8': ['windows'] # Specifically Windows 8
    'tizen': []

  _.contains compatibility[targetPlatform.toLowerCase()], require('platform').os.family.toLowerCase()

module.exports = helpers = (grunt) ->

  # Merge a default config object into the grunt-phonegap configuration.
  #
  # @param [Object] defaults The default config object
  # @return [Object] The merged config object
  mergeConfig: (defaults) ->
    grunt.config.set 'phonegap.config'
      , _.defaults grunt.config.get('phonegap.config'), defaults

  # Execute the given command in a child process, and then run the
  # callback function if one is provided.
  #
  # STDOUT will be written to the Grunt logger.
  # STDERR will be displayed and then Grunt will be aborted immediately.
  #
  # @param [String] cmd The shell command to execute
  # @param [Function] fn An optional function to call when the child process terminates.
  exec: (cmd, fn, cwd = grunt.config.get('phonegap.config.path')) ->
    grunt.log.writeln "Running: #{cmd}"
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
    if typeof value == 'function'
      return value()
    else
      return value

  canBuild: canBuild

  # Reduce an array of platforms to a subset compatible with the current environment.
  #
  # Logs a message for each platform that is excluded.
  #
  # @param [Array] platforms An array of platforms.
  # @return [Array] platforms A subset of the given array for which #canBuild(platform) is true.
  reducePlatforms: (platforms) ->
    _.filter platforms, (platform) ->
      return true if canBuild(platform)
      grunt.log.writeln "Skipping platform '#{platform}' (SDK not compatible)"
      false
