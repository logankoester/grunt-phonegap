path = require 'path'

module.exports = resources = (grunt) ->
  helpers = require('../../../../helpers')(grunt)

  build: (fn) ->
    resources = helpers.config 'resources'
    phonegapPath = helpers.config 'path'
    appName = helpers.config 'name'

    dest = path.join phonegapPath, 'platforms', 'ios', appName

    if resources?.ios
      for resource in resources?.ios
        console.log 'resource from:'+resource.from+", to:"+resource.to
        grunt.file.recurse resource.from, (file, root, filepath, filename) -> 
          console.log "copying "+file+ ","+root+","+filepath+","+filename
          if filepath
            grunt.file.copy file, path.join dest, resource.to, filepath, filename
          else 
            grunt.file.copy file, path.join dest, resource.to, filename

    if fn then fn()
