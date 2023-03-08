#if __has_include(<AppKit/AppKit.h>)

@import AppKit;

@interface NSAppearance ()

- (nullable NSAppearance *)appearanceByApplyingTintColor:(nullable NSColor *)color;

@end

#endif
