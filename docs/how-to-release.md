### How to create a release

The following procedure is documented only for project owners. If you're not an owner/maintainer, see [CONTRIBUTING.md](https://github.com/logankoester/grunt-phonegap/blob/master/CONTRIBUTING.md) instead for instructions on contributing to `grunt-phonegap`.

1. Add a file at `docs/releases/vx.y.z.md` (the version you're planning to bump to) detailing the changes made. See [v0.9.2.md](https://github.com/logankoester/grunt-phonegap/blob/master/docs/releases/v0.9.2.md) for an example. These should be documented at a user-level, not a commit summary. Just the important stuff.

2. Run `grunt docs`, which will regenerate the README (to add your release notes)

3. Run `grunt bump:[major|minor|patch]` to bump the version number and tag a release.

4. Push to **master** with `git push origin master; git push --tags`.

5. Watch the build job at http://ci.ldk.io/logankoester/grunt-phonegap/ and ensure that it passes.

6. `npm publish`
