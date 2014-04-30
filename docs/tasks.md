#### phonegap:build[:platform]

Running `phonegap:build` with no arguments will...

* Purge your `phonegap.config.path`
* Copy your `phonegap.config.cordova` and `phonegap.config.root` files into it
* Add any plugins listed in `phonegap.config.plugins`
* ..and then generate a Phonegap build for all platforms listed in `phonegap.config.platforms`

If you pass a specific platform as an argument (eg `grunt phonegap:build:android`), the `phonegap.config.platforms` array will be
ignored and only that specific platform will be built.

#### phonegap:run[:platform][:device]

After a build is complete, the `phonegap:run` grunt task can be used to launch your app
on an emulator or hardware device. It accepts two optional arguments, `platform` and `device`.

Example: `grunt phonegap:run:android:emulator`

If you are using the Android platform, you can see the list of connected devices by running `adb devices`.

The platform argument will default to the first platform listed in `phonegap.config.platforms`.

#### phonegap:release[:platform]

Create a releases/ directory containing a signed application package for distribution.

Currently `android` is the only platform supported by this task. You will need to create
a keystore file at `phonegap.config.key.store` like this:

    $ keytool -genkey -v -keystore release.keystore -alias release -keyalg RSA -keysize 2048 -validity 10000

The keytool command will interactively ask you to set store and alias passwords, which must match
the return value of `phonegap.config.key.aliasPassword` and `phonegap.config.key.storePassword` respectively.

#### phonegap:debug[:platform]

Creates a releases/debug directory containing an unsigned application package with debugging enabled.

Currently `android` is the only platform supported by this task.

By browsing to this APK asset from test hardware device, we can quickly install the APK output from our build.
Then we use chrome://inspect to inspect the network traffic as an example - this is not possible using the signed APK.

#### phonegap:login

Log into the Phonegap Build service with the credentials specified at `phonegap.config.remote.username`
and `phonegap.config.remote.password`.

#### phonegap:logout

Log out of the Phonegap Build service.
