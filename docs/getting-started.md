This plugin requires Grunt `~0.4.1`

If you haven't used [Grunt](http://gruntjs.com/) before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-phonegap --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-phonegap');
```

## Without phonegap installed globally

The following steps allow grunt-phonegap to work without phonegap installed globally. First add phonegap as a development dependency:

```shell
npm install phonegap --save-dev
```

Now install [grunt-env](https://github.com/jsoverson/grunt-env).

```shell
npm install grunt-env
```

Once both are installed, add the configuration to the Gruntfile. The following is an example:

```js
module.exports = function (grunt) {
    grunt.initConfig({
        env: {
            phonegap: {
                unshift: {
                    PATH: {
                        'value': '../node_modules/.bin',
                        'delimiter': ':'
                    }
                }
            }
        }
    }
    ...
    grunt.loadNpmTasks('grunt-env');
    grunt.loadNpmTasks('grunt-phonegap');

    // this task loads the phonegap envoirment before build.
    grunt.registerTask('ios', ['env:phonegap', 'phonegap:build:ios']);
}
```
