#if os(iOS)

import UIKit
import SwiftUI

struct ScreenshotWriter<Content: View>: UIViewControllerRepresentable {
  var path: String?
  var name: String?

  @ViewBuilder var content: Content

  func makeUIViewController(context: Context) -> ScreenshotHostingController<Content> {
    ScreenshotHostingController(rootView: content)
  }

  func updateUIViewController(_ viewController: ScreenshotHostingController<Content>, context: Context) {
    viewController.path = path
    viewController.name = name
  }
}

class ScreenshotHostingController<Content: View>: UIHostingController<Content> {
  var path: String?
  var name: String?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    //NSLog("[Screenshotting] preferredContentSizeCategory = \(view.traitCollection.preferredContentSizeCategory)")
    // NSLog("[Screenshotting] \(view.traitCollection)")
    guard view.traitCollection.preferredContentSizeCategory == .large else { return }

    let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
    let data = renderer.pngData { _ in
      view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    }

    let path = outputPath(path, name, view.traitCollection.userInterfaceStyle.fileSuffix, scale: UIScreen.main.scale)
    createIntermediateFoldersUnlessExists(for: path)
    writeScreenshot(data, to: path)

    NotificationCenter.default.post(name: .ScreenshottingDidSaveScreenshot, object: view.window)
  }
}

#endif
