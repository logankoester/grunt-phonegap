helpers = require './helpers'
fluid = require 'fluid'

base =
  clean: require('./build/base/clean').run
  createTree: require('./build/base/create_tree').run
  cloneRoot: require('./build/base/clone_root').run
  cloneCordova: require('./build/base/clone_cordova').run
  compileConfig: require('./build/base/compile_config').run
  addPlugins: require('./build/base/plugin').add
  buildPlatforms: require('./build/base/platform').build

plugins = helpers.config 'plugins'

module.exports = build =
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
