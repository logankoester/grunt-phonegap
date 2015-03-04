fluid = require 'fluid'

module.exports = wp8 = (grunt) ->
  tasks =
    buildIcons: require('./wp8/icons')(grunt).build
    buildScreens: require('./wp8/screens')(grunt).build

  run: (fn) ->
    fluid(tasks)
      .buildIcons()
      .buildScreens()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
