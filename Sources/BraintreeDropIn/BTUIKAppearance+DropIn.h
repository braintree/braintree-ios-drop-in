#import <BraintreeDropIn/BTDropInUICustomization.h>
#import "BTUIKAppearance.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTUIKAppearance (DropIn)

- (void)configureWithUICustomization:(BTDropInUICustomization *)uiCustomization;

@end

NS_ASSUME_NONNULL_END
