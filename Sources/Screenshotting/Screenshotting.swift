import SwiftUI
import ObjectiveC

let launchDate = NSRunningApplication.current.launchDate ?? Date()
let isXcodeRunningForPreviews = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
let screenCaptureLocation = UserDefaults(suiteName: "com.apple.screencapture")?.string(forKey: "location")

func log(_ string: String) { NSLog("[Screenshotting] \(string)") }

@objc public protocol ScreenshotProvider {}

var allScreenshotProviders: [ScreenshotProvider.Type] {
  if #available(macOS 13.0, iOS 16.0, tvOS 16.0, watchOS 9.0, *) {
    log("\(Array(objc_enumerateClasses().compactMap { $0 as? any PreviewProvider.Type }) as NSArray)")

    return objc_enumerateClasses(conformingTo: ScreenshotProvider.self)
      .compactMap { $0 as? ScreenshotProvider.Type }
  } else {
    let expectedClassCount = objc_getClassList(nil, 0)
    let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
    defer { allClasses.deallocate() }
    let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
    let actualClassCount = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
    return (0..<actualClassCount).compactMap { allClasses[Int($0)] }
      .filter { class_conformsToProtocol($0, ScreenshotProvider.self) }
      .compactMap { $0 as? ScreenshotProvider.Type }
  }
}

var allScreenshotProviderPreviews: [(any PreviewProvider.Type, _Preview)] {
  allScreenshotProviders
    .compactMap { $0 as? any PreviewProvider.Type }
    .flatMap { provider in provider._allPreviews.map { (provider, $0) } }
}

extension Sequence {
  func uniqued<Type: Hashable>(by keyPath: KeyPath<Element, Type>) -> [Element] {
    var set = Set<Type>()
    return filter { set.insert($0[keyPath: keyPath]).inserted }
  }
}
