fluid = require 'fluid'
grunt = require 'grunt'

tasks =
  buildIcons: require('./wp8/icons').build

module.exports =
  run: (fn) ->
    fluid(tasks)
      .buildIcons()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
