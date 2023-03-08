import SwiftUI
import Screenshotting
import MapKit

struct CircleImage: View {
  var body: some View {
    Image("turtlerock")
      .clipShape(Circle())
      .overlay {
        Circle().stroke(.white, lineWidth: 4)
      }
      .shadow(radius: 7)
  }
}

struct MapView: View {
  @State private var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
    span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
  )

  var body: some View {
    Map(coordinateRegion: $region)
  }
}

struct TurtleRock: View {
  var body: some View {
    VStack {
      MapView()
        .ignoresSafeArea(edges: .top)
        .frame(height: 300)

      CircleImage()
        .offset(y: -130)
        .padding(.bottom, -130)

      VStack(alignment: .leading) {
        Text("Turtle Rock")
          .font(.title)

        HStack {
          Text("Joshua Tree National Park")
            .font(.subheadline)
          Spacer()
          Text("California")
            .font(.subheadline)
        }

        Divider()

        Text("About Turtle Rock")
          .font(.title2)
        Text("Descriptive text goes here.")
      }
      .padding()

      Spacer()
    }
  }
}

class TurtleRock_Previews: PreviewProvider { //, ScreenshotProvider {
  static var previews: some View {
    TurtleRock()
      .padding()
      .background()
      .previewLayout(.sizeThatFits)
      .screenshot("TurtleRock", colorScheme: .dark, scale: 2)
  }
}
