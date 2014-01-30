async = require 'async'
grunt = require 'grunt'
helpers = require '../../helpers'

addPlugin = (plugin, fn) ->
  cmd = "phonegap plugin add #{plugin} #{helpers.setVerbosity()}"
  helpers.exec cmd, fn

module.exports = plugin =

  add: (plugins, fn) ->
    grunt.log.writeln 'Adding plugins'
    async.eachSeries plugins, addPlugin, (err) ->
      if fn then fn(err)
