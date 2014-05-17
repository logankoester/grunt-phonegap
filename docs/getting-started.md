If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

### For new apps

The easiest way to start a new project is with the [grunt-init-phonega](https://github.com/logankoester/grunt-init-phonegap) template.

It will ask you some basic questions and then generate a project skeleton in your current directory.

```shell
git clone https://github.com/logankoester/grunt-init-phonegap.git ~/.grunt-init/phonegap
mkdir myapp
cd myapp
grunt-init phonegap
```
Once the skeleton has generated, open up your new `Gruntfile.coffee` add one or more platforms to the list.

Your app is ready to build! [[Skip to Tasks]](#tasks) to see how.

### For existing apps

```shell
npm install grunt-phonegap --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-phonegap');
```

