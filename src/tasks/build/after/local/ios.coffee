fluid = require 'fluid'

module.exports = ios = (grunt) ->
  tasks =
    buildIcons: require('./ios/icons')(grunt).build
    buildScreens: require('./ios/screens')(grunt).build
    buildResources: require('./ios/resources')(grunt).build
    setStatusBar: require('./ios/plist')(grunt).setStatusBar

  run: (fn) ->
    fluid(tasks)
      .buildIcons()
      .buildScreens()
      .buildResources()
      .setStatusBar()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
