#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BTPostalAddress;

typedef NS_ENUM(NSInteger, BTFormFieldSetting) {
    BTFormFieldDisabled = 0,
    BTFormFieldOptional,
    BTFormFieldRequired
};

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

/// Defaults to false. Set to true to hide the PayPal option even if enabled for your account.
@property (nonatomic, assign) BOOL paypalDisabled;

/// Defaults to false. Set to true to hide the Venmo option even if enabled for your account.
@property (nonatomic, assign) BOOL venmoDisabled;

/// Defaults to false. Set to true to hide the Card option even if enabled for your account.
@property (nonatomic, assign) BOOL cardDisabled;

/// Optional: If true and an amount is set, ThreeDSecure will be used to verify new cards. ThreeDSecure must be enabled in the control panel.
/// Defaults to false.
@property (nonatomic, assign) BOOL threeDSecureVerification;

/// Optional: Determines the visibility and input requirements of the cardholder name field.
///
/// When set to BTFormFieldDisabled, the cardholder name field will not be displayed.
/// When set to BTFormFieldOptional, the cardholder name field will be displayed but not required.
/// When set to BTFormFieldRequired, the cardholder name field will be displayed and required.
///
/// Defaults to BTFormFieldDisabled.
@property (nonatomic, assign) BTFormFieldSetting cardholderNameSetting;

/// Optional: If true the security code will be masked.
/// Defaults to false.
@property (nonatomic, assign) BOOL shouldMaskSecurityCode;

/// Optional: If true, enables the managment UI.
/// Defaults to false.
@property (nonatomic, assign) BOOL vaultManager;

@end

NS_ASSUME_NONNULL_END
