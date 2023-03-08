import SwiftUI
import Screenshotting


//struct Foo: PreviewContext {
//  subscript<Key>(key: Key.Type) -> Key.Value where Key : PreviewContextKey {
//
//  }
//}

class DirectCaptureExample_Previews: PreviewProvider, ScreenshotProvider {
  static var previews: some View {
    FormExample()
      .padding(5)
      .background()
      .previewDisplayName("Hurrr")
//      .previewContext(Foo())
      .previewLayout(.sizeThatFits)
//      .screenshot("Form", colorScheme: .dark, timeSuffix: true, platformSuffix: false)//, colorScheme: .dark, scale: 2, timeSuffix: true)

    ContentView()
      .padding()
      .background()
      .previewLayout(.sizeThatFits)
//      .screenshot("Content", colorScheme: .light, scale: 1, timeSuffix: true)
  }
}
