#import <UIKit/UIKit.h>

#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BTPaymentMethodNonce.h>
#else
#import <BraintreeCore/BTPaymentMethodNonce.h>
#endif

@class BTUIKPaymentOptionCardView;

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTUIPaymentMethodCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) BTUIKPaymentOptionCardView* paymentOptionCardView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* descriptionLabel;
@property (nonatomic, strong) BTPaymentMethodNonce* paymentMethodNonce;

+ (CGSize)dynamicSize;

@end
