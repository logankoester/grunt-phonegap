path = require 'path'
ncp = require('ncp').ncp

module.exports = cloneRoot = (grunt) ->
  helpers = require('../../helpers')(grunt)
  run: (fn) ->
    mergesPath = helpers.config 'merges'
    if mergesPath && mergesPath != ''
      grunt.log.writeln mergesPath
      grunt.log.writeln 'Cloning root directory'
      phonegapPath = helpers.config 'path'
      ncp mergesPath, path.join(phonegapPath, 'merges'), { stopOnError: true }, (err) =>
        if err then grunt.warn err
        if fn then fn err

    else
      if fn then fn()