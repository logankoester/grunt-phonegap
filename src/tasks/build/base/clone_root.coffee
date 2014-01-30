grunt = require 'grunt'
path = require 'path'
copy = require 'directory-copy'
helpers = require '../../helpers'

module.exports = cloneRoot =
  run: (fn) ->
    grunt.log.writeln 'Cloning root directory'
    rootPath = helpers.config 'root'
    phonegapPath = helpers.config 'path'

    copy src: rootPath, dest: path.join(phonegapPath, 'www'), (err) =>
      if err then grunt.warn err
      if fn then fn err
