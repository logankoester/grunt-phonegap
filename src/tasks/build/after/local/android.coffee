fluid = require 'fluid'

module.exports = android = (grunt) ->
  tasks =
    repairVersionCode: require('./android/version_code')(grunt).repair
    buildIcons: require('./android/icons')(grunt).build
    buildScreens: require('./android/screens')(grunt).build

  run: (fn) ->
    fluid(tasks)
      .repairVersionCode()
      .buildIcons()
      .buildScreens()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
