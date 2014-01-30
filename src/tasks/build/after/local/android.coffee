fluid = require 'fluid'
grunt = require 'grunt'

tasks =
  repairVersionCode: require('./android/version_code').repair
  buildIcons: require('./android/icons').build
  buildScreens: require('./android/screens').build

module.exports =
  run: (fn) ->
    fluid(tasks)
      .repairVersionCode()
      .buildIcons()
      .buildScreens()
      .go (err, result) ->
        if err then grunt.fatal err
        if fn then fn()
