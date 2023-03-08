/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that displays a badge.
*/

import SwiftUI
import Screenshotting

struct Badge: View {
    var badgeSymbols: some View {
        ForEach(0..<8) { index in
            RotatedBadgeSymbol(
                angle: .degrees(Double(index) / Double(8)) * 360.0
            )
        }
        .opacity(0.5)
    }

    var body: some View {
        ZStack {
            BadgeBackground()

            GeometryReader { geometry in
                badgeSymbols
                    .scaleEffect(1.0 / 4.0, anchor: .top)
                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
            }
        }
        .scaledToFit()
    }
}

class Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
            .frame(width: 240, height: 240)
            //.background()
            .padding()
            .previewLayout(.sizeThatFits)
            .screenshot("Badge", colorScheme: .dark, scale: 2)
    }
}