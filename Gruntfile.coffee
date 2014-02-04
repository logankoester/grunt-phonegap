#
# * grunt-phonegap
# * https://github.com/logankoester/grunt-phonegap
# *
# * Copyright (c) 2013-2014 Logan Koester
# * Licensed under the MIT license.
#

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    # Configuration to be run (and then tested).
    phonegap:
      config:
        root: 'test/fixtures/www'
        cordova: 'test/fixtures/.cordova'
        name: 'TestFixtureApp'
        path: 'test/phonegap'
        plugins: ['../fixtures/org.apache.cordova.core.device']
        platforms: ['android', 'ios']

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
          ios:
            icon29: 'test/fixtures/www/icon29.png'
            icon29x2: 'test/fixtures/www/icon29x2.png'
            icon40: 'test/fixtures/www/icon40.png'
            icon40x2: 'test/fixtures/www/icon40x2.png'
            icon57: 'test/fixtures/www/icon57.png'
            icon57x2: 'test/fixtures/www/icon57x2.png'
            icon60x2: 'test/fixtures/www/icon60x2.png'
            icon72: 'test/fixtures/www/icon72.png'
            icon72x2: 'test/fixtures/www/icon72x2.png'
            icon76: 'test/fixtures/www/icon76.png'
            icon76x2: 'test/fixtures/www/icon76x2.png'

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
          ios:
            ipadLand: 'test/fixtures/www/screen-ipad-landscape.png'
            ipadLandx2: 'test/fixtures/www/screen-ipad-landscape-2x.png'
            ipadPortrait: 'test/fixtures/www/screen-ipad-portrait.png'
            ipadPortraitx2: 'test/fixtures/www/screen-ipad-portrait-2x.png'
            iphonePortrait: 'test/fixtures/www/screen-iphone-portrait.png'
            iphonePortraitx2: 'test/fixtures/www/screen-iphone-portrait-2x.png'
            iphone568hx2: 'test/fixtures/www/screen-iphone-568h-2x.png'

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
        signCommits: true
        signTags: true

    readme_generator:
      readme:
        options:
          readme_folder: 'docs'
          output: 'README.md'
          table_of_contents: true
          toc_extra_links: []
          generate_changelog: true
          changelog_folder: 'docs/releases'
          changelog_version_prefix: 'v'
          changelog_insert_before: 'legal.md'
          banner: 'banner.md'
          has_travis: false
          github_username: 'logankoester'
          generate_footer: false
          generate_title: false
          package_title: null
          informative: true
          h1: '#'
          h2: '##'
          back_to_top_custom: '#grunt-phonegap'
        order:
          'requirements.md': 'Requirements'
          'getting-started.md': 'Getting Started'
          'overview.md': 'Overview'
          'features/dynamic-config.md': 'Dynamic config.xml'
          'features/app-icons.md': 'App Icons'
          'features/version-code.md': 'versionCode'
          'features/phonegap-build.md': 'Phonegap Build'
          'tasks.md': 'Tasks'
          'test-suite.md': 'Running the test suite'
          '../CONTRIBUTING.md': 'Contributing'
          'legal.md': 'License'

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-nodeunit'
  grunt.loadNpmTasks 'grunt-bump'
  grunt.loadNpmTasks 'grunt-readme-generator'

  # Load this plugin's tasks (deferred until build is ready)
  grunt.registerTask 'test', ->
    grunt.loadTasks 'tasks'
    grunt.task.run 'phonegap:build', 'phonegap:release:android', 'nodeunit'

  grunt.registerTask 'run', ->
    grunt.loadTasks 'tasks'
    grunt.task.run 'phonegap:run'

  grunt.registerTask 'docs', ['readme_generator']
  grunt.registerTask 'build', ['clean', 'copy', 'coffee', 'docs']
  grunt.registerTask 'default', ['build', 'test']
