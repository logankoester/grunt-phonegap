# If you choose to set `phonegap.config.screens.ios` with one or more splash
# screen sizes, these files will be copied into the appropriate directories to
# use as your splash screen.

grunt = require 'grunt'
path = require 'path'
hash_file = require 'hash_file'
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'ios'

  tests = {}

  orig = path.join 'test', 'fixtures', 'www'
  res = path.join 'test', 'phonegap', 'platforms', 'ios', 'TestFixtureApp', 'Resources', 'splash'

  screens = [
    [ path.join(orig, 'screen-ipad-landscape-2x.png'), path.join(res, 'Default-Landscape@2x~ipad.png') ],
    [ path.join(orig, 'screen-ipad-landscape.png'), path.join(res, 'Default-Landscape~ipad.png') ],
    [ path.join(orig, 'screen-ipad-portrait-2x.png'), path.join(res, 'Default-Portrait@2x~ipad.png') ],
    [ path.join(orig, 'screen-ipad-portrait.png'), path.join(res, 'Default-Portrait~ipad.png') ],
    [ path.join(orig, 'screen-iphone-portrait-2x.png'), path.join(res, 'Default@2x~iphone.png') ],
    [ path.join(orig, 'screen-iphone-portrait.png'), path.join(res, 'Default~iphone.png') ],
    [ path.join(orig, 'screen-iphone-568h-2x.png'), path.join(res, 'Default-568h@2x~iphone.png') ]
  ]

  screens.forEach (pair) ->
    tests["ios screen #{pair[0]}"] = (test) ->
      test.expect 3
      test.ok grunt.file.isFile(pair[0]), "#{pair[0]} does not exist"
      test.ok grunt.file.isFile(pair[1]), "#{pair[1]} does not exist"
      hash_file pair[0], 'sha1', (err, src) =>
        hash_file pair[1], 'sha1', (err, dest) =>
          test.equal dest, src, "hash should match for #{pair[0]} => #{pair[1]}"
          test.done()

  exports.group = tests
