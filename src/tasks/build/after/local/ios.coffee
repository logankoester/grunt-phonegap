fluid = require 'fluid'

module.exports = ios = (grunt) ->
  tasks =
    buildIcons: require('./ios/icons')(grunt).build
    buildScreens: require('./ios/screens')(grunt).build

  run: (fn) ->
    fluid(tasks)
      .buildIcons()
      .buildScreens()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
