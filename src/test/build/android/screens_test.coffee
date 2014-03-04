# If you choose to set `phonegap.config.screens.android` with one or more splash
# screen sizes, these files will be copied into the appropriate directories to
# use as your splash screen.

grunt = require 'grunt'
path = require 'path'
hash_file = require 'hash_file'
helpers = require(path.join __dirname, '..', '..', '..', 'tasks', 'helpers')(grunt)

if helpers.canBuild 'android'

  tests = {}

  orig = path.join 'test', 'fixtures', 'www'
  res = path.join 'test', 'phonegap', 'platforms', 'android', 'res'

  screens = [
    [ path.join(orig, 'screen-xhdpi-portrait.png'),  path.join(res, 'drawable', 'splash.png') ],
    [ path.join(orig, 'screen-xhdpi-landscape.png'),  path.join(res, 'drawable-land', 'splash.png') ],
    [ path.join(orig, 'screen-ldpi-portrait.png'),  path.join(res, 'drawable-ldpi', 'splash.png') ],
    [ path.join(orig, 'screen-ldpi-landscape.png'),  path.join(res, 'drawable-land-ldpi', 'splash.png') ],
    [ path.join(orig, 'screen-mdpi-portrait.png'),  path.join(res, 'drawable-mdpi', 'splash.png') ],
    [ path.join(orig, 'screen-mdpi-landscape.png'),  path.join(res, 'drawable-land-mdpi', 'splash.png') ],
    [ path.join(orig, 'screen-hdpi-portrait.png'),  path.join(res, 'drawable-hdpi', 'splash.png') ],
    [ path.join(orig, 'screen-hdpi-landscape.png'),  path.join(res, 'drawable-land-hdpi', 'splash.png') ],
    [ path.join(orig, 'screen-xhdpi-portrait.png'),  path.join(res, 'drawable-xhdpi', 'splash.png') ],
    [ path.join(orig, 'screen-xhdpi-landscape.png'),  path.join(res, 'drawable-land-xhdpi', 'splash.png') ],
  ]

  screens.forEach (pair) ->
    tests["android screen #{pair[0]}"] = (test) ->
      test.expect 3
      test.ok grunt.file.isFile(pair[0]), "#{pair[0]} does not exist"
      test.ok grunt.file.isFile(pair[1]), "#{pair[1]} does not exist"
      hash_file pair[0], 'sha1', (err, src) =>
        hash_file pair[1], 'sha1', (err, dest) =>
          test.equal dest, src, "hash should match for #{pair[0]} => #{pair[1]}"
          test.done()

  exports.group = tests
