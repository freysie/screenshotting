import SwiftUI
import Screenshotting

struct ContentView: View {
  var body: some View {
    VStack(spacing: 5) {
      Image(systemName: "camera")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      
      Text("Say cheese, world!")
    }
  }
}

@available(macOS 13.0, *)
class ContentView_Previews: PreviewProvider {
  static var previews: some View {
//    ContentView()
//        .background()
//        .previewLayout(.sizeThatFits)
//        .screenshot("Content")

    ContentView()
        .padding(60)
        .background()
        .previewLayout(.sizeThatFits)
        .screenshot("Content")
  }
}
