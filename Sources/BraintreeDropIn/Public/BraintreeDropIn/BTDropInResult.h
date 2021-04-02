#import <UIKit/UIKit.h>
#import <BraintreeDropIn/BTUIKPaymentOptionType.h>

NS_ASSUME_NONNULL_BEGIN

@class BTPaymentMethodNonce;

/**
 Domain for Braintree Drop-in errors.
 */
extern NSString * const BTDropInErrorDomain;

/**
 Error codes associated with Braintree Drop-in.
 */
typedef NS_ENUM(NSInteger, BTDropInErrorType) {
    /// Unknown error
    BTDropInErrorTypeUnknown = 0,

    /// The client token or tokenization key is invalid
    BTDropInErrorTypeAuthorization,
};

@interface BTDropInResult : NSObject

typedef void (^BTDropInResultFetchHandler)(BTDropInResult * _Nullable result, NSError * _Nullable error);

/// True if the modal was dismissed without selecting a payment method
@property (nonatomic, assign, getter=isCanceled) BOOL canceled;

/// The type of the payment option
@property (nonatomic, assign) BTUIKPaymentOptionType paymentOptionType;

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

/// Fetch a `BTDropInResult` with the customer's most recently vaulted payment method.
/// If the last payment method selected from Drop-in was Apple Pay, a `BTDropInResult` with
/// `paymentOptionType == .applePay` will be returned in the completion block.
///
/// @param clientToken Client token. Must be generated with a customer ID.
/// @param handler The handler for callbacks.
+ (void)mostRecentPaymentMethodForClientToken:(NSString *)clientToken handler:(BTDropInResultFetchHandler)handler;

@end

NS_ASSUME_NONNULL_END
