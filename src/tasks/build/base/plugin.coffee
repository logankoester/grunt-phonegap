async = require 'async'

module.exports = plugin = (grunt) ->
  helpers = require('../../helpers')(grunt)

  addPlugin = (plugin, fn) ->
    cmd = "phonegap plugin add #{plugin} #{helpers.setVerbosity()}"
    helpers.exec cmd, fn

  add: (plugins, fn) ->
    grunt.log.writeln 'Adding plugins'
    async.eachSeries plugins, addPlugin, (err) ->
      if fn then fn(err)
