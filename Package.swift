// swift-tools-version: 5.4
import PackageDescription

let package = Package(
  name: "screenshotting",
  platforms: [
    .macOS("12.0"),
    .iOS("15.0"),
    .watchOS("8.0"),
  ],
  products: [
    .library(name: "Screenshotting", targets: ["Screenshotting"]),
    .library(name: "ScreenshottingRNG", targets: ["ScreenshottingRNG"]),
  ],
  targets: [
    .target(name: "Screenshotting", dependencies: [
      //.target(name: "ScreenshottingUtilities", condition: .when(platforms: [.macOS])),
      .target(name: "ScreenshottingWatchSupport", condition: .when(platforms: [.watchOS])),
    ]),
    .target(name: "ScreenshottingRNG"),
    //.target(name: "ScreenshottingUtilities", publicHeadersPath: "."),
    .target(name: "ScreenshottingWatchSupport", publicHeadersPath: "."),
  ]
)
