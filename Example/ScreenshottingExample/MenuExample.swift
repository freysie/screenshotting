import SwiftUI
import Screenshotting

fileprivate let menu = {
  let menu = NSMenu()
  menu.autoenablesItems = false
  //    let item = menu.addItem(withTitle: "Hello, NSMenu!", action: nil, keyEquivalent: "")
  //    item.view = NSView()
  let item = menu.addItem(withTitle: "Hello, NSMenu!", action: nil, keyEquivalent: "")
  // NSAttributedString(markdownString: "**Hello,** `NSMenu`!", options: nil, baseURL: nil)
  // item.attributedTitle = try? NSAttributedString(__markdownString: "**Hello,** `NSMenu`!", options: nil, baseURL: nil)
  // item.attributedTitle = NSAttributedString(string: "dddd", attributes: [.foregroundColor: NSColor.red])
  // print(item.attributedTitle)

  //item.submenu = NSMenu()
  //item.submenu!.addItem(withTitle: "Hello, NSMenuItem!", action: nil, keyEquivalent: "")

  // item.image = NSImage(named: "NSComputer")!
  item.image = NSImage(systemSymbolName: "swift", accessibilityDescription: nil)

  menu.addItem(.separator())

  menu.addItem(withTitle: "Hello, NSMenuItem!", action: nil, keyEquivalent: "")
    .image = NSImage(systemSymbolName: "filemenu.and.selection", accessibilityDescription: nil)
  menu.addItem(withTitle: "Hello, Screenshotting!", action: nil, keyEquivalent: "")
    .image = NSImage(systemSymbolName: "camera", accessibilityDescription: nil)
  menu.addItem(withTitle: "Hello, NSMenu Previews!", action: nil, keyEquivalent: "")
    .image = NSImage(systemSymbolName: "filemenu.and.cursorarrow", accessibilityDescription: nil)
  
  return menu
}()

//        .onAppear {
//          Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
//            menu.cacheDisplay()
//          }
//        }

//      Button(action: { menu.cacheDisplay() }) {
//        Text("aaaaa")
//      }

      //menu.previewContext()
