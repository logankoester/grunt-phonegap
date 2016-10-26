path = require 'path'
ncp = require('ncp').ncp
ncp.limit = 512

module.exports = cloneRoot = (grunt) ->
  helpers = require('../../helpers')(grunt)
  run: (fn) ->
    grunt.log.writeln 'Cloning root directory'
    rootPath = helpers.config 'root'
    phonegapPath = helpers.config 'path'

    ncp rootPath, path.join(phonegapPath, 'www'), { stopOnError: true }, (err) =>
      if err then grunt.warn err
      if fn then fn err
