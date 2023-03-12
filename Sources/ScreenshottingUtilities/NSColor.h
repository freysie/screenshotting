#if __has_include(<AppKit/AppKit.h>)

@import AppKit;

NS_ASSUME_NONNULL_BEGIN

@interface NSColor ()

@property (class, strong, readonly) NSColor *controlAccentBlueColor;
@property (class, strong, readonly) NSColor *controlAccentPurpleColor;
@property (class, strong, readonly) NSColor *controlAccentPinkColor;
@property (class, strong, readonly) NSColor *controlAccentRedColor;
@property (class, strong, readonly) NSColor *controlAccentOrangeColor;
@property (class, strong, readonly) NSColor *controlAccentYellowColor;
@property (class, strong, readonly) NSColor *controlAccentGreenColor;

@property (class, strong, readonly) NSColor *controlAccentNoColor;
@property (class, strong, readonly) NSColor *controlAccentHardwareColor;

@property (class, strong, readonly) NSColor *controlAccentSilverColor;
@property (class, strong, readonly) NSColor *controlAccentSpaceGrayColor;
@property (class, strong, readonly) NSColor *controlAccentGoldColor;
@property (class, strong, readonly) NSColor *controlAccentRoseGoldColor;

@end

typedef NS_ENUM(NSInteger, NSUserAccentColor) {
  NSUserAccentColorRed = 0,
  NSUserAccentColorOrange = 1,
  NSUserAccentColorYellow = 2,
  NSUserAccentColorGreen = 3,
  NSUserAccentColorBlue = 4,
  NSUserAccentColorPurple = 5,
  NSUserAccentColorPink = 6,
  NSUserAccentColorGraphite = -1,
  NSUserAccentColorMulticolor = -2,
};

NSUserAccentColor NSColorGetUserAccentColor();
void NSColorSetUserAccentColor(NSUserAccentColor);
void NSColorEnumerateUserAccentColors(void (^)(NSUserAccentColor));
NSColor *NSColorBaseDisplayColorForUserAccentKey(NSUserAccentColor);
NSString *NSColorLocalizedNameForUserAccentKey(NSUserAccentColor);

//void NSUseDebugAppearance();
//void _NSShowDebugMenu();
//void _NSUserAccentColorInvalidateForCurrentProcess();
//NSString *_NSAppearanceTintColorNameFromUserAccentColor(int color);
//NSString *_NSAppearanceTintColorNameFromUserAccentColor(NSColor *color);
//NSString *_NSAppearanceBezelTintNameForAccentColorName(NSString *name);

NS_ASSUME_NONNULL_END

#endif
