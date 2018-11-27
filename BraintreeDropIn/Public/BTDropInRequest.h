#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BTPostalAddress, BTPayPalRequest;

typedef NS_ENUM(NSInteger, BTFormFieldSetting) {
    BTFormFieldDisabled = 0,
    BTFormFieldOptional,
    BTFormFieldRequired
};

@interface BTDropInRequest : NSObject <NSCopying>

/// Optional: Amount of the transaction for ThreeDSecure flows.
///
/// Amount must be a non-negative number, may optionally contain exactly 2 decimal places
/// separated by '.', optional thousands separator ',', limited to 7 digits before the decimal point.
///
/// Note: You must still set the amount on the `payPalRequest` for PayPal checkout flows.
@property (nonatomic, copy, nullable) NSString *amount;

/// Optional: Specify the options for the PayPal flow. If not present, a default vault flow will be used.
///
/// Note: The checkout flow is used when an amount is set on the `payPalRequest`.
@property (nonatomic, strong, nullable) BTPayPalRequest *payPalRequest;

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
