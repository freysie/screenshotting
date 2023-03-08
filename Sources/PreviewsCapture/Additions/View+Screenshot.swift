//import SwiftUI
//
//public extension View {
//  func screenshot(
//    _ name: String? = nil,
//    basePath: String = #filePath,
//
//    colorScheme: ColorScheme? = nil,
//    scale: CGFloat? = nil,
//
//    timeSuffix: Bool? = nil,
//    platformSuffix: Bool? = nil,
//    colorSchemeSuffix: Bool? = nil,
//    scaleSuffix: Bool? = nil,
//    idiomSuffix: Bool? = nil,
//    deviceSuffix: Bool? = nil
//  ) -> some View {
//    //print(_VariadicView(self)[EEEEEEp.self])/
//    //print(self[EEEEEEp.self])
////    variadic
////    _VariadicView.Tree(self)
//    //return self._trait(EEEEEEp.self, true)
//    return self
//
//    //return self
//
////    //guard ProcessInfo.isXcodeRunningForPreviews else { return self }
//////    NSLog("[Screenshotting] isXcodeRunningForPreviews = \(ProcessInfo.isXcodeRunningForPreviews)")
//////    NSLog("[Screenshotting] self = \(String(describing: self))")
//////    NSLog("[Screenshotting] \(#function)")
////
////    let controller = ScreenshotController()
////    //NSLog("[Screenshotting] \(name ?? "--") \(controller.settings.outputPath) \(self)")
////
////    colorScheme.map { controller.settings.colorSchemes = [$0] }
////    scale.map { controller.settings.scales = [$0] }
////
////    timeSuffix.map { controller.settings.timeSuffix = $0 }
////    platformSuffix.map { controller.settings.platformSuffix = $0 }
////    colorSchemeSuffix.map { controller.settings.colorSchemeSuffix = $0 }
////    scaleSuffix.map { controller.settings.scaleSuffix = $0 }
////    idiomSuffix.map { controller.settings.idiomSuffix = $0 }
////    deviceSuffix.map { controller.settings.deviceSuffix = $0 }
////
//////    return self
////
//////    return overlay {
//////      // WindowReader()
//////      ScreenshotHost { self }
//////    }
////
//////    return task {
//////      await controller.save(AnyView(self), as: name ?? "Untitled", basePathURL: URL(fileURLWithPath: basePath))
//////    }
////    return background { ScreenshotHost { self } }
//
//  }
//}
//
////class WindowReaderView: NSView {
////  override func viewDidMoveTo() {
////    guard superview != nil else { return }
////    NSLog("[Screenshotting] \(#function) \(String(describing: window))")
////  }
////}
////
////struct WindowReader: NSViewRepresentable {
////  func makeNSView(context: Context) -> WindowReaderView { WindowReaderView() }
////  func updateNSView(_ view: WindowReaderView, context: Context) {}
////}
//
//class ScreenshotHostingController<Content: View>: NSHostingController<Content> {
//  override func viewWillAppear() {
//    super.viewWillAppear()
//    NSLog("[Screenshotting] \(#function)")
//  }
//
//  override func viewWillTransition(to newSize: NSSize) {
//    super.viewWillTransition(to: newSize)
//    NSLog("[Screenshotting] \(#function)")
//  }
//
//  override func viewDidAppear() {
//    super.viewDidAppear()
//    NSLog("[Screenshotting] \(#function)")
//  }
//
//  override func viewWillLayout() {
//    super.viewWillLayout()
//    NSLog("[Screenshotting] \(#function)")
//  }
//
//  override func viewDidLayout() {
//    super.viewDidLayout()
//    guard view.window != nil else { return }
//    NSLog("[Screenshotting] \(#function) \(view) \(view.window!) \(ProcessInfo.isXcodeRunningForPreviews)")
//
////    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self] _ in
//      if let data = ScreenshotController.shared.capture(view) {
//        let path = "/tmp/eeeep.png"
//        ScreenshotController.shared.save(data, toPath: path)
//      }
////    }
//  }
//}
//
//struct ScreenshotHost<Content: View>: NSViewControllerRepresentable {
//  @ViewBuilder var content: Content
//
//  func makeNSViewController(context: Context) -> ScreenshotHostingController<Content> { .init(rootView: content) }
//  func updateNSViewController(_ viewController: ScreenshotHostingController<Content>, context: Context) {}
//}
