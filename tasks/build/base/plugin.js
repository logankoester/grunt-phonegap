(function() {
  var addPlugin, async, grunt, helpers, plugin;

  async = require('async');

  grunt = require('grunt');

  helpers = require('../../helpers');

  addPlugin = function(plugin, fn) {
    var cmd;
    cmd = "phonegap plugin add " + plugin + " " + (helpers.setVerbosity());
    return helpers.exec(cmd, fn);
  };

  module.exports = plugin = {
    add: function(plugins, fn) {
      grunt.log.writeln('Adding plugins');
      return async.eachSeries(plugins, addPlugin, function(err) {
        if (fn) {
          return fn(err);
        }
      });
    }
  };

}).call(this);
