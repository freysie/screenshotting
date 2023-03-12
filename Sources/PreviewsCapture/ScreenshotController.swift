import SwiftUI

@objcMembers public class ScreenshotController {
  public static let shared = ScreenshotController()

  public let settings: ScreenshotSettings

  public init(settings: ScreenshotSettings = .default) {
    self.settings = settings
  }

  public internal(set) var basePathURL: URL!
  public internal(set) var startTime: Date?
  public internal(set) var previews = [(any PreviewProvider.Type, _Preview)]()

  public var timeSuffix: String {
    guard settings.timeSuffix else { return "" }
    return "_\((startTime ?? NSRunningApplication.current.launchDate!).timeIntervalSince1970)"
  }

  public var platformSuffix: String {
    guard settings.platformSuffix else { return "" }

#if os(macOS)
    return "_macOS"
#elseif os(iOS)
    return "_iOS"
#elseif os(tvOS)
    return "_tvOS"
#elseif os(watchOS)
    return "_watchOS"
#endif
  }

  @MainActor public func saveAll(basePath: String = #filePath) async {
    basePathURL = URL(fileURLWithPath: basePath)
    startTime = Date()
    previews = getAllScreenshotPreviews()

    await _saveAll()
  }

  public func filePath(_ name: String, basePathURL: URL, _ suffixes: [String]) -> String {
    var fullName = ([name, timeSuffix, platformSuffix] + suffixes).joined()

    if settings.replacesWhitespaceWithUnderscores {
      fullName = fullName.replacingOccurrences(of: " ", with: "_")
    }

    let folder = URL(fileURLWithPath: settings.outputPath, relativeTo: basePathURL)
    let url = folder.appendingPathComponent(fullName).appendingPathExtension("png")
    return url.path
  }

  public func filePath(_ provider: any PreviewProvider.Type, _ preview: _Preview, _ suffixes: [String]) -> String {
    var name = "\("\(provider)".deletingSuffix("_Previews"))_\(preview.displayName ?? "\(preview.id)")"

    if settings.omitsZeroIfOnlyPreview, provider._allPreviews.count == 1 {
      name = name.deletingSuffix("_0")
    }

    return filePath(name, basePathURL: basePathURL, suffixes)
  }

  public func save(_ data: Data, toPath path: String) {
    // if settings.createsIntermediateFolders {
      createIntermediateFoldersIfNecessary(for: path)
    // }

    do {
      try data.write(to: URL(fileURLWithPath: path), options: .atomic)
      NSLog("[Screenshotting] wrote \(path)")
    } catch {
      NSLog("[Screenshotting] write error: \(error)")
    }
  }

  private func createIntermediateFoldersIfNecessary(for path: String) {
    let folderPath = (path as NSString).deletingLastPathComponent

    if !FileManager.default.fileExists(atPath: folderPath) {
      do {
        try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true)
        NSLog("[Screenshotting] created folder \(folderPath)")
      } catch {
        NSLog("[Screenshotting] folder creation error: \(error)")
      }
    }
  }
}
