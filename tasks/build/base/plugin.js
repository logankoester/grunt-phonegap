(function() {
  var URI, async, path, plugin;

  async = require('async');

  path = require('path');

  URI = require('URIjs');

  module.exports = plugin = function(grunt) {
    var addPlugin, helpers;
    helpers = require('../../helpers')(grunt);
    addPlugin = function(plugin, fn) {
      var cmd, d, i, uri, variables, _i, _len;
      if (typeof plugin === 'object') {
        variables = plugin.variables || [];
        plugin = plugin.id;
      }
      uri = new URI(plugin);
      if (uri.protocol() === '' && (plugin.substr(0, 1) === '.' || plugin.substr(0, 1) === '/')) {
        plugin = path.resolve(uri.path());
      }
      cmd = grunt.config.get('phonegap.config.cli') + (" plugin add " + plugin + " " + (helpers.setVerbosity()));
      if (typeof variables !== 'undefined') {
        for (i = _i = 0, _len = variables.length; _i < _len; i = ++_i) {
          d = variables[i];
          cmd += " --variable " + d.name + "='" + d.value + "'";
        }
      }
      return helpers.exec(cmd, fn);
    };
    return {
      add: function(plugins, fn) {
        grunt.log.writeln('Adding plugins');
        return async.eachSeries(plugins, addPlugin, function(err) {
          if (fn) {
            return fn(err);
          }
        });
      }
    };
  };

}).call(this);
