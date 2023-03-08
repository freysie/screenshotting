# Screenshotting

Save screenshots of views on macOS, iOS<!--, tvOS-->, and watchOS<!--, and xrOS-->.

Have you ever wanted automatically-updating screenshots for your README files? Now you can!

<!--![](Screenshots/Screenshotting.png)-->


## Installation

```swift
.package(url: "https://github.com/freyaalminde/screenshotting.git", branch: "main"),
```

```swift
.product(name: "Screenshotting", package: "screenshotting"),
.product(name: "ScreenshottingRNG", package: "screenshotting"),
```


## Overview

Add `.screenshot()` to a view in order to save screenshots when the view appears in Xcode’s canvas:

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .screenshot() // add this
    }
}
```

You can provide a name and restrict which variants are captured, e.g. if you only want `~light@2x`:

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .screenshot("Content", colorScheme: .light, scale: 2)
    }
}
```

If a folder named “Screenshots” exists next to your Xcode project or Swift package file, screenshots will be saved there.

If no such folder exists, Screenshotting tries to save screenshots to the system’s default screen capture location, falling back to the desktop.


### Seeded Random Number Generators

Screenshotting comes with a set of random number generators which can be initialized with a seed.

* `GKLinearCongruentialRandomSource` (not available on watchOS)
* `GKMersenneTwisterRandomSource` (not available on watchOS)
* `Rand48RandomNumberGenerator`
* `Xoroshiro256StarStarRandomNumberGenerator`


<!--Alternatively, if you want to save all batched screenshots when a view appears, use `.saveAllScreenshots()`.-->
<!---->
<!--This can be useful for example if you’re working on a Swift library package.-->
<!---->
<!--```swift-->
<!--struct ContentView_Previews: PreviewProvider {-->
<!--    static var previews: some View {-->
<!--        ContentView()-->
<!--            .previewLayout(.sizeThatFits)-->
<!--            .saveAllScreenshots() // add this-->
<!--    }-->
<!--}-->
<!--```-->


<!--### Configuation-->
<!---->
<!--Screenshotting has loads of settings which you can finetune.-->
<!---->
<!--You can set the output path, an optional delay, control output filename suffixes, and more.-->
<!---->
<!---->
<!--### More-->
<!---->
<!--`NSMenu` objects can be captured. Use `.cachedDisplay()` to get `Data` of its PNG representation.-->
<!---->
<!--```swift-->
<!--NSMenu().cacheDisplay() // returns PNG data-->
<!--```-->
<!---->
<!---->
<!--### Frequently Asked Questions-->
<!---->
<!--### How is this different from [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)?-->
<!---->
<!--SnapshotTesting is meant for testing while Screenshotting is meant for taking screenshots for documentation and READMEs.-->


<!--By default, screenshots are saved to a “Screenshots” folder in the root directory of your project.-->
<!---->
<!--The output path can be changed using `ScreenshottingSettings`, for example:-->
<!---->
<!--```swift-->
<!--struct ContentView_Previews: PreviewProvider {-->
<!--    static var previews: some View {-->
<!--        ScreenshottingSettings.outputPath = "Documentation.docc/Resources"-->
<!---->
<!--        return Group {-->
<!--            ContentView()-->
<!--                .previewLayout(.sizeThatFits)-->
<!--                .previewScreenshot()-->
<!--        }-->
<!--    }-->
<!--}-->
<!--```-->
<!---->
<!--The output folder will be created if it doesn’t already exist. The project’s root directory is inferred by finding the first parent directory with a `Package.swift`, or any Xcode project or workspace files, relative to the path of the file which calls `previewScreenshot()`.-->

<!--### Capturing Menus-->
<!---->
<!--Instances of `NSMenu` can be captured by Previews Capture by calling `previewScreenshot()` on a menu and adding it to a previews provider.-->
<!---->
<!--![](Screenshots/NSMenu_highlighted~dark.png#gh-dark-mode-only)-->
<!--![](Screenshots/NSMenu_highlighted~light.png#gh-light-mode-only)-->
<!---->
<!--```swift-->
<!--struct Menu_Previews: PreviewProvider {-->
<!--    static let menu = {-->
<!--        let menu = NSMenu()-->
<!--        menu.autoenablesItems = false-->
<!---->
<!--        menu.addItem(withTitle: "Hello, NSMenu!", action: nil, keyEquivalent: "")-->
<!--            .image = NSImage(systemSymbolName: "swift", accessibilityDescription: nil)-->
<!---->
<!--        menu.addItem(.separator())-->
<!---->
<!--        menu.addItem(withTitle: "Hello, NSMenuItem!", action: nil, keyEquivalent: "")-->
<!--            .image = NSImage(systemSymbolName: "filemenu.and.selection", accessibilityDescription: nil)-->
<!---->
<!--        menu.addItem(withTitle: "Hello, Screenshotting!", action: nil, keyEquivalent: "")-->
<!--            .image = NSImage(systemSymbolName: "camera", accessibilityDescription: nil)-->
<!---->
<!--        menu.addItem(withTitle: "Hello, NSMenu Previews!", action: nil, keyEquivalent: "")-->
<!--            .image = NSImage(systemSymbolName: "filemenu.and.cursorarrow", accessibilityDescription: nil)-->
<!---->
<!--        return menu-->
<!--    }()-->
<!---->
<!--    static var previews: some View {-->
<!--        menu.previewScreenshot()-->
<!--    }-->
<!--}-->
<!--```-->

<!--#### `previewScreenshot()`-->
<!--|Dark|Light|-->
<!--|-|-|-->
<!--| ![](Screenshots/NSMenu~dark.png) | ![](Screenshots/NSMenu~light.png) |-->
<!---->
<!--#### `previewScreenshot(highlightItemAtIndex: 0)` -->
<!--|Dark|Light|-->
<!--|-|-|-->
<!--| ![](Screenshots/NSMenu_highlighted~dark.png) | ![](Screenshots/NSMenu_highlighted~light.png) |-->
<!---->
<!--#### `previewScreenshot(includeShadow: false)` -->
<!--|Dark|Light|-->
<!--|-|-|-->
<!--| ![](Screenshots/NSMenu_noShadow~dark.png) | ![](Screenshots/NSMenu_noShadow~light.png) |-->
<!---->

<!---->
<!--### Capturing watchOS Views-->
<!---->
<!--watchOS support is a work in progress, depends on the semi-public `SwiftUI._makeUIHostingView()` function introduced in watchOS 9, and is currently not working correctly.-->
<!---->
