fluid = require 'fluid'

module.exports = build = (grunt) ->

  base =
    clean: require('./build/base/clean')(grunt).run
    createTree: require('./build/base/create_tree')(grunt).run
    cloneRoot: require('./build/base/clone_root')(grunt).run
    cloneCordova: require('./build/base/clone_cordova')(grunt).run
    compileConfig: require('./build/base/compile_config')(grunt).run
    addPlugins: require('./build/base/plugin')(grunt).add
    buildPlatforms: require('./build/base/platform')(grunt).build

  helpers = require('./helpers')(grunt)
  plugins = helpers.config 'plugins'

  run: (platforms, fn) ->
    fluid(base)
      .clean()
      .createTree('platforms')
      .cloneRoot()
      .cloneCordova()
      .compileConfig()
      .custom (done) ->
        base.addPlugins plugins, -> done()
      .custom (done) ->
        base.buildPlatforms platforms, -> done()
      .go fn
