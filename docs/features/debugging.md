When you use `phonegap:release` to build an apk package for the Android platform,
`grunt-phonegap` will post-process the phonegap-generated `AndroidManifest.xml`
file to set `debuggable=false`, **unless** you set the `phonegap.config.debuggable`
option to true.

A debuggable package cannot be published to the Play store. If you want to generate
an unsigned, debuggable package for testing on your own devices, you can use the
`phonegap:debug:android` task instead to do this.

This feature exists to ensure we get the intended behavior no matter what
Phonegap version you are using. In Phonegap 4.3.x, the release apk is created
with debuggable=true regardless of whether a debug certificate was used. In
Phonegap 4.4.x, this has been corrected.
