#import <Foundation/Foundation.h>

#define BTUIKLocalizedString(KEY) [BTUIKLocalizedString KEY]

@interface BTUIKLocalizedString : NSObject

#pragma mark Forms and Helpers

+ (NSString *)NEXT_ACTION;
+ (NSString *)EXPIRATION_DATE_LABEL;
+ (NSString *)YEAR_LABEL;
+ (NSString *)MONTH_LABEL;
+ (NSString *)MOBILE_COUNTRY_CODE_LABEL;
+ (NSString *)MOBILE_NUMBER_LABEL;
+ (NSString *)SECURITY_CODE_LABEL;
+ (NSString *)CARD_TYPE_GENERIC_CARD;
+ (NSString *)INVALID_LABEL;
+ (NSString *)CONFIRM_ENROLLMENT_LABEL;
+ (NSString *)CONFIRM_ACTION;
+ (NSString *)ENTER_SMS_CODE_SENT_HELP_LABEL;
+ (NSString *)SMS_CODE_LABEL;
+ (NSString *)USE_DIFFERENT_PHONE_NUMBER_ACTION;
+ (NSString *)INVALID_SMS_CODE_LABEL;
+ (NSString *)CANCEL_ACTION;
+ (NSString *)SELECT_PAYMENT_LABEL;
+ (NSString *)RECENT_LABEL;
+ (NSString *)OTHER_LABEL;
+ (NSString *)CREDIT_OR_DEBIT_CARD_LABEL;
+ (NSString *)CARD_DETAILS_LABEL;
+ (NSString *)ENTER_CARD_DETAILS_HELP_LABEL;
+ (NSString *)ENROLLMENT_REQUIRED_HELP_LABEL;
+ (NSString *)ENROLLMENT_VIA_SMS_HELP_LABEL;
+ (NSString *)ADD_CARD_ACTION;
+ (NSString *)VALID_CARD_ERROR_LABEL;
+ (NSString *)CARD_NOT_ACCEPTED_ERROR_LABEL;
+ (NSString *)CARD_NUMBER_PLACEHOLDER;
+ (NSString *)CVV_FIELD_PLACEHOLDER;
+ (NSString *)EXPIRY_PLACEHOLDER_FOUR_DIGIT_YEAR;
+ (NSString *)EXPIRY_PLACEHOLDER_TWO_DIGIT_YEAR;
+ (NSString *)POSTAL_CODE_PLACEHOLDER;
+ (NSString *)TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT;
+ (NSString *)PHONE_NUMBER_PLACEHOLDER;

#pragma mark Card Brands and Payment Methods

/// PayPal payment method name
+ (NSString *)PAYPAL_CARD_BRAND;
/// American Express card brand
+ (NSString *)CARD_TYPE_AMERICAN_EXPRESS;
/// Discover card brand
+ (NSString *)CARD_TYPE_DISCOVER;
/// Diners Club card brand
+ (NSString *)CARD_TYPE_DINERS_CLUB;
/// MasterCard card brand
+ (NSString *)CARD_TYPE_MASTER_CARD;
/// Visa card brand
+ (NSString *)CARD_TYPE_VISA;
/// JCB card brand
+ (NSString *)CARD_TYPE_JCB;
/// Maestro card brand
+ (NSString *)CARD_TYPE_MAESTRO;
/// UnionPay card brand
+ (NSString *)CARD_TYPE_UNION_PAY;
/// Switch card brand
+ (NSString *)CARD_TYPE_SWITCH;
/// Solo card brand
+ (NSString *)CARD_TYPE_SOLO;
/// Laser card brand
+ (NSString *)CARD_TYPE_LASER;
/// PayPal (as a standalone term, referring to the payment method type, analogous to Visa or Discover)
+ (NSString *)PAYMENT_METHOD_TYPE_PAYPAL;
/// Coinbase (as a standalone term, referring to the bitcoin wallet company)
+ (NSString *)PAYMENT_METHOD_TYPE_COINBASE;
/// Venmo (as a standalone term, referring to Venmo the company)
+ (NSString *)PAYMENT_METHOD_TYPE_VENMO;
/// Apple Pay (as a standalone term, referring to Apple Pay the product offered by Apple.)
+ (NSString *)PAYMENT_METHOD_TYPE_APPLE_PAY;

#pragma mark Development Strings (usually not localized)

+ (NSString *)DEV_SAMPLE_SMS_CODE_TITLE;
+ (NSString *)DEV_SAMPLE_SMS_CODE_INFO;

@end
