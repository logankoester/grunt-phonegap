(function() {
  module.exports = {
    release: function(grunt, config, platform, fn) {
      var r, releaseAndroid;
      grunt.log.writeln("Creating release for " + platform + " platform");
      grunt.file.mkdir(require('path').join(config.releases, platform));
      switch (platform) {
        case 'android':
          releaseAndroid = require('./release/android');
          r = new releaseAndroid(grunt, config);
          return r.release(fn);
        default:
          grunt.fatal('You must specify a platform for release. Only "android" is currently supported.');
          if (fn) {
            return fn();
          }
      }
    }
  };

}).call(this);
