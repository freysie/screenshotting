import SwiftUI

// TODO: finish these

/// Settings for screenshotting.
public class ScreenshotSettings {
  /// Default screenshotting settings.
  public static let `default` = ScreenshotSettings()

  /// The path to which screenshots are saved.
  //public var outputPath = "../Screenshots"
  public var outputPath = "/tmp"

  /// Color scheme variants to capture.
  public var colorSchemes = ColorScheme.allCases

  /// Scale variants to capture.
  public var scales = [CGFloat]()
  //public var scales = [2.0]

  // /// Tint color variants to capture.
  // public var tintColors = [Color]()

  // /// Whether to capture high contrast variants.
  // public var highContrast = false

  /// Delay in seconds before capturing after displaying view.
  public var delay: TimeInterval? = 0.5

  /// Whether to display windows while capturing.
  public var showsWindows = true

  /// Whether to keep windows open after capturing.
  public var keepsWindowsOpen = true

  /// Whether to terminate the capture app after all screenshots have been saved.
  public var terminatesWhenFinished = true

  // /// Whether to reveal the captured screenshot files in Finder after saving.
  // public var revealsFilesInFinderWhenFinished = true

  /// Whether to include the time in filenames.
  public var timeSuffix = false

  /// Whether to include the platform in filenames.
  public var platformSuffix = true

  /// Whether to include the color scheme in filenames.
  public var colorSchemeSuffix = true

  /// Whether to include the scale in filenames.
  public var scaleSuffix = true

  /// Whether to include the UI idiom in filenames.
  public var idiomSuffix = false

  /// Whether to include the device name in filenames.
  public var deviceSuffix = false

  /// Whether to strip “_0” from the names of screenshots if they are the only preview in a provider.
  /// Changing this should only be relevant if you want to name your screenshot “0”.
  public var omitsZeroIfOnlyPreview = true

  /// Whether to replace whitespace with underscoes in filenames.
  public var replacesWhitespaceWithUnderscores = true

  // /// Explicit list of preview providers to take screenshots of.
  // /// When this is nil, providers tagged with the ``ScreenshotProvider`` interface are used.
  // public var previewProviders: [any PreviewProvider.Type]?
}
