import SwiftUI

struct WatchContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, world!")
    }
  }
}

class WatchContentView_Previews: PreviewProvider, ScreenshotProvider {
  static var previews: some View {
    WatchContentView()
  }
}
