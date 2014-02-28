_ = require 'lodash'
grunt = require 'grunt'
xmlParser = require 'xml2json'
platform = require 'platform'

unless platform.os.family == 'darwin'
  console.log 'Skipping "iOS" status bar tests (not running on darwin)'
else
  exports.phonegap =
    'plist file should contain white status bar configuration': (test) ->
      test.expect 2
      appName = grunt.config.get 'phonegap.config.name'

      xml = grunt.file.read "test/phonegap/platforms/ios/#{appName}/#{appName}-Info.plist"
      plist = xmlParser.toJson xml, object: true
      test.equal true, _.contains(plist.plist.dict.key, "UIStatusBarStyle"), "contains key UIStatusBarStyle"
      test.equal true, _.contains(plist.plist.dict.key, "UIViewControllerBasedStatusBarAppearance"), "contains key UIViewControllerBasedStatusBarAppearance"
      test.done()
