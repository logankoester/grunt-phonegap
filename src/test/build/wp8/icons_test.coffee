# If you choose to set `phonegap.config.icons.wp8` with one or more icon
# files, these files will be copied into the appropriate directories to use as
# your app icon.
#
# Valid icon entries for wp8 include `app` and `tile`.

grunt = require 'grunt'
path = require 'path'
hash_file = require 'hash_file'
platform = require 'platform'

unless platform.os.family == 'Windows'
  console.log 'Skipping "wp8" icon tests (not running on Windows)'
else
  tests = {}

  orig = path.join 'test', 'fixtures', 'www'
  wp8 = path.join 'test', 'phonegap', 'platforms', 'wp8'

  icons = [
    [ path.join(orig, 'icon-62-tile.png'), path.join(wp8, 'ApplicationIcon.png') ],
    [ path.join(orig, 'icon-173-tile.png'),  path.join(wp8, 'Background.png') ],
  ]

  icons.forEach (pair) ->
    tests["wp8 icon #{pair[0]}"] = (test) ->
      test.expect 3
      test.ok grunt.file.isFile(pair[0]), "#{pair[0]} does not exist"
      test.ok grunt.file.isFile(pair[1]), "#{pair[1]} does not exist"
      hash_file pair[0], 'sha1', (err, src) =>
        hash_file pair[1], 'sha1', (err, dest) =>
          test.equal dest, src, "hash should match for #{pair[0]} => #{pair[1]}"
          test.done()

  exports.group = tests
