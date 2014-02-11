fluid = require 'fluid'

module.exports = android = (grunt) ->
  tasks =
    repairVersionCode: require('./android/version_code')(grunt).repair
    buildIcons: require('./android/icons')(grunt).build
    buildScreens: require('./android/screens')(grunt).build
    setMinSdkVersion: require('./android/sdk_version')(grunt).setMin
    setTargetSdkVersion: require('./android/sdk_version')(grunt).setTarget

  run: (fn) ->
    fluid(tasks)
      .repairVersionCode()
      .setMinSdkVersion()
      .setTargetSdkVersion()
      .buildIcons()
      .buildScreens()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
