import SwiftUI
import Screenshotting
import ScreenshottingRNG

struct RandomView: View {
  static var colors: [Color] = [.brown, .indigo, .mint, .pink]
  @State var randomSource = GKLinearCongruentialRandomSource(seed: 0)

  var body: some View {
    VStack {
      ForEach(Self.colors.shuffled(using: &randomSource), id: \.self) { color in
        RoundedRectangle(cornerRadius: 3)
          .size(width: 64, height: 64)
          .fill(color)
      }
    }
  }
}

class RandomView_Previews: PreviewProvider {
  static var previews: some View {
    RandomView()
      .previewLayout(.sizeThatFits)
      //.background()
      // .previewScreenshot("ContentView")
  }
}
