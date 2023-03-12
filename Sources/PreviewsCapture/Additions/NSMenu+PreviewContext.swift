//#if os(macOS)
//
//import AppKit
//import SwiftUI
//
//extension NSMenu {
//  struct Preview: View {
//    var menu: NSMenu
//    @State var image: CGImage?
//
//    var body: some View {
//      if let image {
//        Image(image, scale: 1, label: Text(""))
//          .fixedSize()
//      } else {
//        ProgressView()
//          .onAppear {
//            func attempt() {
//              Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//                image = menu.cacheDisplay()
//                if image == nil { attempt() }
//              }
//            }
//
//            attempt()
//          }
//      }
//    }
//  }
//
//  public func previewContext() -> some View {
//    Preview(menu: self)
//  }
//}
//
//struct NSMenu_Previews: PreviewProvider {
//  static var previews: some View {
//    NSMenu()
//      .previewContext()
//  }
//}
//
//#endif
