If `phonegap.config.permissions` is omitted, plugin permissions will be set automatically by Phonegap. In most cases, this is what you want.

Ordinarily with Phonegap (local), permissions for the Android platform are written to `AndroidManifest.xml`
based on the requirements of the plugins that you have added to your project, so you do not have to worry
about them.

In some (perhaps unusual) situations, you may want to alter these permissions without modifying a plugin.

When you may want to do this:

* To reserve not-yet-used permissions during development
* To enable a plugin that does not require the right permissions for your target version of Android
* While troubleshooting a permissions error in your app.
* When using an advanced Grunt workflow to set your permissions for different builds dynamically (by specifying `phonegap.config.permissions` as a function)

If you need this feature, set `phonegap.config.permissions` to an array of permission basenames, such as ['ACCESS_NETWORK_STATE'].

When `phonegap.config.permissions` is set, **all permissions added by Cordova + plugins will be removed**, giving
you complete control over the permission manifest.

This means you need to explicitely add any permissions required by plugins, or your app will not work.

Be careful to check any permissions your plugins need before adding this feature to your app, and remember to update it
when adding additional plugins later.

If you are using the Phonegap Build cloud service for the Android platform, this setting will have no effect.
