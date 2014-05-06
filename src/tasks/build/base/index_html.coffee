path = require 'path'
fs   = require 'fs'

module.exports = indexHtml = (grunt) ->
  helpers = require('../../helpers')(grunt)
  run: (fn) ->
    grunt.log.writeln 'Fixing index.html'
    html         = helpers.config 'html'
    phonegapPath = helpers.config 'path'
    
    if html
      fs.renameSync path.join(phonegapPath, 'www', html), path.join(phonegapPath, 'www', 'index.html')
    else
      console.log 'config.html undefined'
    
    if fn then fn()