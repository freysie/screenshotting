#if __has_include(<AppKit/AppKit.h>)

@import AppKit;
@import Carbon;
@import CoreGraphics;

MenuRef _NSGetCarbonMenu(NSMenu *);
MenuRef _NSGetCarbonMenu2(NSMenu *);

@protocol NSMenuImpl <NSObject>
- (MenuRef *)_principalMenuRef;
@end

@interface NSCarbonMenuImpl : NSObject <NSMenuImpl>
- (id)_menuRefStatus;
- (BOOL)_menuRefIsCheckedOutWithToken:(id)token;
- (void)_returnMenuRefWithToken:(id)token;
- (MenuRef)_checkoutMenuRefWithToken:(id)token creating:(BOOL)creating populating:(BOOL)populating;
- (BOOL)_menuRefIsCheckedOut;
- (MenuRef)_initialMenuRefCreateIfNecessary;
- (MenuRef)_initialMenuRef;
- (MenuRef)_principalMenuRefCreateIfNecessary;
- (MenuRef)_principalMenuRef;
- (void)_instantiateCarbonMenu;
- (BOOL)_carbonMenuHasBeenInstantiatedAndPopulated;
- (void)_setSupermenuHasMenuRef:(BOOL)flag;
- (void)_destroyMenuRefIfNotCheckedOut;
- (void)_destroyMenuRef;
- (MenuRef)_createMenuRef;
- (unsigned int)_menuRefAttributes;
@end

@interface NSMenu ()
- (id <NSMenuImpl>)_contextMenuImpl;
- (id <NSMenuImpl>)_menuImplIfExists;
- (id <NSMenuImpl>)_menuImpl;
- (id <NSMenuImpl>)_createMenuImpl;
@end

typedef OSStatus (^CarbonEventHandler)(NSMenu *menu, EventHandlerCallRef handler, EventRef event);

@interface NSMenu ()
- (void)highlightItem:(NSMenuItem *)item;
- (id)_handleCarbonEvents:(const struct EventTypeSpec *)events count:(unsigned long long)count handler:(CarbonEventHandler)handler;
@end

#endif
