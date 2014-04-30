If you need to specify the screen orientation for your app on the Android
platform, you may set a value for `phonegap.config.screenOrientation` to cause
`grunt-phonegap` to post-process the generated `AndroidManifest.xml` and set
the correct value for you.

The value can be any one of the following strings:

  * unspecified
  * behind
  * landscape
  * portrait
  * reverseLandscape
  * reversePortrait
  * sensorLandscape
  * sensorPortrait
  * userLandscape
  * userPortrait
  * sensor
  * fullSensor
  * nosensor
  * user
  * fullUser
  * locked

For an explanation of these options, refer to the `android:screenOrientation` section of [<activity>](https://developer.android.com/guide/topics/manifest/activity-element.html) in the Android developer guide.

This option will be ignored for non-Android platforms or when using the remote build service.
