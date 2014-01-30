(function() {
  var base, build, fluid, helpers, plugins;

  helpers = require('./helpers');

  fluid = require('fluid');

  base = {
    clean: require('./build/base/clean').run,
    createTree: require('./build/base/create_tree').run,
    cloneRoot: require('./build/base/clone_root').run,
    cloneCordova: require('./build/base/clone_cordova').run,
    compileConfig: require('./build/base/compile_config').run,
    addPlugins: require('./build/base/plugin').add,
    buildPlatforms: require('./build/base/platform').build
  };

  plugins = helpers.config('plugins');

  module.exports = build = {
    run: function(platforms, fn) {
      return fluid(base).clean().createTree('platforms').cloneRoot().cloneCordova().compileConfig().custom(function(done) {
        return base.addPlugins(plugins, function() {
          return done();
        });
      }).custom(function(done) {
        return base.buildPlatforms(platforms, function() {
          return done();
        });
      }).go(fn);
    }
  };

}).call(this);
