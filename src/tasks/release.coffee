module.exports = (grunt, config, platform, fn) ->
  grunt.log.writeln "Creating release for #{platform} platform"

  grunt.file.mkdir require('path').join(config.releases, platform)

  switch platform
    when 'android'
      releaseAndroid = require './release/android'
      r = new releaseAndroid(grunt, config)
      r.release fn
    else
      grunt.fatal 'You must specify a platform for release. Only "android" is currently supported.'
      fn() if fn
