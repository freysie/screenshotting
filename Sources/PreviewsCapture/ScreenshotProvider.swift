import SwiftUI
import ObjectiveC

@objc public protocol ScreenshotProvider {}

// TODO: use the new `objc_enumerateClasses()` where availables
func getAllScreenshotPreviewProviders() -> [any PreviewProvider.Type] {
  let expectedClassCount = objc_getClassList(nil, 0)
  let allClasses = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(expectedClassCount))
  let autoreleasingAllClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(allClasses)
  let actualClassCount: Int32 = objc_getClassList(autoreleasingAllClasses, expectedClassCount)
  let classes = (0..<actualClassCount).compactMap { allClasses[Int($0)] }
  allClasses.deallocate()

  return classes
    .filter { class_conformsToProtocol($0, ScreenshotProvider.self) }
    .compactMap { $0 as? any PreviewProvider.Type }
}

func getAllScreenshotPreviews() -> [(any PreviewProvider.Type, _Preview)] {
  getAllScreenshotPreviewProviders().flatMap { provider in provider._allPreviews.map { (provider, $0) } }
}
