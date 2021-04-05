#import <UIKit/UIKit.h>
#import <BraintreeDropIn/BTDropInPaymentMethodType.h>

NS_ASSUME_NONNULL_BEGIN

@class BTPaymentMethodNonce;

@interface BTDropInResult : NSObject

typedef void (^BTDropInResultFetchHandler)(BTDropInResult * _Nullable result, NSError * _Nullable error);

/// True if the modal was dismissed without selecting a payment method
@property (nonatomic, assign, getter=isCanceled) BOOL canceled;

/// The type of the payment option
@property (nonatomic, assign) BTDropInPaymentMethodType paymentMethodType;

/// A UIView (BTUIKPaymentOptionCardView) that represents the payment option
@property (nonatomic, readonly) UIView *paymentIcon;

/**
 * A description of the payment option.
 * For cards, the last four digits of the card number.
 * For PayPal, the email address associated with the account.
 * For Venmo, the username associated with the account.
 * For Apple Pay, the text "Apple Pay".
 */
@property (nonatomic, readonly) NSString *paymentDescription;

/// The payment method nonce
@property (nonatomic, strong, nullable) BTPaymentMethodNonce *paymentMethod;

/// Fetch a BTDropInResult without displaying or initializing a BTDropInController. Works with client tokens that
/// were created with a `customer_id`.
///
/// @param authorization Your tokenization key or client token.
/// @param handler The handler for callbacks.
+ (void)fetchDropInResultForAuthorization:(NSString *)authorization handler:(BTDropInResultFetchHandler)handler;

@end

NS_ASSUME_NONNULL_END
