# Grunt: Phonegap
> A [Grunt](http://gruntjs.com/) plugin to provide build tasks for [Phonegap](http://phonegap.com/) applications

[![Build Status](http://ci.ldk.io/logankoester/grunt-phonegap/badge)](http://ci.ldk.io/logankoester/grunt-phonegap/)
[![Dependency Status](https://david-dm.org/logankoester/grunt-phonegap.png)](https://david-dm.org/logankoester/grunt-phonegap)
[![devDependency Status](https://david-dm.org/logankoester/grunt-phonegap/dev-status.png)](https://david-dm.org/logankoester/grunt-phonegap#info=devDependencies)
[![Gittip](http://img.shields.io/gittip/logankoester.png)](https://www.gittip.com/logankoester/)

[![NPM](https://nodei.co/npm/grunt-phonegap.png?downloads=true)](https://nodei.co/npm/grunt-phonegap/)

`grunt-phonegap` integrates Phonegap development with [Grunt](http://gruntjs.com/)-based workflows
by wrapping the Phonegap 3.0 command line interface.

Rather than polluting the top-level of your project, `grunt-phonegap` copies your files into a
subdirectory containing the Phonegap project, which gets regenerated every time the task `phonegap:build` is executed.
