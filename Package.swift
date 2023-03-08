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
    .target(name: "Screenshotting", dependencies: ["ScreenshottingObjC"]),
    .target(name: "ScreenshottingObjC", publicHeadersPath: "."),
    .target(name: "ScreenshottingRNG"),
  ]
)
