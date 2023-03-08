#if os(macOS)

import AppKit
import SwiftUI
import ScreenshottingObjC

public extension ScreenshotController {
  @MainActor func _saveAll() async {
    let screens = NSScreen.screens.uniqued(by: \.backingScaleFactor)
      .filter { settings.scales.isEmpty || settings.scales.contains($0.backingScaleFactor) }

    //print(_PreviewProvider._previews)

    //_PreviewProviderLocator
    //_PreviewHost.makeHost(providerType: <#T##Any.Type#>)

//    print(Mirror(reflecting: (any PreviewProvider.Type).self).children.count)
//    print(Mirror(reflecting: (any PreviewProvider).self).children.count)

    guard !screens.isEmpty else { fatalError("[Screenshotting] No screens found") }

    //print(NSColorGetUserAccentColor())
    //NSColorSetUserAccentColor(.pink)

    //print(NSColorLocalizedNameForUserAccentKey(6))
//    print(NSColor.controlAccentPink())
//    print(NSColor.controlAccentGreen())

//    print(_NSAppearanceTintColorNameFromUserAccentColor(-2))

//    NSColorEnumerateUserAccentColors {
//      print(($0, $0 >= 0 ? NSColorLocalizedNameForUserAccentKey($0) : nil))
//    }

//    _NSShowDebugMenu()
    //NSUseDebugAppearance()

    //print(_NSUserAccentColorInvalidateForCurrentProcess())

    let appearances = settings.colorSchemes.map { $0.nsAppearanceName }
    //let tintColors: [NSColor?] = [nil]
    let tintColors: [NSColor?] = [
      nil
      //.controlAccentHardware,
//      .controlAccentBlue,
//      .controlAccentPurple,
//      .controlAccentPink,
//      .controlAccentRed,
//      .controlAccentOrange,
//      .controlAccentYellow,
//      .controlAccentGreen,
    ]
    //let tintColors: [NSColor?] = [nil, .systemPink]
    //let controlTints: [NSControlTint] = [.blueControlTint, .graphiteControlTint]

    let progress = Progress(totalUnitCount: Int64(previews.count * screens.count * appearances.count * tintColors.count))
    for (provider, preview) in previews {
      for screen in screens {
        for appearance in appearances {
          for tintColor in tintColors {
            let colorSchemeSuffix = settings.colorSchemeSuffix ? appearance.suffix : ""
            let scaleSuffix = settings.scaleSuffix ? "@\(Int(screen.backingScaleFactor))x" : ""
            let path = filePath(provider, preview, [colorSchemeSuffix, tintColor?.suffix ?? "", scaleSuffix])

            // `performAsCurrentDrawingAppearance()`?
            NSApp.appearance = NSAppearance(named: appearance)?.applyingTintColor(tintColor)

            let window = window(for: preview, on: screen)
            window.layoutIfNeeded()
            if let view = window.contentView {
              if settings.showsWindows {
                window.makeKeyAndOrderFront(self)
              }

              if let delay = settings.delay {
                try! await Task.sleep(nanoseconds: UInt64(delay / 1000) * NSEC_PER_MSEC)
              }

              //NSApp.appearance!.performAsCurrentDrawingAppearance {
                if let data = capture(view) {
                  save(data, toPath: path)
                }
              //}

              if !settings.keepsWindowsOpen {
                window.close()
              }
            }

            progress.completedUnitCount += 1
            NSApp.dockTile.badgeLabel = "\(progress.completedUnitCount)/\(progress.totalUnitCount)"
          }
        }
      }
    }

    if settings.terminatesWhenFinished {
      NSApp.terminate(self)
    }
  }

  @MainActor func save(_ view: AnyView, as name: String, basePathURL: URL) async {
    let screens = NSScreen.screens.uniqued(by: \.backingScaleFactor)
      .filter { settings.scales.isEmpty || settings.scales.contains($0.backingScaleFactor) }

    guard !screens.isEmpty else { fatalError("[Screenshotting] No screens found") }

    let appearances = settings.colorSchemes.map { $0.nsAppearanceName }
    let tintColors: [NSColor?] = [nil]
    //let tintColors: [NSColor?] = [nil, .systemPink]
    //let controlTints: [NSControlTint] = [.blueControlTint, .graphiteControlTint]

    //let progress = Progress(totalUnitCount: Int64(previews.count * screens.count * appearances.count * tintColors.count))
    for screen in screens {
      for appearance in appearances {
        for tintColor in tintColors {
          let colorSchemeSuffix = settings.colorSchemeSuffix ? appearance.suffix : ""
          let scaleSuffix = settings.scaleSuffix ? "@\(Int(screen.backingScaleFactor))x" : ""
          let path = filePath(name, basePathURL: basePathURL, [colorSchemeSuffix, tintColor?.suffix ?? "", scaleSuffix])

          // `performAsCurrentDrawingAppearance()`?
          NSApp.appearance = NSAppearance(named: appearance)?.applyingTintColor(tintColor)

          let window = window(for: view, on: screen)
          window.layoutIfNeeded()
          if let view = window.contentView {
            if settings.showsWindows {
              window.makeKeyAndOrderFront(self)
            }

            if let delay = settings.delay {
              try! await Task.sleep(nanoseconds: UInt64(delay / 1000) * NSEC_PER_MSEC)
            }

            //NSApp.appearance!.performAsCurrentDrawingAppearance {
            if let data = capture(view) {
              save(data, toPath: path)
            }
            //}

            if !settings.keepsWindowsOpen {
              window.close()
            }
          }

          //progress.completedUnitCount += 1
          //NSApp.dockTile.badgeLabel = "\(progress.completedUnitCount)/\(progress.totalUnitCount)"
        }
      }
    }
  }

  func window(for preview: _Preview, on screen: NSScreen) -> NSWindow {
    window(for: preview.content, on: screen)
  }

  func window(for view: AnyView, on screen: NSScreen) -> NSWindow {
    let hostingController = NSHostingController(rootView: view)
    let window = NSWindow(contentRect: .zero, styleMask: [.titled], backing: .buffered, defer: false, screen: screen)
    window.contentViewController = hostingController
    window.setContentSize(hostingController.view.intrinsicContentSize)
    return window
  }

  func capture(_ view: NSView) -> Data? {
    guard let imageRep = view.bitmapImageRepForCachingDisplay(in: view.bounds) else {
      NSLog("[Screenshotting] bitmapImageRepForCachingDisplay() failed for \(view)")
      return nil
    }

    //view.lockFocus()
    //let pdfData = view.dataWithPDF(inside: view.bounds)
    //try? pdfData.write(to: URL(fileURLWithPath: "/tmp/eeeep.pdf"), options: .atomic)
    //save(pdfData, toPath: "/tmp/eeeeep.pdf")
    //view.wantsLayer = true
    view.cacheDisplay(in: view.bounds, to: imageRep)
    //view.unlockFocus()

    // .ditherTransparency: NSNumber(value: true)
    guard let data = imageRep.representation(using: .png, properties: [:]) else {
      NSLog("[Screenshotting] representation() failed for \(view)")
      return nil
    }

    return data
  }
}

// print(("\(previewProvider)", previewProvider.platform, preview.id, preview.displayName, preview.colorScheme, preview.context, preview.contentType, preview.interfaceOrientation.id, preview.device, preview.layout))

#endif
