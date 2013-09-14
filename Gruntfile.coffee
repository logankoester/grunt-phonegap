#
# * grunt-phonegap
# * https://github.com/logankoester/grunt-phonegap
# *
# * Copyright (c) 2013 Logan Koester
# * Licensed under the MIT license.
#

module.exports = (grunt) ->
  #
  # Project configuration.
  grunt.initConfig
    # Configuration to be run (and then tested).
    phonegap:
      config:
        root: 'test/fixtures/www'
        cordova: 'test/fixtures/.cordova'
        path: 'test/phonegap'
        releases: 'test/releases'
        plugins: ['../fixtures/org.apache.cordova.core.device']
        platforms: ['android']
        config: 'test/fixtures/www/custom_config.xml'
        verbose: false

    # Before generating any new files, remove any previously-created files.
    clean:
      tasks: ['tasks']
      test: ['test']


    # Unit tests.
    nodeunit:
      tests: ['test/*_test.js']

    # Copy files
    copy:
      test_fixtures:
        files: [{
          expand: true
          cwd: 'src/test/fixtures'
          src: ['**/*']
          dest: 'test/fixtures/'
        }]

      test_cordova:
        files: [{
          expand: true
          cwd: 'src/test/fixtures/.cordova'
          src: ['**/*']
          dest: 'test/fixtures/.cordova'
        }]

    # Coffeescript
    coffee:
      tasks:
        expand: true
        cwd: 'src/tasks/'
        src: '**/*.coffee'
        dest: 'tasks/'
        ext: '.js'

      test:
        expand: true
        cwd: 'src/test/'
        src: '**/*.coffee'
        dest: 'test/'
        ext: '.js'

    watch:
      coffee:
        files: ['src/**/*.coffee', 'Gruntfile.coffee']
        tasks: ['default']

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-nodeunit'

  # Load this plugin's tasks (deferred until build is ready)
  grunt.registerTask 'test', ->
    grunt.loadTasks 'tasks'
    grunt.task.run 'phonegap:build', 'nodeunit'

  grunt.registerTask 'run', ->
    grunt.loadTasks 'tasks'
    grunt.task.run 'phonegap:run'

  grunt.registerTask 'build', ['clean', 'copy', 'coffee']
  grunt.registerTask 'default', ['build', 'test']
