#if os(watchOS)

import SwiftUI
import WatchKit
import ScreenshottingWatchSupport

public extension ScreenshotController {
  @MainActor func _saveAll() async {
    let progress = Progress(totalUnitCount: Int64(previews.count))
    for (provider, preview) in previews {
      let deviceSuffix = settings.deviceSuffix ? "_" + WKInterfaceDevice.current().name : ""
      let scaleSuffix = settings.scaleSuffix ? "@\(Int(WKInterfaceDevice.current().screenScale))x" : ""
      let path = filePath(provider, preview, [deviceSuffix, scaleSuffix])

      // print(("\(provider)", provider.platform, preview.id, preview.displayName, preview.colorScheme, preview.context, preview.contentType, preview.interfaceOrientation.id, preview.device, preview.layout))

      if let delay = settings.delay {
        // Thread.sleep(forTimeInterval: delay)
        try! await Task.sleep(nanoseconds: UInt64(delay / 1000) * NSEC_PER_MSEC)
      }

      let hostingController = _makeUIHostingController(preview.content)
      let data = ScreenshotHelper.capture(hostingController)
      save(data, toPath: path)

      progress.completedUnitCount += 1
    }

    if settings.terminatesWhenFinished {
      exit(0)
    }
  }
}

#endif
