#if __has_include(<AppKit/AppKit.h>)

@import AppKit;

@interface NSWindow ()

- (nullable NSWindow *)initWithWindowRef:(nonnull WindowRef)windowRef;

@end

#endif
