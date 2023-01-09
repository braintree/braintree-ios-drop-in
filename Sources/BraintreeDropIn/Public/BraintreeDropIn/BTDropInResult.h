#import <UIKit/UIKit.h>
#import <BraintreeDropIn/BTDropInPaymentMethodType.h>

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
    
    /// No recent payment methods were found
    BTDropInErrorTypeNoRecentPaymentMethods
};

@interface BTDropInResult : NSObject

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

/**
 * A `deviceData` string that represents data about a customer's device. This is generated from Braintree's advanced fraud protection service.
 *
 * `deviceData` should be passed into server-side calls, such as `Transaction.sale`. This enables you to collect data about a customer's device and correlate it with a session identifier on your server.
 *
 * Collecting and passing this data with transactions helps reduce decline rates and detect fraudulent transactions.
 */
@property (nonatomic, strong, nullable) NSString *deviceData;

/**
 * Fetch a `BTDropInResult` with the customer's vaulted payment method.
 * The payment method returned is not guaranteed to be the most recently added payment method.
 * If the vaulted payment method is Apple Pay, a `BTDropInResult` with
 * `paymentMethodType == .applePay` will be returned in the completion block.
 *
 * @param clientToken Client token. Must be generated with a customer ID.
 * @param completion The completion block, which passes back a result or an error. Both result and error may be nil if the customer does not have any vaulted payment methods.
 */
 // NEXT_MAJOR_VERSION: - update this function name to more accurately represent the behavior of the function
+ (void)mostRecentPaymentMethodForClientToken:(NSString *)clientToken
                                   completion:(void (^)(BTDropInResult * _Nullable result, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
