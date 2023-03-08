import Foundation

extension ProcessInfo {
  static var isXcodeRunningForPreviews: Bool {
    processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
  }
}
