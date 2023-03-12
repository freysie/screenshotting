#if os(iOS)

import SwiftUI

// TODO: try adding explicit scale support (via `UIGraphicsImageRendererFormat.scale`)

public extension ScreenshotController {
  @MainActor func _saveAll() async {
    guard let windowScene = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).first else {
      fatalError("[Screenshotting] No scenes")
    }

    let uiStyles: [UIUserInterfaceStyle] = [.light, .dark]

    let progress = Progress(totalUnitCount: Int64(previews.count * uiStyles.count))
    for (provider, preview) in previews {
      for uiStyle in uiStyles {
        let idiomSuffix = settings.idiomSuffix ? UIDevice.current.userInterfaceIdiom.suffix : ""
        let deviceSuffix = settings.deviceSuffix ? "_" + UIDevice.current.name : ""
        let colorSchemeSuffix = settings.colorSchemeSuffix ? uiStyle.suffix : ""
        let scaleSuffix = settings.scaleSuffix ? "@\(Int(windowScene.screen.scale))x" : ""
        let path = filePath(provider, preview, [idiomSuffix, deviceSuffix, colorSchemeSuffix, scaleSuffix])

        // print(("\(provider)", provider.platform, preview.id, preview.displayName, preview.colorScheme, preview.context, preview.contentType, preview.interfaceOrientation.id, preview.device, preview.layout))

        UIView.appearance().overrideUserInterfaceStyle = uiStyle

        if let delay = settings.delay {
          // Thread.sleep(forTimeInterval: delay)
          try! await Task.sleep(nanoseconds: UInt64(delay / 1000) * NSEC_PER_MSEC)
        }

        let hostingController = UIHostingController(rootView: preview.content)
        let window = UIWindow(windowScene: windowScene)
        window.windowLevel = .statusBar
        window.rootViewController = hostingController
        window.makeKeyAndVisible()

        if let data = capture(hostingController.view) {
          save(data, toPath: path)
        }

        progress.completedUnitCount += 1
      }
    }

    if settings.terminatesWhenFinished {
      exit(0)
    }
  }

  func capture(_ view: UIView) -> Data? {
    UIGraphicsImageRenderer(bounds: view.bounds).pngData { _ in
      view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    }
  }
}

#endif
