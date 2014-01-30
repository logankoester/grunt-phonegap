grunt = require 'grunt'
path = require 'path'
copy = require 'directory-copy'
helpers = require '../../helpers'

module.exports = cloneCordova =
  run: (fn) ->
    grunt.log.writeln 'Cloning .cordova directory'
    cordovaPath = helpers.config 'cordova'
    phonegapPath = helpers.config 'path'
    copy src: cordovaPath, dest: path.join(phonegapPath, '.cordova'), (err) =>
      if err then grunt.warn err
      if fn then fn err
