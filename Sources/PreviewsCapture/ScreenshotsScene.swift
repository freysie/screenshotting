import SwiftUI

public struct ScreenshotsScene: Scene {
  public init(basePath: String = #filePath, configure: ((ScreenshotSettings) -> ())? = nil) {
    DispatchQueue.main.async {
      Task(priority: .userInitiated) {
        let settings = ScreenshotSettings()
        configure?(settings)
        await ScreenshotController(settings: settings).saveAll(basePath: basePath)
      }
    }
  }

  public var body: some Scene {
#if os(macOS)
    Settings { EmptyView() }
#else
    WindowGroup { EmptyView() }
#endif
  }
}
