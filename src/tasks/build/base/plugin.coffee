async = require 'async'
path = require 'path'
URI = require 'URIjs'

module.exports = plugin = (grunt) ->
  helpers = require('../../helpers')(grunt)

  addPlugin = (plugin, fn) ->

    if typeof plugin is 'object'
      variables = plugin.variables || []
      plugin = plugin.id

    # If plugin is on the local filesystem, resolve it's absolute
    # path from process.cwd()
    uri = new URI(plugin)
    if uri.protocol() == '' and (plugin.substr(0, 1) == '.' or plugin.substr(0, 1) == '/')
      plugin = path.resolve(uri.path())

    cmd = grunt.config.get('phonegap.config.cli') + " plugin add #{plugin} #{helpers.setVerbosity()}"

    if typeof variables isnt 'undefined'
      for d, i in variables
        cmd += " --variable #{d.name}='#{d.value}'"

    helpers.exec cmd, fn

  add: (plugins, fn) ->
    grunt.log.writeln 'Adding plugins'
    async.eachSeries plugins, addPlugin, (err) ->
      if fn then fn(err)
