#import "BTDropInBaseViewController.h"

#import "BTUIKCardNumberFormField.h"
#import "BTUIKCardholderNameFormField.h"
#import "BTUIKExpiryFormField.h"
#import "BTUIKSecurityCodeFormField.h"
#import "BTUIKPostalCodeFormField.h"
#import "BTUIKMobileCountryCodeFormField.h"
#import "BTUIKMobileNumberFormField.h"

NS_ASSUME_NONNULL_BEGIN

@class BTCardRequest, BTCardCapabilities, BTPaymentMethodNonce;
@protocol BTCardFormViewControllerDelegate, BTDropInControllerDelegate;

/// Contains form elements for entering card information.
@interface BTCardFormViewController : BTDropInBaseViewController <UITextFieldDelegate, BTUIKFormFieldDelegate, BTUIKCardNumberFormFieldDelegate>

@property (nonatomic, weak) id<BTCardFormViewControllerDelegate, BTDropInControllerDelegate> delegate;

/// The card number form field.
@property (nonatomic, strong, readonly) BTUIKCardNumberFormField *cardNumberField;

/// The cardholder name form field
@property (nonatomic, strong, readonly) BTUIKCardholderNameFormField *cardholderNameField;

/// The expiration date form field.
@property (nonatomic, strong, readonly) BTUIKExpiryFormField *expirationDateField;

/// The security code (ccv) form field.
@property (nonatomic, strong, readonly) BTUIKSecurityCodeFormField *securityCodeField;

/// The postal code form field.
@property (nonatomic, strong, readonly) BTUIKPostalCodeFormField *postalCodeField;

/// The mobile country code form field.
@property (nonatomic, strong, readonly) BTUIKMobileCountryCodeFormField *mobileCountryCodeField;

/// The mobile phone number field.
@property (nonatomic, strong, readonly) BTUIKMobileNumberFormField *mobilePhoneField;

/// If the form is valid, returns a BTCardRequest using the values of the form fields. Otherwise `nil`.
@property (nonatomic, strong, nullable, readonly) BTCardRequest *cardRequest;

/// The BTCardCapabilities used to update the form after checking the card number. Applicable when UnionPay is enabled.
@property (nonatomic, strong, nullable, readonly) BTCardCapabilities *cardCapabilities;

/// The card network types supported by this merchant
@property (nonatomic, copy) NSArray<NSNumber *> *supportedCardTypes;

/// Resets the state of the form fields
- (void)resetForm;

@end

@protocol BTCardFormViewControllerDelegate <NSObject>

- (void)cardTokenizationCompleted:(BTPaymentMethodNonce * _Nullable )tokenizedCard error:(NSError * _Nullable )error sender:(BTCardFormViewController *) sender;

@end


NS_ASSUME_NONNULL_END
