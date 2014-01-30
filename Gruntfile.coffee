#
# * grunt-phonegap
# * https://github.com/logankoester/grunt-phonegap
# *
# * Copyright (c) 2013 Logan Koester
# * Licensed under the MIT license.
#

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    # Configuration to be run (and then tested).
    phonegap:
      config:
        root: 'test/fixtures/www'
        cordova: 'test/fixtures/.cordova'
        path: 'test/phonegap'
        plugins: ['../fixtures/org.apache.cordova.core.device']
        platforms: ['android']

        config:
          template: 'test/fixtures/www/custom_config.xml'
          data:
            id: 'com.phonegap.test'
            version: '1.0.0'
            name: 'TestFixtureApp'
            description: 'A text fixture app'
            author:
              email: 'logan@logankoester.com'
              href: 'http://logankoester.com'
              text: 'Logan Koester'

        verbose: false
        releases: 'test/releases'
        releaseName: 'TestFixtureApp-0.0.0'

        key:
          store: 'test/fixtures/release.keystore'
          alias: 'release'
          aliasPassword: -> 'testAliasPassword'
          storePassword: -> 'testStorePassword'

        icons:
          android:
            ldpi: 'test/fixtures/www/icon-36-ldpi.png'
            mdpi: 'test/fixtures/www/icon-48-mdpi.png'
            hdpi: 'test/fixtures/www/icon-72-hdpi.png'
            xhdpi: 'test/fixtures/www/icon-96-xhdpi.png'
        screens:
          android:
            ldpi: 'test/fixtures/www/screen-ldpi-portrait.png'
            ldpiLand: 'test/fixtures/www/screen-ldpi-landscape.png'
            mdpi: 'test/fixtures/www/screen-mdpi-portrait.png'
            mdpiLand: 'test/fixtures/www/screen-mdpi-landscape.png'
            hdpi: 'test/fixtures/www/screen-hdpi-portrait.png'
            hdpiLand: 'test/fixtures/www/screen-hdpi-landscape.png'
            xhdpi: 'test/fixtures/www/screen-xhdpi-portrait.png'
            xhdpiLand: 'test/fixtures/www/screen-xhdpi-landscape.png'
          wp8:
            app: 'test/fixtures/www/icon-62-tile.png'
            tile: 'test/fixtures/www/icon-173-tile.png'

        versionCode: -> 2

    # Before generating any new files, remove any previously-created files.
    clean:
      tasks: ['tasks']
      test: ['test']

    # Unit tests.
    nodeunit:
      tests: ['test/**/*_test.js']

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

    bump:
      options:
        commit: true
        commitMessage: 'Release v%VERSION%'
        commitFiles: ['package.json']
        createTag: true
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: false

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  grunt.loadNpmTasks 'grunt-bump'

  # Load this plugin's tasks (deferred until build is ready)
  grunt.registerTask 'test', ->
    grunt.loadTasks 'tasks'
    grunt.task.run 'phonegap:build', 'phonegap:release:android', 'nodeunit'

  grunt.registerTask 'run', ->
    grunt.loadTasks 'tasks'
    grunt.task.run 'phonegap:run'

  grunt.registerTask 'build', ['clean', 'copy', 'coffee']
  grunt.registerTask 'default', ['build', 'test']
