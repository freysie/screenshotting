#if os(watchOS)

struct ScreenshotWriter<Content: View>: View {
  var path: String?
  var name: String?

  @ViewBuilder var content: Content

  var body: some View {
    content
      .onAppear {
        let view = _makeUIHostingView(content)
//        let view = _UIHostingView(rootView: content)
        print(view)

        let intrinsicContentSize = view.value(forKey: "intrinsicContentSize") as? CGSize ?? .zero
        let bounds = CGRect(origin: .zero, size: intrinsicContentSize)

        let renderer = makeUIGraphicsImageRenderer(bounds.size)
        print(renderer)

        let data = makePNGData(using: renderer) { _ in
          print("EXECUTING RENDERER BLOCK")
          view.perform(Selector(("drawViewHierarchyInRect:afterScreenUpdates:")), with: bounds, with: true)
//          view.perform(Selector(("drawViewHierarchyInRect:afterScreenUpdates:")), with: bounds, with: true)
//          view.perform(Selector(("drawViewHierarchyInRect:afterScreenUpdates:")), with: bounds, with: true)
        }
        print(data as Any)

//        let renderer = UIGraphicsImageRenderer(size: bounds.size)
//        NSLog("[Screenshotting] aaaaa \(view) \(renderer) \(bounds)")

//        let image = renderer.image { _ in
//          view.perform(Selector(("drawViewHierarchyInRect:afterScreenUpdates:")), with: bounds, with: true)
//        }

//        NSLog("[Screenshotting] \(image as Any)")

//        let path = outputPath(path, name)
//        createIntermediateFoldersUnlessExists(for: path)
//        writeScreenshot(image.perform(Selector(("pngData"))).takeRetainedValue() as! Data, to: path)
      }
  }
}

let _UIGraphicsImageRenderer = objc_getClass("UIGraphicsImageRenderer") as! NSObject.Type

func makeUIGraphicsImageRenderer(_ size: CGSize) -> AnyObject {
  _UIGraphicsImageRenderer
    .perform(Selector((String(["a", "l", "l", "o", "c"])))).takeRetainedValue()
    .perform(Selector(("initWithSize:")), with: CGSize.zero).takeRetainedValue()
}

func makePNGData(using renderer: AnyObject, actions: @convention(block) @escaping (NSObject?) -> ()) -> Data? {
  renderer.perform(Selector(("PNGDataWithActions:")), with: actions).takeRetainedValue() as? Data
}

#endif
