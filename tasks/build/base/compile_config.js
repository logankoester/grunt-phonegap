(function() {
  var compileConfig, cp, grunt, helpers, path;

  grunt = require('grunt');

  path = require('path');

  cp = require('cp');

  helpers = require('../../helpers');

  module.exports = compileConfig = {
    run: function(fn) {
      var compiled, configXml, dest, phonegapPath, template;
      grunt.log.writeln('Compiling config.xml');
      phonegapPath = helpers.config('path');
      configXml = helpers.config('config');
      dest = path.join(phonegapPath, 'www', 'config.xml');
      if (grunt.util.kindOf(configXml) === 'string') {
        grunt.logc.writeln("Copying static " + configXml);
        return cp(configXml, dest, function(err) {
          if (fn) {
            return fn(err);
          }
        });
      } else {
        grunt.log.writeln("Compiling template " + configXml.template);
        template = grunt.file.read(configXml.template);
        compiled = grunt.template.process(template, {
          data: configXml.data
        });
        grunt.file.write(dest, compiled);
        if (fn) {
          return fn();
        }
      }
    }
  };

}).call(this);
