If you choose to set `phonegap.config.icons` with one or more icon sizes, these files
will be copied into the appropriate directories to use as your app icon.

You may want to use this feature in conjunction with [grunt-rasterize](https://github.com/logankoester/grunt-rasterize)
to generate the correctly sized icon files from an SVG source.

Currently this feature supports Android, Windows Phone 8, and iOS.

##### Example

```js
  phonegap: {
    config: {
      // ...
      icons: {
      	android: {
          ldpi: 'icon-36-ldpi.png',
          mdpi: 'icon-48-mdpi.png',
          hdpi: 'icon-72-hdpi.png',
          xhdpi: 'icon-96-xhdpi.png'
        },
        wp8: {
          app: 'icon-62-tile.png',
          tile: 'icon-173-tile.png'
        },
        ios: {
          icon29: 'icon29.png',
          icon29x2: 'icon29x2.png',
          icon40: 'icon40.png',
          icon40x2: 'icon40x2.png',
          icon50: 'icon50.png',
          icon50x2: 'icon50x2.png',
          icon57: 'icon57.png',
          icon57x2: 'icon57x2.png',
          icon60: 'icon60.png',
          icon60x2: 'icon60x2.png',
          icon72: 'icon72.png',
          icon72x2: 'icon72x2.png',
          icon76: 'icon76.png',
          icon76x2: 'icon76x2.png'
        }
      }
      // ...
    }
  }
```
