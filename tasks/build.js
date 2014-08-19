(function() {
  var build, fluid;

  fluid = require('fluid');

  module.exports = build = function(grunt) {
    var base, helpers, plugins;
    base = {
      clean: require('./build/base/clean')(grunt).run,
      createTree: require('./build/base/create_tree')(grunt).run,
      cloneRoot: require('./build/base/clone_root')(grunt).run,
      cloneMerges: require('./build/base/clone_merges')(grunt).run,
      indexHtml: require('./build/base/index_html')(grunt).run,
      cloneCordova: require('./build/base/clone_cordova')(grunt).run,
      compileConfig: require('./build/base/compile_config')(grunt).run,
      addPlugins: require('./build/base/plugin')(grunt).add,
      buildPlatforms: require('./build/base/platform')(grunt).build
    };
    helpers = require('./helpers')(grunt);
    plugins = helpers.config('plugins');
    return {
      run: function(platforms, fn) {
        platforms = helpers.reducePlatforms(platforms);
        return fluid(base).clean().createTree(platforms).cloneRoot().cloneMerges().indexHtml().cloneCordova().compileConfig().custom(function(done) {
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
  };

}).call(this);
