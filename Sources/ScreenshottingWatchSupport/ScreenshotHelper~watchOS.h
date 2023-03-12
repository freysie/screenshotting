#if __has_include(<UIKit/UIKit.h>)

@import UIKit;

@interface ScreenshotHelper : NSObject

+ (nonnull NSData *)capture:(nonnull id)view;

@end

#endif
