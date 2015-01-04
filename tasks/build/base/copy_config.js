(function() {
  var indexHtml, cp, path;

  path = require('path');

  cp = require('cp');

  module.exports = indexHtml = function(grunt) {
    var helpers;
    helpers = require('../../helpers')(grunt);
    return {
      run: function(fn) {
          var phonegapPath;
          phonegapPath = helpers.config('path');
          grunt.log.writeln( 'Duplicating config.xml to path root' );
          return cp( path.join( phonegapPath, 'www', 'config.xml' ), path.join( phonegapPath, 'config.xml' ), function ( err ) {
              if ( err ) {
                  grunt.warn( err );
              }
              if ( fn ) {
                  return fn( err );
              }
          } );
      }

    };
  };

}).call(this);
