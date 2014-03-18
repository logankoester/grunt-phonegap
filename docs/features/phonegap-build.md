If you set `phonegap.config.remote` to a subset of `phonegap.config.platforms`, those platforms will be built remotely. This is still somewhat
experimental, and may not integrate with all local features.

If you use Phonegap Build, you should add your Phonegap App ID to your `.cordova/config.json` file - otherwise each build will be treated as a new app toward your account quota.

Example: `{"lib":{"www":{"id":"phonegap","version":"3.3.0"}}, "phonegap": {"id": 1234567}}`

You can find the PhoneGap App ID in your PhoneGap Builds panel.
