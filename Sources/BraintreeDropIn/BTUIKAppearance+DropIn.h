#import <BraintreeDropIn/BTDropInUICustomization.h>

#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKAppearance.h>
#else
#import <BraintreeUIKit/BTUIKAppearance.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BTUIKAppearance (DropIn)

- (void)configureWithUICustomization:(BTDropInUICustomization *)uiCustomization;

@end

NS_ASSUME_NONNULL_END
