import SwiftUI
import Combine
import ObjectiveC

// ScreenshottingSettings.outputPath = "Documentation.docc/Resources"
// ScreenshottingSettings.savesFromXcode = false

public struct ScreenshottingSettings {
  // public static var current = Self()
  // public static func configure() {}
  public static var outputPath = "../../Screenshots"
  // public static var savesFromXcode = true
  
#if os(macOS)
  public static var appearances: [NSAppearance.Name] = [.aqua, .darkAqua]
#elseif os(iOS)
  public static var appearances: [UIUserInterfaceStyle] = [.light, .dark]
#endif
}

@objc public protocol PreviewCaptureBatch {
//  associatedtype Previews: View
//  @ViewBuilder static var previews: Self.Previews { get }
}

public struct _PreviewCaptureBatchScene: Scene {
  public init() {
    _PreviewCaptureBatchLocator.saveAll()
  }

  public var body: some Scene {
#if os(macOS)
    Settings { EmptyView() }
#else
    WindowGroup { EmptyView() }
#endif
  }
}

public struct _PreviewCaptureBatchLocator {
  // TODO: use the new `objc_enumerateClasses()` where availables
  static var allClasses: [AnyClass] {
    let expectedClassCount = objc_getClassList(nil, 0)
    let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
    
    let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
    let actualClassCount: Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
    
    var classes = [AnyClass]()
    for i in 0 ..< actualClassCount {
      if let currentClass: AnyClass = allClasses[Int(i)] {
        classes.append(currentClass)
      }
    }
    
    allClasses.deallocate()
    return classes
  }
  
  public static var batches: [PreviewCaptureBatch.Type] {
    allClasses
      .filter({ class_conformsToProtocol($0, PreviewCaptureBatch.self) })
      .compactMap { $0 as? PreviewCaptureBatch.Type }
  }
  
  public static func saveAll() {
    Task {
      //      print("NSApp.mainMenu = \(NSApp.mainMenu!.items.first!.submenu)")
      
#if os(macOS)
      await MainActor.run { NSApp.appearance = NSAppearance(named: .darkAqua) }
#elseif os(iOS)
      await MainActor.run { UIView.appearance().overrideUserInterfaceStyle = .dark }
#endif
      await save()
      
#if os(macOS)
      await MainActor.run { NSApp.appearance = NSAppearance(named: .aqua) }
#elseif os(iOS)
      await MainActor.run { UIView.appearance().overrideUserInterfaceStyle = .light }
#endif
      await save()
      
      // await MainActor.run { NSApp.appearance = NSAppearance(named: .accessibilityHighContrastDarkAqua) }
      // await _PreviewCaptureBatchLocator.saveAll()
      
      // await MainActor.run { NSApp.appearance = NSAppearance(named: .accessibilityHighContrastAqua) }
      // await _PreviewCaptureBatchLocator.saveAll()
      
#if os(macOS)
      await NSApp.terminate(nil)
#elseif os(iOS)
      exit(0)
#endif
    }
  }

  @MainActor
  static func save() async {
#if compiler(<5.7)
    NSLog("[Screenshotting] save() is unavailable unless compiled with Swift 5.7 or later")
#else
    for batch in batches {
      // Mirror(reflecting: batch)
//      let batchName = "\(batch)".replacingOccurrences(of: "_Previews", with: "")
      for preview in (batch as? any PreviewProvider.Type)?._allPreviews ?? [] {
#if os(macOS)
        let controller = NSHostingController(rootView: preview.content)
//        NSLog("[Screenshotting] \(batchName) \(preview.id) \(controller.view.intrinsicContentSize)")

//        let controller = ScreenshotHostingController(rootView: preview.content)
//        controller.path = "/tmp"
//        controller.path = "\(batchName)_\(preview.id)"

        var contentSize = controller.view.intrinsicContentSize
        if contentSize.width < 0 { contentSize.width = 480 }
        if contentSize.height < 0 { contentSize.width = 320 }

        let window = NSWindow(contentViewController: controller)
        window.setContentSize(contentSize)

        // print(window.screen!.localizedName)

        // let oneXScreen = NSScreen.screens.first(where: { $0.backingScaleFactor == 1 })
        if let twoXScreen = NSScreen.screens.first(where: { $0.backingScaleFactor == 2 }) {
          window.setFrameOrigin(NSMakePoint(twoXScreen.visibleFrame.midX, twoXScreen.visibleFrame.midY))
        }

        // print(window.screen!.localizedName)
        // window.makeKeyAndOrderFront(nil)

        // captureScreenshot(controller.view, "/tmp", "\(batchName)_\(preview.id)")
        
        await withUnsafeContinuation { continuation in
          var publisher: AnyCancellable!
          publisher = NotificationCenter.default.publisher(for: .ScreenshottingDidSaveScreenshot)
            .sink {
              if $0.object as? NSWindow == window {
                window.close()
                publisher.cancel()
                continuation.resume()
              }
            }
        }
#elseif os(iOS)
        let controller = UIHostingController(rootView: preview.content)
//        NSLog("[Screenshotting] \(batchName) \(preview.id) \(controller.view.intrinsicContentSize)")

        var contentSize = controller.view.intrinsicContentSize
        if contentSize.width < 0 { contentSize.width = 480 }
        if contentSize.height < 0 { contentSize.width = 320 }

        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        scene?.keyWindow?.rootViewController?.present(controller, animated: false)

//        let window = UIWindow()
//        window.rootViewController = controller
//        window.makeKeyAndVisible()
        // window.intrinsicContentSize = contentSize
        // window.makeKeyAndOrderFront(nil)

        // captureScreenshot(controller.view, "/tmp", "\(batchName)_\(preview.id)")

        await withCheckedContinuation { continuation in
          var publisher: AnyCancellable!
          publisher = NotificationCenter.default.publisher(for: .ScreenshottingDidSaveScreenshot)
            .sink { _ in
              controller.dismiss(animated: false)
              publisher.cancel()
              continuation.resume()
            }
        }
#endif
      }
    }
#endif
  }
}

extension NSNotification.Name {
  static let ScreenshottingDidSaveScreenshot = Self("ScreenshottingDidSaveScreenshot")
}
