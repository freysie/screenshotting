#if canImport(UIKit) && !os(watchOS)

import SwiftUI
import UIKit

extension ColorScheme {
  var uiUserInterfaceStyle: UIUserInterfaceStyle {
    switch self {
    case .light: return .light
    case .dark: return .dark
    @unknown default: fatalError()
    }
  }
}

extension UIUserInterfaceStyle {
  var suffix: String {
    switch self {
    case .unspecified: return ""
    case .light: return "~light"
    case .dark: return "~dark"
    @unknown default: fatalError()
    }
  }
}

extension UIUserInterfaceIdiom {
  var suffix: String {
    switch self {
    case .unspecified: return ""
    case .phone: return "_phone"
    case .pad: return "_pad"
    case .tv: return "_tv"
    case .carPlay: return "_carPlay"
    case .mac: return "_mac"
    @unknown default: fatalError()
    }
  }
}

#endif
