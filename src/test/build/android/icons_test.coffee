# If you choose to set `phonegap.config.icons.android` with one or more icon
# sizes, these files will be copied into the appropriate directories to use as
# your app icon.

grunt = require 'grunt'
path = require 'path'
hash_file = require 'hash_file'

tests = {}

orig = path.join 'test', 'fixtures', 'www'
res = path.join 'test', 'phonegap', 'platforms', 'android', 'res'

icons = [
  [ path.join(orig, 'icon-96-xhdpi.png'), path.join(res, 'drawable', 'icon.png') ],
  [ path.join(orig, 'icon-36-ldpi.png'),  path.join(res, 'drawable-ldpi', 'icon.png') ],
  [ path.join(orig, 'icon-48-mdpi.png'),  path.join(res, 'drawable-mdpi', 'icon.png') ],
  [ path.join(orig, 'icon-72-hdpi.png'),  path.join(res, 'drawable-hdpi', 'icon.png') ],
  [ path.join(orig, 'icon-96-xhdpi.png'), path.join(res, 'drawable-xhdpi', 'icon.png') ]
]

icons.forEach (pair) ->
  tests["android icon #{pair[0]}"] = (test) ->
    test.expect 3
    test.ok grunt.file.isFile(pair[0]), "#{pair[0]} does not exist"
    test.ok grunt.file.isFile(pair[1]), "#{pair[1]} does not exist"
    hash_file pair[0], 'sha1', (err, src) =>
      hash_file pair[1], 'sha1', (err, dest) =>
        test.equal dest, src, "hash should match for #{pair[0]} => #{pair[1]}"
        test.done()

exports.group = tests
