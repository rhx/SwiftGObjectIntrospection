# SwiftGObjectIntrospection

This is a Swift wrapper around [GObject Introspection](https://gi.readthedocs.io/),
a middleware layer between C libraries (using [GObject](https://docs.gtk.org/gobject/))
and language bindings.

## Prerequisites

### Swift

To build, you need at least Swift 5.2 (but some Linux distributions have issues and seem to **require at least Swift 5.5**), download from https://swift.org/download/ -- if you are using macOS, make sure you have the command line tools installed as well).  Test that your compiler works using `swift --version`, which should give you something like

	$ swift --version
	Apple Swift version 5.5.2 (swiftlang-1300.0.47.5 clang-1300.0.29.30)
	Target: x86_64-apple-macosx12.0

on macOS, or on Linux you should get something like:

	$ swift --version
	Swift version 5.5.2 (swift-5.5.2-RELEASE)
	Target: x86_64-unknown-linux-gnu

### gobject-introspection 1.70 or higher

These Swift wrappers have been tested with gobject-introspection-1.70.
They should work with higher versions, but YMMV.
Also make sure you have the appropriate version of `glib` installed.

#### Linux

##### Ubuntu

On Ubuntu 20.04 you can use the glib that comes with the distribution.
Just install with the `apt` package manager:

	sudo apt update
	sudo apt install libglib2.0-dev glib-networking gobject-introspection libgirepository1.0-dev libxml2-dev

##### Fedora

On Fedora 29, you can use the glib that comes with the distribution.  Just install with the `dnf` package manager:

	sudo dnf install glib2-devel gobject-introspection-devel libxml2-devel

#### macOS

On macOS, you can install glib using HomeBrew (for setup instructions, see http://brew.sh).  Once you have a running HomeBrew installation, you can use it to install a native version of glib:

	brew update
	brew install glib glib-networking gobject-introspection pkg-config


## Usage

Normally, you don't build this package directly (but for testing you can - see 'Building' below). Instead you need to embed SwiftGObjectIntrospection into your own project using the [Swift Package Manager](https://swift.org/package-manager/).  After installing the prerequisites (see 'Prerequisites' above), add `SwiftGObjectIntrospection` as a dependency to your `Package.swift` file, e.g.:

```Swift
// swift-tools-version:5.3

import PackageDescription

let package = Package(name: "MyPackage",
    dependencies: [
        .package(name: "GObjectIntrospection",
                  url: "https://github.com/rhx/SwiftGObjectIntrospection.git",
                       .branch("main")
         ),
    ],
    targets: [.target(name: "MyPackage", dependencies: ["GObjectIntrospection"])]
)
```


## Building
Normally, you don't build this package directly, but you embed it into your own project (see 'Usage' above).  However, you can build and test this module separately to ensure that everything works.  Make sure you have all the prerequisites installed (see above).  After that, you can simply clone this repository and build the command line executable (be patient, this will download all the required dependencies and take a while to compile) using

	git clone https://github.com/rhx/SwiftGObjectIntrospection.git
	cd SwiftGObjectIntrospection
    swift build
    swift test

### Xcode

On macOS, you can build the project using Xcode instead.
To do this, just op open the package in the Xcode IDE:

	open Package.swift

After that, use the (usual) Build and Test buttons to build/test this package.
