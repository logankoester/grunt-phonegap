# cordova > 3.3 looks for config.xml in root so this fixes a bug where it regresses upwards and compiles a parent directory
path = require 'path'
cp   = require 'cp'
module.exports = indexHtml = (grunt) ->
  helpers = require('../../helpers')(grunt)
  run: (fn) ->
    grunt.log.writeln 'Duplicating config.xml to path root'
    phonegapPath = helpers.config 'path'
    cp  path.join(phonegapPath, 'www', 'config.xml'), path.join(phonegapPath,'config.xml'),(err) ->
      if err then grunt.warn err
      if fn then fn(err)
