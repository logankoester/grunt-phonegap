async = require 'async'
path = require 'path'
URI = require 'URIjs'

module.exports = plugin = (grunt) ->
  helpers = require('../../helpers')(grunt)

  addPlugin = (plugin, fn) ->

    # If plugin is on the local filesystem, resolve it's absolute
    # path from process.cwd()
    uri = new URI(plugin)
    console.log uri, uri.path[0]
    if uri.protocol() == '' and (plugin.substr(0, 1) == '.' or plugin.substr(0, 1) == '/')
      plugin = path.resolve(uri.path())

    cmd = "phonegap local plugin add #{plugin} #{helpers.setVerbosity()}"
    helpers.exec cmd, fn

  add: (plugins, fn) ->
    grunt.log.writeln 'Adding plugins'
    async.eachSeries plugins, addPlugin, (err) ->
      if fn then fn(err)
