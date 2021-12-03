// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Search",
  platforms: [.iOS(.v15), .macOS(.v11)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(
      name: "Search",
      targets: ["Search"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.4.4")),
    .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0"),
    .package(url: "https://github.com/alifrizkip/GGGamingCore", .upToNextMajor(from: "1.0.0")),
    .package(path: "../Common")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Search",
      dependencies: [
        "Alamofire",
        "Swinject",
        "GGGamingCore",
        "Common"
      ]),
    .testTarget(
      name: "SearchTests",
      dependencies: ["Search"]),
  ]
)
