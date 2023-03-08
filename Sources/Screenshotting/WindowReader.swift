#if canImport(AppKit)

import SwiftUI

struct WindowReader: NSViewRepresentable {
  let handler: (NSWindow) -> ()
  func makeNSView(context: Context) -> WindowReaderView { WindowReaderView() }
  func updateNSView(_ view: WindowReaderView, context: Context) { view.handler = handler }
}

//let c = WindowReaderViewController()
struct _WindowReader: NSViewControllerRepresentable {
  let handler: (NSWindow) -> ()
  func makeNSViewController(context: Context) -> WindowReaderViewController { WindowReaderViewController() }
  func updateNSViewController(_ view: WindowReaderViewController, context: Context) { view.handler = handler }
}

class WindowReaderView: NSView {
  var handler: ((NSWindow) -> ())!
  var hasCalledHandler = false

  override func viewDidMoveToWindow() {
    //print(#function)
    super.viewDidMoveToWindow()

    if let window, !hasCalledHandler {
      //NSLog("[Screenshotting] \(#function) \(window) \(NSApp.windows)")

      DispatchQueue.main.async {
        self.handler(window)
      }

      hasCalledHandler = true
    }
  }

  override func layout() {
    //print(#function)
    super.layout()
  }

  override func layoutSubtreeIfNeeded() {
    //print(#function)
    super.layoutSubtreeIfNeeded()
  }
}

class WindowReaderViewController: NSViewController {
  var handler: ((NSWindow) -> ())!
  var hasCalledHandler = false

  convenience init() {
    self.init(nibName: nil, bundle: nil)
    view = NSView()
    //NSLog("[Screenshotting] \(#function) \(NSApp.windows)")
  }

  override func viewDidLayout() {
    super.viewDidLayout()

    if let window = view.window, !hasCalledHandler {
      //NSLog("[Screenshotting] \(#function) \(window.contentView!) \(window)")

      DispatchQueue.main.async {
        self.handler(window)
      }

      hasCalledHandler = true
    }
  }
}

#endif
