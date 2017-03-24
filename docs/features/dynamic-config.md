Beginning with **v0.4.1**, `phonegap.config` may be either a string or an object.

As a string, the file is copied directly, as with previous versions.

As an object with the keys `template<String>` and `data<Object>`, the file at `template` will
be processed using [grunt.template](http://gruntjs.com/api/grunt.template).


##### Example

**Gruntfile.js**


```js
  // ...
  phonegap: {
    config: {
      template: '_myConfig.xml',
      data: {
        id: 'com.grunt-phonegap.example'
        version: grunt.pkg.version
        name: grunt.pkg.name
      }
  // ...
```

**_myConfig.xml**

```xml
<?xml version='1.0' encoding='utf-8'?>
<widget
  id="<%= id %>"
  version="<%= version %>"
  xmlns="http://www.w3.org/ns/widgets"
  xmlns:gap="http://phonegap.com/ns/1.0">

    <name><%= name %></name>

    <!-- ... -->
</widget>

```
