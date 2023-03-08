#if canImport(AppKit)

import SwiftUI
import AppKit

extension ColorScheme {
  var nsAppearance: NSAppearance {
    switch self {
    case .light: return NSAppearance(named: .aqua)!
    case .dark: return NSAppearance(named: .darkAqua)!
    @unknown default: fatalError()
    }
  }

  var nsAppearanceName: NSAppearance.Name {
    switch self {
    case .light: return .aqua
    case .dark: return .darkAqua
    @unknown default: fatalError()
    }
  }
}

extension NSAppearance.Name {
  var suffix: String {
    switch self {
    case .aqua: return "~light"
    case .darkAqua: return "~dark"
    case .accessibilityHighContrastAqua: return "~lightHighContrast"
    case .accessibilityHighContrastDarkAqua: return "~darkHighContrast"
    default: return ""
    }
  }
}

extension NSControlTint {
  var suffix: String {
    switch self {
    case .graphiteControlTint: return "~graphite"
    default: return ""
    }
  }
}

extension NSColor {
  var suffix: String {
    switch self {
    case .controlAccentBlue: return "~blue"
    case .controlAccentPurple: return "~purple"
    case .controlAccentPink: return "~pink"
    case .controlAccentRed: return "~red"
    case .controlAccentOrange: return "~orange"
    case .controlAccentYellow: return "~yellow"
    case .controlAccentGreen: return "~green"

    case .controlAccentNo: return "~no"
    case .controlAccentHardware: return "~hardware"
    case .controlAccentSilver: return "~silver"
    case .controlAccentSpaceGray: return "~spaceGray"
    case .controlAccentGold: return "~gold"
    case .controlAccentRoseGold: return "~roseGold"
    default: return ""
    }
  }
}

//extension NSApplication {
//  func setControlTint(_ tint: NSControlTint) {
//    let errorInfo = UnsafeMutablePointer<NSDictionary?>.allocate(capacity: 1)
//    let autoreleasingErrorInfo = AutoreleasingUnsafeMutablePointer<NSDictionary?>(errorInfo)
//    let tintName = tint == .graphiteControlTint ? "graphite" : "blue"
//    let scriptSource = "tell app \"System Events\" to tell appearance preferences to set appearance to \(tintName)"
//    let returnValue = NSAppleScript(source: scriptSource)!.executeAndReturnError(autoreleasingErrorInfo)
//    print(errorInfo.pointee as Any)
//    print(returnValue)
//    errorInfo.deallocate()
//  }
//}

#endif
