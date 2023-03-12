import AppKit
import SwiftUI
#if os(macOS)
//import ScreenshottingUtilities
#elseif os(watchOS)
import ScreenshottingWatchSupport
#endif

struct ScreenshotPreviewContext: PreviewContext {
  subscript<Key>(key: Key.Type) -> Key.Value where Key: PreviewContextKey { Key.defaultValue }

  var name: String?
  var colorScheme: ColorScheme?
  var scale: CGFloat?
}

public extension View {
  func screenshot(
    _ name: String,
    colorScheme: ColorScheme? = nil,
    scale: CGFloat? = nil,
    filePath: String = #filePath
  ) -> some View {
    let context = ScreenshotPreviewContext(
      name: name,
      colorScheme: colorScheme,
      scale: scale
    )

    return Group {
      if !isXcodeRunningForPreviews {
        previewContext(context)
      } else {
        overlay {
          _WindowReader { previewWindow in
            guard isXcodeRunningForPreviews else { return }

            saveScreenshot(
              for: previewWindow,
              view: AnyView(self),
              filePath: filePath,
              context: context
            )
          }
        }
      }
    }
  }
}

//    let dateFormatter = DateFormatter()
//    dateFormatter.locale = .autoupdatingCurrent
//    dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:MM:ss a"

func outputDirectoryPath(for filePath: String) -> String {
  projectDirectoryPath(for: filePath) ?? screenCaptureLocation ?? "~/Desktop"
}

func projectDirectoryPath(for filePath: String, fileManager: FileManager = .default) -> String? {
  var url = URL(fileURLWithPath: filePath)

  while url.path != "/" {
    url = url.deletingLastPathComponent()

    if fileManager.fileExists(atPath: url.appendingPathComponent("Package.swift").path) {
      if fileManager.fileExists(atPath: url.appendingPathComponent("Screenshots").path) {
        return url.appendingPathComponent("Screenshots").path
      }
    }

    let contents = try! FileManager.default.contentsOfDirectory(atPath: url.path)
    if contents.contains(where: { $0.hasSuffix(".xcodeproj") || $0.hasSuffix(".xcworkspace") }) {
      if fileManager.fileExists(atPath: url.appendingPathComponent("Screenshots").path) {
        return url.appendingPathComponent("Screenshots").path
      }
    }
  }

  return nil
}

func saveScreenshot(
  for previewWindow: NSWindow,
  view: AnyView,
  filePath: String,
  context: ScreenshotPreviewContext
) {
  for appearance in [NSAppearance(named: .aqua)!, NSAppearance(named: .darkAqua)!] {
    for screen in NSScreen.screens.uniqued(by: \.backingScaleFactor) {
      if let scale = context.scale, scale != screen.backingScaleFactor { continue }
      if let colorScheme = context.colorScheme, colorScheme.nsAppearanceName != appearance.name { continue }

      let name = [
        context.name,
        //window.effectiveAppearance.name.suffix,
        appearance.name.suffix,
        "@\(Int(screen.backingScaleFactor))x"
      ]

      let filename = "\(name.compactMap { $0 }.joined()).png"
      let url = URL(fileURLWithPath: outputDirectoryPath(for: filePath)).appendingPathComponent(filename)

      //log("path = \(url.path), launchDate = \(launchDate)")

      let modifiedAt = try? FileManager.default.attributesOfItem(atPath: url.path)[.modificationDate] as? Date
      if let modifiedAt, launchDate.timeIntervalSince(modifiedAt) < 30 {
        //log("modifiedAt = \(modifiedAt); Δ = \(launchDate.timeIntervalSince(modifiedAt))")
        //log("Too soon; skipping")
        continue
      }

      let window = NSWindow(view: view, screen: screen)
      //window.appearance = window.effectiveAppearance.applyingTintColor(.controlAccentPink)
      //window.appearance = NSAppearance(named: window.effectiveAppearance.name)!.applyingTintColor(.controlAccentPink)!
      //window.appearance = appearance.applyingTintColor(.controlAccentPink)!
      window.appearance = appearance
      window.setContentSize(previewWindow.frame.size)
      //log("\(window)")
      window.perform(Selector(("uv_acquireMainAppearance")))
      window.perform(Selector(("uv_acquireKeyAppearance")))

      DispatchQueue.main.async {
        //              //              NSAppearance.currentDrawing().applyingTintColor(NSColor.controlAccentPink)?.performAsCurrentDrawingAppearance {
        //log("\(url)")
        guard let data = window.contentView?.pngData else { return }
        data.writeAtomicallyCreatingIntermediateDirectoriesIfNecessary(toPath: url.path)
      }
    }
  }
}

//extension NSWindow {
//  func move(to screen: NSScreen) {
//    setFrameOrigin(screen.visibleFrame.origin)
//  }
//}

extension NSAppearance.Name {
  var suffix: String {
    switch self {
    case .aqua: return "~light"
    case .darkAqua: return "~dark"
    case .accessibilityHighContrastAqua: return "~lightHighContrast"
    case .accessibilityHighContrastDarkAqua: return "~darkHighContrast"
    default: return ""
    }
  }
}

extension ColorScheme {
  var nsAppearanceName: NSAppearance.Name {
    switch self {
    case .light: return .aqua
    case .dark: return .darkAqua
    @unknown default: fatalError()
    }
  }
}

extension NSView {
  var pngData: Data? {
    guard let imageRep = bitmapImageRepForCachingDisplay(in: bounds) else {
      log("bitmapImageRepForCachingDisplay() failed for \(self)")
      return nil
    }

    cacheDisplay(in: bounds, to: imageRep)

    guard let data = imageRep.representation(using: .png, properties: [:]) else {
      log("representation() failed for \(self)")
      return nil
    }

    return data
  }
}

extension Data {
  func writeAtomicallyCreatingIntermediateDirectoriesIfNecessary(toPath path: String) {
    let directoryPath = (path as NSString).deletingLastPathComponent

    if !FileManager.default.fileExists(atPath: directoryPath) {
      do {
        try FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true)
        log("created directory \(directoryPath)")
      } catch {
        log("directory creation error: \(error)")
      }
    }

    do {
      try write(to: URL(fileURLWithPath: path), options: .atomic)
      log("wrote \(path)")
    } catch {
      log("write error: \(error)")
    }
  }
}

extension NSWindow {
  convenience init(view: some View, screen: NSScreen) {
    let hostingController = NSHostingController(rootView: view)
    self.init(contentRect: .zero, styleMask: [.titled], backing: .buffered, defer: false, screen: screen)
    contentViewController = hostingController
    setContentSize(hostingController.view.intrinsicContentSize)
  }
}
