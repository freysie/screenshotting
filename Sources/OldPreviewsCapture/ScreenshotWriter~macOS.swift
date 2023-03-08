#if os(macOS)

import AppKit
import SwiftUI

struct ScreenshotWriter<Content: View>: NSViewControllerRepresentable {
  var path: String?
  var name: String?

  @ViewBuilder var content: Content
  
  func makeNSViewController(context: Context) -> ScreenshotHostingController<Content> {
    ScreenshotHostingController(rootView: content)
  }
  
  func updateNSViewController(_ viewController: ScreenshotHostingController<Content>, context: Context) {
    viewController.path = path
    viewController.name = name
  }
}

fileprivate extension NSView {
  var subtreeDescription: String {
    perform(Selector(("_subtreeDescription"))).takeUnretainedValue() as! String
  }
}

class ScreenshotHostingController<Content: View>: NSHostingController<Content> {
  var path: String?
  var name: String?
  
  override func viewWillAppear() {
    super.viewWillAppear()
    // NSLog("[Screenshotting] \(#function)")
  }
  
  override func viewWillTransition(to newSize: NSSize) {
    super.viewWillTransition(to: newSize)
    // NSLog("[Screenshotting] \(#function)")
  }
  
  override func viewDidAppear() {
    super.viewDidAppear()
    // NSLog("[Screenshotting] \(#function)")
  }
  
  override func viewWillLayout() {
    super.viewWillLayout()
    // NSLog("[Screenshotting] \(#function)")
  }
  
  override func viewDidLayout() {
    super.viewDidLayout()
    guard view.window != nil else { return }
    // NSLog("[Screenshotting] \(#function)")
    capture()
    
    // print(view.subtreeDescription)
    
//    func findMenu(in view: NSView) -> NSMenu? {
//      if let menu = view.menu {
//        return menu
//      }
//
//      for subview in view.subviews {
//        if let menu = findMenu(in: subview) {
//          return menu
//        }
//      }
//
//      return nil
//    }
//
//    print(findMenu(in: view) as Any)
  }
  
  func capture() {
//    DispatchQueue.main.async { [self] in
//      DispatchQueue.main.async { [self] in
        captureScreenshot(view, name, path)
//      }
//    }
  }
}

func captureScreenshot(_ view: NSView, _ name: String?, _ path: String?) {
  let path = outputPath(
    path,
    name,
    view.effectiveAppearance.fileSuffix,
    scale: view.window?.screen?.backingScaleFactor
  )
  
  //    let window = NSWindow()
  //    window.contentView = view
  
  // view.viewDidChangeEffectiveAppearance()
  let imageRep = view.bitmapImageRepForCachingDisplay(in: view.bounds)
  guard let imageRep = imageRep else {
    print("[PreviewCapture] bitmapImageRepForCachingDisplay() failed for \(view)")
    return
  }
  
  //    DispatchQueue.main.async { [self] in
  // view.viewDidChangeEffectiveAppearance()
  view.cacheDisplay(in: view.bounds, to: imageRep)
  
  guard let data = imageRep.representation(using: .png, properties: [:]) else {
    print("[PreviewCapture] representation() failed")
    return
  }
  
  createIntermediateFoldersUnlessExists(for: path)
  writeScreenshot(data, to: path)
  
  NotificationCenter.default.post(name: .ScreenshottingDidSaveScreenshot, object: view.window)
  
  // window.close()
  //    }
}

#endif
