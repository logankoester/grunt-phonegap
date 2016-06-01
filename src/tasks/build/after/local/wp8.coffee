fluid = require 'fluid'

module.exports = wp8 = (grunt) ->
  tasks =
    buildIcons: require('./wp8/icons')(grunt).build

  run: (fn) ->
    fluid(tasks)
      .buildIcons()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
