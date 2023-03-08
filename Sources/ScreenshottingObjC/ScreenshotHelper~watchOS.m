#if __has_include(<UIKit/UIKit.h>)

#include "ScreenshotHelper~watchOS.h"
#include "UIGraphicsImageRenderer.h"
#include "UIKit.h"

@implementation ScreenshotHelper

+ (nonnull NSData *)capture:(nonnull UIViewController *)viewController {
  id scene = UIApplication.sharedApplication.connectedScenes.allObjects.firstObject;
  UIWindow *window = [[UIWindow alloc] initWithWindowScene:scene];
  // window.windowLevel = .statusBar
  window.rootViewController = viewController;
  [window makeKeyAndVisible];

  UIView *view = viewController.view;
  //NSLog(@"%@", NSStringFromCGRect(view.bounds));
  // NSLog(@"%@", NSStringFromCGSize(view.intrinsicContentSize));
  // NSLog(@"%@", NSStringFromCGSize(viewController.preferredContentSize));
  // view.bounds = CGRectMake(0, 0, view.intrinsicContentSize.width, view.intrinsicContentSize.height);
  // if (CGRectEqualToRect(view.bounds, CGRectZero)) {
  //   view.bounds = UIScreen.mainScreen.bounds;
  // }
  // NSLog(@"%@", NSStringFromCGRect(view.bounds));
  // [NSThread sleepForTimeInterval:2];
  // NSLog(@"%@", view);
  // NSLog(@"%@", viewController);
  // NSLog(@"%@", NSStringFromCGSize(viewController.view.intrinsicContentSize));
  // UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:view.intrinsicContentSize];
  //NSLog(@"%@", NSStringFromCGSize([viewController sizeThatFitsIn:CGRectInfinite.size]));
  // UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:UIScreen.mainScreen.bounds.size];
  UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:view.bounds.size];
  // NSLog(@"%@", renderer);
  return [renderer PNGDataWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
    // NSLog(@"%@", rendererContext);
    // [view drawViewHierarchyInRect:CGRectMake(0, 0, view.intrinsicContentSize.width, view.intrinsicContentSize.height) afterScreenUpdates:YES];
    // [window drawViewHierarchyInRect:UIScreen.mainScreen.bounds afterScreenUpdates:YES];
    [window drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
  }];
}

@end

#endif
