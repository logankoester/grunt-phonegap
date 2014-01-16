fluid = require 'fluid'

module.exports = ios = (grunt) ->
  tasks =
    buildIcons: require('./ios/icons')(grunt).build

  run: (fn) ->
    fluid(tasks)
      .buildIcons()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
