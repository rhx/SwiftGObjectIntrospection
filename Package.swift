// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "GObjectIntrospection",
    products: [
        .library(
            name: "GObjectIntrospection",
            targets: ["GObjectIntrospection"]),
    ],
    dependencies: [
    ],
    targets: [
        .systemLibrary(name: "CGObjectIntrospection", pkgConfig: "gobject-introspection-1.0",
            providers: [
                .brew(["glib", "glib-networking", "gobject-introspection"]),
                .apt(["libglib2.0-dev", "glib-networking", "gobject-introspection", "libgirepository1.0-dev"])
            ]),
        .target(
            name: "GObjectIntrospection",
            dependencies: ["CGObjectIntrospection"],
            swiftSettings: [.unsafeFlags(["-Xfrontend", "-serialize-debugging-options"], .when(configuration: .debug))]
        ),
        .testTarget(
            name: "GObjectIntrospectionTests",
            dependencies: ["GObjectIntrospection"]),
    ]
)
