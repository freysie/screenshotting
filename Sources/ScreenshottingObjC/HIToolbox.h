#if __has_include(<Carbon/Carbon.h>)

#include <Carbon/Carbon.h>

NS_ASSUME_NONNULL_BEGIN

extern OSStatus HIMenuGetContentView(MenuRef inMenu, ThemeMenuType inMenuType, HIViewRef _Nullable * _Nonnull outView);
extern OSStatus HIViewSetDrawingEnabled(HIViewRef inView, Boolean inEnabled);
extern OSStatus HIViewSetNeedsDisplay(HIViewRef inView, Boolean inNeedsDisplay);
extern OSStatus HIViewCreateOffscreenImage(HIViewRef inView, OptionBits inOptions, HIRect * _Nullable outFrame, _Null_unspecified CGImageRef * _Null_unspecified outImage);
extern OSStatus HIViewDrawCGImage(CGContextRef inContext, const HIRect * inBounds, CGImageRef inImage);

extern MenuID
GetMenuID(MenuRef menu)                                       AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;

typedef SInt16                          MenuID;
typedef UInt16                          MenuItemIndex;
typedef OSType                          MenuCommand;
typedef struct OpaqueMenuRef*           MenuRef;
/* MenuHandle is old name for MenuRef*/
typedef MenuRef                         MenuHandle;

extern UInt16
CountMenuItems(MenuRef theMenu)                               AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;

extern void
CalcMenuSize(MenuRef theMenu)                                 AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;

extern SInt16
GetMenuWidth(MenuRef menu)                                    AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;

extern SInt16
GetMenuHeight(MenuRef menu)                                   AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER;

extern _Nullable WindowRef
HIViewGetWindow(HIViewRef inView)                             AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER;

extern SInt32
HIViewGetValue(HIViewRef inView)                              AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER;

extern OSStatus
HIViewGetFrame(
  HIViewRef   inView,
  HIRect *    outRect)                                        AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER;

NS_ASSUME_NONNULL_END

#endif
