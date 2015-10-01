# If you choose to set `phonegap.config.icons.ios` with one or more icon
# sizes, these files will be copied into the appropriate directories to use as
# your app icon.

grunt = require 'grunt'
path = require 'path'
hash_file = require 'hash_file'
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'ios'

  tests = {}

  orig = path.join 'test', 'fixtures', 'www'
  res = path.join 'test', 'phonegap', 'platforms', 'ios', 'TestFixtureApp', 'Resources', 'icons'

  icons = [
    [ path.join(orig, 'icon29.png'), path.join(res, 'icon-small.png') ],
    [ path.join(orig, 'icon29x2.png'), path.join(res, 'icon-small@2x.png') ],
    [ path.join(orig, 'icon40.png'), path.join(res, 'icon-40.png') ],
    [ path.join(orig, 'icon40x2.png'), path.join(res, 'icon-40@2x.png') ],
    [ path.join(orig, 'icon50.png'), path.join(res, 'icon-50.png') ],
    [ path.join(orig, 'icon50x2.png'), path.join(res, 'icon-50@2x.png') ],
    [ path.join(orig, 'icon57.png'), path.join(res, 'icon.png') ],
    [ path.join(orig, 'icon57x2.png'), path.join(res, 'icon@2x.png') ],
    [ path.join(orig, 'icon60.png'), path.join(res, 'icon-60.png') ],
    [ path.join(orig, 'icon60x2.png'), path.join(res, 'icon-60@2x.png') ],
    [ path.join(orig, 'icon60x3.png'), path.join(res, 'icon-60@3x.png') ],
    [ path.join(orig, 'icon72.png'), path.join(res, 'icon-72.png') ],
    [ path.join(orig, 'icon72x2.png'), path.join(res, 'icon-72@2x.png') ],
    [ path.join(orig, 'icon76.png'), path.join(res, 'icon-76.png') ],
    [ path.join(orig, 'icon76x2.png'), path.join(res, 'icon-76@2x.png') ],
    [ path.join(orig, 'icon512.png'), path.join(res, 'icon-512.png') ],
    [ path.join(orig, 'icon512x2.png'), path.join(res, 'icon-512@2x.png') ]
  ]

  icons.forEach (pair) ->
    tests["ios icon #{pair[0]}"] = (test) ->
      test.expect 3
      test.ok grunt.file.isFile(pair[0]), "#{pair[0]} does not exist"
      test.ok grunt.file.isFile(pair[1]), "#{pair[1]} does not exist"
      hash_file pair[0], 'sha1', (err, src) =>
        hash_file pair[1], 'sha1', (err, dest) =>
          test.equal dest, src, "hash should match for #{pair[0]} => #{pair[1]}"
          test.done()

  exports.group = tests
