#if os(macOS)

import AppKit

extension NSMenu {
  class WindowGetter: NSView {
    var action: ((NSWindow) -> ())!

    convenience init(action: @escaping (NSWindow) -> ()) {
      self.init(frame: NSRect(x: 0, y: 0, width: 1, height: 1))
      self.action = action
    }

    override func viewDidMoveToWindow() {
      if let window, let enclosingMenuItem {
        enclosingMenuItem.menu?.removeItem(enclosingMenuItem)
        action(window)
      }
    }
  }

  public func cacheDisplay() -> Data? {
    let includeShadow = true
    var result: CGImage?

    let menuItem = NSMenuItem()
    menuItem.view = WindowGetter { window in
      self.items.first.map(self.highlight)
      DispatchQueue.main.async {
        DispatchQueue.main.async {
          let windowID = CGWindowID(window.windowNumber)
          print(windowID)
          let options = includeShadow ? [] : CGWindowImageOption.boundsIgnoreFraming
          result = CGWindowListCreateImage(.null, [.optionIncludingWindow], windowID, options)
          print("yas")
          DispatchQueue.main.async {
            DispatchQueue.main.async {
              self.cancelTrackingWithoutAnimation()
            }
          }
        }
      }
    }

    addItem(menuItem)
    popUp(positioning: nil, at: .zero, in: nil)

    guard let result, let data = NSBitmapImageRep(cgImage: result).representation(using: .png, properties: [:]) else {
      return nil
    }

    return data
  }
}

#endif
