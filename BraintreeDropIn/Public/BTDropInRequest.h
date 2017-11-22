#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BTPostalAddress;

@interface BTDropInRequest : NSObject <NSCopying>

/// Optional: Amount of the transaction.
///
/// Amount must be a non-negative number, may optionally contain exactly 2 decimal places
/// separated by '.', optional thousands separator ',', limited to 7 digits before the decimal point.
///
/// Used by PayPal single payments and ThreeDSecure.
@property (nonatomic, copy, nullable) NSString *amount;

/// Optional: A valid ISO currency code to use for the transaction. Defaults to merchant currency code if not set.
///
/// Used by PayPal.
@property (nonatomic, copy, nullable) NSString *currencyCode;

/// Defaults to false. When set to true, the shipping address selector will not be displayed.
///
/// Used by PayPal.
@property (nonatomic, assign) BOOL noShipping;

/// Optional: A valid shipping address to be displayed in the transaction flow.
/// An error will occur if this address is not valid.
///
/// Used by PayPal.
@property (nonatomic, strong, nullable) BTPostalAddress *shippingAddress;

/// Optional: A set of PayPal scopes to use when requesting payment via PayPal. Used by Drop-in and payment button.
@property (nonatomic, strong, nullable) NSSet<NSString *> *additionalPayPalScopes;

/// Optional: Use this parameter to disable Apple Pay. Otherwise if Apple Pay is correctly configured, Apple Pay will appear as a selection in the Payment Method options.
@property (nonatomic, assign) BOOL applePayDisabled;

/// Optional: Use this parameter to disable PayPal. Otherwise if PayPal is correctly configured, PayPal will appear as a selection in the Payment Method options.
@property (nonatomic, assign) BOOL paypalDisabled;

/// Optional: If true and an amount is set, ThreeDSecure will be used to verify the card. ThreeDSecure must be enabled in the control panel.
/// Defaults to false.
@property (nonatomic, assign) BOOL threeDSecureVerification;

/// Controls if payment methods should be tokenized and stored in the user's Braintree vault. Set to false when doing transactions externally (i.e. in Safari browser - which does the vaulting), otherwise set to true
/// Default to false.
@property (nonatomic, assign) BOOL shouldTokenize;

@end

NS_ASSUME_NONNULL_END
