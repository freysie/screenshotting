import SwiftUI

func moduleName(from fileID: String) -> String {
  fileID
    .firstIndex(of: "/")
    .flatMap { String(fileID[fileID.startIndex..<$0]) }?
    .replacingOccurrences(of: #"_PreviewReplacement_.+_\d+$"#, with: "", options: .regularExpression) ?? ""
}

func createIntermediateFoldersUnlessExists(for path: String) {
  let folderPath = (path as NSString).deletingLastPathComponent
  if !FileManager.default.fileExists(atPath: folderPath) {
    do {
      NSLog("[Screenshotting] creating folder \(folderPath)")
      try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true)
    } catch {
      NSLog("[Screenshotting] error: \(error)")
    }
  }
}

func outputPath(_ path: String?, _ name: String?, _ styleSuffix: String? = nil, scale: CGFloat? = nil) -> String {
  // let timeSuffix = ".\(Date().timeIntervalSince1970)"
  let timeSuffix = ""
  let scaleSuffix = scale.map { "@\(Int($0))x" }

  return "\(path ?? "/tmp")/\(name ?? "Screenshot")\(timeSuffix)\(styleSuffix ?? "")\(scaleSuffix ?? "").png"
}

func writeScreenshot(_ data: Data, to path: String) {
  do {
    NSLog("[Screenshotting] writing \(path)")
    try data.write(to: URL(fileURLWithPath: path))
  } catch {
    NSLog("[Screenshotting] error: \(error)")
  }
}

#if os(iOS)
extension UIUserInterfaceStyle {
  var fileSuffix: String {
    switch self {
    case .unspecified: return ""
    case .light: return "~light"
    case .dark: return "~dark"
    @unknown default: return ""
    }
  }
}
#endif

#if canImport(AppKit)
extension NSAppearance {
  var fileSuffix: String {
    switch name {
    case .aqua: return "~light"
    case .darkAqua: return "~dark"
    case .accessibilityHighContrastAqua: return "~lightHighContrast"
    case .accessibilityHighContrastDarkAqua: return "~darkHighContrast"
    default: return ""
    }
  }
}
#endif

#if os(macOS)
fileprivate let osSuffix = "_macOS"
#elseif os(iOS)
fileprivate let osSuffix = "_iOS"
#elseif os(tvOS)
fileprivate let osSuffix = "_tvOS"
#elseif os(watchOS)
fileprivate let osSuffix = "_watchOS"
#endif

//public enum OSInterpolation {
//  case folderPrefix
//  case underscorePrefix
//  case tildeSuffix
//}
