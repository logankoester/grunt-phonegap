path = require 'path'
ncp = require('ncp').ncp

module.exports = cloneCordova = (grunt) ->
  helpers = require('../../helpers')(grunt)

  run: (fn) ->
    grunt.log.writeln 'Cloning .cordova directory'
    cordovaPath = helpers.config 'cordova'
    phonegapPath = helpers.config 'path'
    ncp cordovaPath, path.join(phonegapPath, '.cordova'), { stopOnError: true }, (err) =>
      if err then grunt.warn err
      if fn then fn err
