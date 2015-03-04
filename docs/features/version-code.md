The [config-xml](https://build.phonegap.com/docs/config-xml) documentation from Phonegap Build (the remote build service)
indicate that you can set a **versionCode** for your `AndroidManifest.xml` file inside your `config.xml`. However, `phonegap`
just ignores that property.

[Google Play](http://developer.android.com/distribute/index.html) will not allow you to upload more than one APK with the same `versionCode`.

If you set a `phonegap.config.versionCode` value (function or literal), `grunt phonegap:build` will post-process the generated
`AndroidManifest.xml` file and set it for you.

In most applications it should simply be an integer that you increment with each release.

See http://developer.android.com/tools/publishing/versioning.html

This option will be ignored for non-Android platforms or when using the remote build service.

