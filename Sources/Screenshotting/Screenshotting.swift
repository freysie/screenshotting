import SwiftUI
import ObjectiveC

func log(_ string: String) { NSLog("[Screenshotting] \(string)") }

let launchDate = NSRunningApplication.current.launchDate ?? Date()
let isXcodeRunningForPreviews = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
let screenCaptureLocation = UserDefaults(suiteName: "com.apple.screencapture")?.string(forKey: "location")

//@objc public protocol ScreenshotProvider {}

var allPreviewProviders: [any PreviewProvider.Type] {
  if #available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) {
    return objc_enumerateClasses().compactMap { $0 as? any PreviewProvider.Type }
  } else {
    let expectedClassCount = objc_getClassList(nil, 0)
    let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
    defer { allClasses.deallocate() }
    let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
    let actualClassCount = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
    return (0..<actualClassCount).compactMap { allClasses[Int($0)] }
      .compactMap { $0 as? any PreviewProvider.Type }
  }
}

extension Sequence {
  func uniqued<Type: Hashable>(by keyPath: KeyPath<Element, Type>) -> [Element] {
    var set = Set<Type>()
    return filter { set.insert($0[keyPath: keyPath]).inserted }
  }
}
