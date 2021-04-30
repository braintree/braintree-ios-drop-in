#import <BraintreeDropIn/BTDropInUICustomization.h>

#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BTPostalAddress.h>
#import <Braintree/BTPayPalRequest.h>
#import <Braintree/BTVenmoRequest.h>
#import <Braintree/BTThreeDSecureRequest.h>
#else
#import <BraintreeCore/BTPostalAddress.h>
#import <BraintreePayPal/BTPayPalRequest.h>
#import <BraintreeVenmo/BTVenmoRequest.h>
#import <BraintreeThreeDSecure/BTThreeDSecureRequest.h>
#endif

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BTFormFieldSetting) {
    BTFormFieldDisabled = 0,
    BTFormFieldOptional,
    BTFormFieldRequired
};

@interface BTDropInRequest : NSObject <NSCopying>

/// Optional: Specify the options for the PayPal flow using either BTPayPalCheckoutRequest or BTPayPalVaultRequest. If not present, a default vault flow will be used.
@property (nonatomic, strong, nullable) BTPayPalRequest *payPalRequest;

/// Optional: Specify the options for the Venmo flow. If not present, a default vault flow will be used.
@property (nonatomic, strong, nullable) BTVenmoRequest *venmoRequest;

/// Optional: Use this parameter to disable Apple Pay. Otherwise if Apple Pay is correctly configured, Apple Pay will appear as a selection in the Payment Method options.
@property (nonatomic, assign) BOOL applePayDisabled;

/// Defaults to false. Set to true to hide the PayPal option even if enabled for your account.
@property (nonatomic, assign) BOOL paypalDisabled;

/// Defaults to false. Set to true to hide the Venmo option even if enabled for your account.
@property (nonatomic, assign) BOOL venmoDisabled;

/// Defaults to false. Set to true to hide the Card option even if enabled for your account.
@property (nonatomic, assign) BOOL cardDisabled;

/// Optional: Enable 3DS verification and specify options and additional information.
///
/// Note: To encourage 3DS 2.0 flows, set `billingAddress`, `amount`, `email`, `mobilePhone` for best results.
@property (nonatomic, strong, nullable) BTThreeDSecureRequest *threeDSecureRequest;

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

/// Optional: Whether or not to vault the card upon tokenization, can only be applied when initializing the Braintree client with a client token that was generated with a customer ID. When set to `false` with `allowVaultCardOverride` set to `false`, then cards will not be vaulted.
/// Defaults to true
@property (nonatomic, assign) BOOL vaultCard;

/// Optional: When true, the card form will include an option to let the customer decide not to vault the card.
/// Defaults to false
@property (nonatomic, assign) BOOL allowVaultCardOverride;

/// Optional: Customization options for Braintree Drop-in's user interface.
@property (nonatomic, strong, nullable) BTDropInUICustomization *uiCustomization;

@end

NS_ASSUME_NONNULL_END
