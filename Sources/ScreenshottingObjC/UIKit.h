#if !__has_include(<UIKit/UIView.h>)

NS_HEADER_AUDIT_BEGIN(nullability, sendability)

@interface UIScreen : NSObject
@property(class, nonatomic, readonly) UIScreen *mainScreen;
@property(nonatomic, readonly) CGRect bounds;
@property(nonatomic, readonly) CGFloat scale;
@end

@interface UIScene : NSObject
@end

@interface UIWindowScene : UIScene
//@property (nonatomic, readonly) UIScreen *screen;
@end

@interface UIApplication : NSObject
@property(class, nonatomic, readonly) UIApplication *sharedApplication;
@property(nonatomic, readonly) NSSet<UIScene *> *connectedScenes;
@end

@interface UIView : NSObject
@property(nonatomic) CGRect frame;
@property(nonatomic) CGRect bounds;
@property(nonatomic, readonly) CGSize intrinsicContentSize;
- (BOOL)drawViewHierarchyInRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates;
@end

@interface UIViewController : NSObject
@property(null_resettable, nonatomic, strong) UIView *view;
@property(nonatomic, readonly) CGSize preferredContentSize;
@end

//@interface _UIHostingController : UIViewController
//@end

typedef CGFloat UIWindowLevel;

@interface UIWindow : UIView
- (instancetype)initWithWindowScene:(UIWindowScene *)windowScene;
@property(nonatomic) UIWindowLevel windowLevel;
- (void)makeKeyAndVisible;
@property(nullable, nonatomic, strong) UIViewController *rootViewController;
@end

NS_HEADER_AUDIT_END(nullability, sendability)

#endif
