#import <UIKit/UIKit.h>

#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKPaymentOptionType.h>
#else
#import <BraintreeUIKit/BTUIKPaymentOptionType.h>
#endif

/// @class A UILabel that contains images representing multiple BTUIKPaymentOptionType's
@interface BTUIKCardListLabel : UILabel

/// The array of BTUIKPaymentOptionType's to display
@property (nonatomic, copy) NSArray *availablePaymentOptions;

/// The BTUIKPaymentOptionType to emphasize by fading all other payment methods included in availablePaymentOptions
- (void)emphasizePaymentOption:(BTUIKPaymentOptionType)paymentOption;

@end
