Some Android applications need to force a specific value for `minSdkVersion` and `targetSdkVersion`, for example to enable "[quirks mode](http://developer.android.com/guide/webapps/migrating.html#Pixels)" in Android 4.4's Chrome-based WebView.

Supposedly, [Phonegap Build](https://build.phonegap.com) supports this through a **config.xml** preference [like this](https://github.com/phonegap/build/issues/174#issuecomment-25038854):

    <preference name="android-targetSdkVersion" value="13" />

However, setting this preference appears to have no effect on the output during a local build.

If you set `phonegap.config.minSdkVersion` and/or `phonegap.config.targetSdkVersion`, `grunt phonegap:build` will post-process the generated
`AndroidManifest.xml` file and set it for you.

This option will be ignored for non-Android platforms or when using the remote build service. For remote Android builds, instead try the `android-targetSdkVersion` preference mentioned above.
