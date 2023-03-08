import SwiftUI

public struct ScreenshottingScene: Scene {
  public init() {
    guard !isXcodeRunningForPreviews else { return }

//    for (provider, preview) in allScreenshotProviderPreviews {
//      //guard let context = preview.context as? ScreenshotPreviewContext else { continue }
//      let controller = NSHostingController(rootView: preview.content)
//      let window = NSWindow(contentViewController: controller)
//    }
  }

  public var body: some Scene {
#if os(macOS)
    Settings { EmptyView() }
#else
    WindowGroup { EmptyView() }
#endif
  }
}

//struct OutputSuffix: OptionSet {
//  let rawValue: Int
//
//  static let time     = Self(rawValue: 1 << 0)
//  static let platform = Self(rawValue: 1 << 1)
//  static let destroy  = Self(rawValue: 1 << 2)
//
//  static let all: Self = [.time, .platform]
//}
//
//let d = OutputSuffix.all.subtracting(.time)
