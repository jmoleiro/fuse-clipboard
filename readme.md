# FUSE Clipboard Manager Base Class

This is a base Clipboard class for Fuse Tools

Currently you can only copy text to clipboard on Android and iOS.
More features will be added later.

## How to use

Just add the `clipboard.uno` file to your project. Then you can use from
Javascript like this sample:

```JavaScript

var clip = require("ClipboardManager");
clip.setText("Just copied to clipboard!");

```

## ToDo's

* Support for Pasting
* Support for copy and paste images and other types of content
* Clipboard monitoring mechanism
