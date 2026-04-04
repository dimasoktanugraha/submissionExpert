// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Detail",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Detail",
            targets: ["Detail"])
    ],
    dependencies: [
      // Dependencies declare other packages that this package depends on.
      .package(url: "https://github.com/realm/realm-swift.git", branch: "master"),
      .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.2")),
      .package(url: "https://github.com/dimasoktanugraha/Modularization-Core-Package.git",
        .upToNextMajor(from: "1.0.0")),
      .package(path: "../Shared")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Detail",
            dependencies: [
                .product(name: "RealmSwift", package: "realm-swift"),
                .product(name: "CorePackage", package: "Modularization-Core-Package"),
                "Alamofire",
                "Shared"
            ]),
        .testTarget(
            name: "DetailTests",
            dependencies: ["Detail"]
        )
    ]
)
