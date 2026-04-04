// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Shared",
            targets: ["Shared"])
    ],
    dependencies: [
      // Dependencies declare other packages that this package depends on.
      .package(url: "https://github.com/dimasoktanugraha/Modularization-Core-Package.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Shared",
            dependencies: [
              .product(name: "CorePackage", package: "Modularization-Core-Package"),
            ]),
        .testTarget(
            name: "SharedTests",
            dependencies: ["Shared"]
        )
    ]
)
