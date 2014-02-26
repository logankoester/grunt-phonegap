If `phonegap.config.androidApplicationName` is a string or function, then it will be applied to the `<application android:name />` attribute in your `AndroidManifest.xml`.

This option should **almost always** be left `undefined`. You will only need to set this if you are implementing a base plugin 
(a Java class extending from `android.app.Application`), for example to [implement crash reporting with ACRA](https://github.com/mWater/cordova-plugin-acra).
