#import "BTUIKLocalizedString.h"

@implementation BTUIKLocalizedString

static NSArray *customTranslations;

+ (NSBundle *)localizationBundle {
    static NSString * bundleName = @"Braintree-UIKit-Localization";
    if ([[NSLocale preferredLanguages] count] > 0) {
        NSString *language = [[NSLocale preferredLanguages] firstObject];
        // Ignore region portion of local ID
        language = [[[[language componentsSeparatedByString:@"_"] firstObject] componentsSeparatedByString:@"-"] firstObject];

        if (customTranslations && [customTranslations containsObject:language]) {
            return [NSBundle mainBundle];
        }
    }

    NSString *localizationBundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    if (!localizationBundlePath) {
        localizationBundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:bundleName ofType:@"bundle"];
    }
    
    return localizationBundlePath ? [NSBundle bundleWithPath:localizationBundlePath] : [NSBundle mainBundle];
}

+ (NSString *)localizationTable {
    return @"BTUI";
}

#pragma mark Localization helpers

+ (void)setCustomTranslations:(NSArray *)locales {
    customTranslations = [locales copy];
}

+ (NSString *)insertIntoLocalizedString:(NSString *)string replacement:(NSString* )replacement {
    return [self insertIntoLocalizedString:string replacement:replacement token:@"%s"];
}

+ (NSString *)insertIntoLocalizedString:(NSString *)string replacement:(NSString* )replacement token:(NSString *)token {
    return [string stringByReplacingOccurrencesOfString:token withString:replacement];
}

#pragma mark Localizations

+ (NSString *)CARD_DETAILS_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CARD_DETAILS_LABEL", [self localizationTable], [self localizationBundle], @"Card number is required", @"CARD_DETAILS_LABEL");
}
+ (NSString *)ENTER_CARD_DETAILS_HELP_LABEL {
    return NSLocalizedStringWithDefaultValue(@"ENTER_CARD_DETAILS_HELP_LABEL", [self localizationTable], [self localizationBundle], @"Enter your card details starting with the card number.", @"ENTER_CARD_DETAILS_HELP_LABEL");
}
+ (NSString *)VALID_CARD_ERROR_LABEL {
    return NSLocalizedStringWithDefaultValue(@"VALID_CARD_ERROR_LABEL", [self localizationTable], [self localizationBundle], @"You must provide a valid Card Number.", @"VALID_CARD_ERROR_LABEL");
}
+ (NSString *)CARD_REQUIRED {
    return NSLocalizedStringWithDefaultValue(@"CARD_REQUIRED", [self localizationTable], [self localizationBundle], @"Card number is required", @"CARD_REQUIRED");
}
+ (NSString *)CARD_INVALID {
    return NSLocalizedStringWithDefaultValue(@"CARD_INVALID", [self localizationTable], [self localizationBundle], @"Card number is invalid", @"CARD_INVALID");
}
+ (NSString *)EXPIRATION_REQUIRED {
    return NSLocalizedStringWithDefaultValue(@"EXPIRATION_REQUIRED", [self localizationTable], [self localizationBundle], @"Expiration date is required", @"EXPIRATION_REQUIRED");
}
+ (NSString *)EXPIRATION_INVALID {
    return NSLocalizedStringWithDefaultValue(@"EXPIRATION_INVALID", [self localizationTable], [self localizationBundle], @"Expiration date is invalid", @"EXPIRATION_INVALID");
}
+ (NSString *)CVV_REQUIRED {
    return NSLocalizedStringWithDefaultValue(@"CVV_REQUIRED", [self localizationTable], [self localizationBundle], @"%s is required", @"CVV_REQUIRED");
}
+ (NSString *)CVV_INVALID {
    return NSLocalizedStringWithDefaultValue(@"CVV_INVALID", [self localizationTable], [self localizationBundle], @"%s is invalid", @"CVV_INVALID");
}
+ (NSString *)POSTAL_CODE_HELP_LABEL {
    return NSLocalizedStringWithDefaultValue(@"POSTAL_CODE_HELP_LABEL", [self localizationTable], [self localizationBundle], @"You must provide a valid Postal Code.", @"POSTAL_CODE_HELP_LABEL");
}
+ (NSString *)POSTAL_CODE_REQUIRED {
    return NSLocalizedStringWithDefaultValue(@"POSTAL_CODE_REQUIRED", [self localizationTable], [self localizationBundle], @"Postal code is required", @"POSTAL_CODE_REQUIRED");
}
+ (NSString *)POSTAL_CODE_INVALID {
    return NSLocalizedStringWithDefaultValue(@"POSTAL_CODE_INVALID", [self localizationTable], [self localizationBundle], @"Postal code is invalid", @"POSTAL_CODE_INVALID");
}
+ (NSString *)COUNTRY_CODE_REQUIRED {
    return NSLocalizedStringWithDefaultValue(@"COUNTRY_CODE_REQUIRED", [self localizationTable], [self localizationBundle], @"Country code is required", @"COUNTRY_CODE_REQUIRED");
}
+ (NSString *)COUNTRY_CODE_INVALID {
    return NSLocalizedStringWithDefaultValue(@"COUNTRY_CODE_INVALID", [self localizationTable], [self localizationBundle], @"Country code is invalid", @"COUNTRY_CODE_INVALID");
}
+ (NSString *)MOBILE_NUMBER_REQUIRED {
    return NSLocalizedStringWithDefaultValue(@"MOBILE_NUMBER_REQUIRED", [self localizationTable], [self localizationBundle], @"Mobile number is required", @"MOBILE_NUMBER_REQUIRED");
}
+ (NSString *)MOBILE_NUMBER_INVALID {
    return NSLocalizedStringWithDefaultValue(@"MOBILE_NUMBER_INVALID", [self localizationTable], [self localizationBundle], @"Mobile number is invalid", @"MOBILE_NUMBER_INVALID");
}
+ (NSString *)ENROLLMENT_WITH_SMS_HELP_LABEL {
    return NSLocalizedStringWithDefaultValue(@"ENROLLMENT_WITH_SMS_HELP_LABEL", [self localizationTable], [self localizationBundle], @"Enrollment may be required for this card. An SMS code will be sent to this number if required.", @"ENROLLMENT_WITH_SMS_HELP_LABEL");
}
+ (NSString *)SMS_CODE_REQUIRED {
    return NSLocalizedStringWithDefaultValue(@"SMS_CODE_REQUIRED", [self localizationTable], [self localizationBundle], @"SMS code is required", @"SMS_CODE_REQUIRED");
}
+ (NSString *)SMS_CODE_INVALID {
    return NSLocalizedStringWithDefaultValue(@"SMS_CODE_INVALID", [self localizationTable], [self localizationBundle], @"SMS code is invalid", @"SMS_CODE_INVALID");
}


+ (NSString *)CANCEL_ACTION {
    return NSLocalizedStringWithDefaultValue(@"CANCEL_ACTION", [self localizationTable], [self localizationBundle], @"Cancel", @"CANCEL_ACTION");
}

+ (NSString *)RETRY_ACTION {
    return NSLocalizedStringWithDefaultValue(@"RETRY_ACTION", [self localizationTable], [self localizationBundle], @"Retry", @"RETRY_ACTION");
}

+ (NSString *)CONTINUE_ACTION {
    return NSLocalizedStringWithDefaultValue(@"CONTINUE_ACTION", [self localizationTable], [self localizationBundle], @"Continue", @"CONTINUE_ACTION");
}

+ (NSString *)ADD_CARD_ACTION {
    return NSLocalizedStringWithDefaultValue(@"ADD_CARD_ACTION", [self localizationTable], [self localizationBundle], @"Add Card", @"ADD_CARD_ACTION");
}

+ (NSString *)DONE_ACTION {
    return NSLocalizedStringWithDefaultValue(@"DONE_ACTION", [self localizationTable], [self localizationBundle], @"Done", @"DONE_ACTION");
}

+ (NSString *)EDIT_ACTION {
    return NSLocalizedStringWithDefaultValue(@"EDIT_ACTION", [self localizationTable], [self localizationBundle], @"Edit", @"EDIT_ACTION");
}

+ (NSString *)NEXT_ACTION {
    return NSLocalizedStringWithDefaultValue(@"NEXT_ACTION", [self localizationTable], [self localizationBundle], @"Next", @"NEXT_ACTION");
}

+ (NSString *)TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT {
    return NSLocalizedStringWithDefaultValue(@"TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT", [self localizationTable], [self localizationBundle], @"OK", @"TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT");
}

+ (NSString *)SCAN_CARD_IO_ACTION {
    return NSLocalizedStringWithDefaultValue(@"SCAN_CARD_IO_ACTION", [self localizationTable], [self localizationBundle], @"Scan with card.io", @"SCAN_CARD_IO_ACTION");
}

+ (NSString *)EDIT_PAYMENT_METHOD {
    return NSLocalizedStringWithDefaultValue(@"EDIT_PAYMENT_METHOD", [self localizationTable], [self localizationBundle], @"Edit Payment Methods", @"EDIT_PAYMENT_METHOD");
}

+ (NSString *)THERE_WAS_AN_ERROR {
    return NSLocalizedStringWithDefaultValue(@"THERE_WAS_AN_ERROR", [self localizationTable], [self localizationBundle], @"Sorry, there was an error.", @"THERE_WAS_AN_ERROR");
}

+ (NSString *)REVIEW_AND_TRY_AGAIN {
    return NSLocalizedStringWithDefaultValue(@"REVIEW_AND_TRY_AGAIN", [self localizationTable], [self localizationBundle], @"Please review your information and try again.", @"REVIEW_AND_TRY_AGAIN");
}

+ (NSString *)INVALID_LABEL {
    return NSLocalizedStringWithDefaultValue(@"INVALID_LABEL", [self localizationTable], [self localizationBundle], @"Invalid:", @"INVALID_LABEL");
}

+ (NSString *)YEAR_LABEL {
    return NSLocalizedStringWithDefaultValue(@"YEAR_LABEL", [self localizationTable], [self localizationBundle], @"Year", @"YEAR_LABEL");
}

+ (NSString *)MONTH_LABEL {
    return NSLocalizedStringWithDefaultValue(@"MONTH_LABEL", [self localizationTable], [self localizationBundle], @"Month", @"MONTH_LABEL");
}

+ (NSString *)OTHER_LABEL {
    return NSLocalizedStringWithDefaultValue(@"OTHER_LABEL", [self localizationTable], [self localizationBundle], @"Other", @"OTHER_LABEL");
}

+ (NSString *)CREDIT_OR_DEBIT_CARD_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CREDIT_OR_DEBIT_CARD_LABEL", [self localizationTable], [self localizationBundle], @"Credit or Debit Card", @"CREDIT_OR_DEBIT_CARD_LABEL");
}

+ (NSString *)RECENT_LABEL {
    return NSLocalizedStringWithDefaultValue(@"RECENT_LABEL", [self localizationTable], [self localizationBundle], @"Recent", @"RECENT_LABEL");
}

+ (NSString *)SELECT_PAYMENT_LABEL {
    return NSLocalizedStringWithDefaultValue(@"SELECT_PAYMENT_LABEL", [self localizationTable], [self localizationBundle], @"Select Payment Method", @"SELECT_PAYMENT_LABEL");
}

+ (NSString *)CONFIRM_ENROLLMENT_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CONFIRM_ENROLLMENT_LABEL", [self localizationTable], [self localizationBundle], @"Confirm Enrollment", @"CONFIRM_ENROLLMENT_LABEL");
}

+ (NSString *)CONFIRM_ACTION {
    return NSLocalizedStringWithDefaultValue(@"CONFIRM_ACTION", [self localizationTable], [self localizationBundle], @"Confirm", @"CONFIRM_ACTION");
}

+ (NSString *)ENTER_SMS_CODE_SENT_HELP_LABEL {
    return NSLocalizedStringWithDefaultValue(@"ENTER_SMS_CODE_SENT_HELP_LABEL", [self localizationTable], [self localizationBundle], @"Enter the SMS code sent to %s", @"ENTER_SMS_CODE_SENT_HELP_LABEL");
}

+ (NSString *)SMS_CODE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"SMS_CODE_LABEL", [self localizationTable], [self localizationBundle], @"SMS Code", @"SMS_CODE_LABEL");
}

+ (NSString *)CARD_TYPE_GENERIC_CARD {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_GENERIC_CARD", [self localizationTable], [self localizationBundle], @"Card", @"CARD_TYPE_GENERIC_CARD");
}

+ (NSString *)MOBILE_COUNTRY_CODE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"MOBILE_COUNTRY_CODE_LABEL", [self localizationTable], [self localizationBundle], @"Country Code", @"MOBILE_COUNTRY_CODE_LABEL");
}

+ (NSString *)SECURITY_CODE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"SECURITY_CODE_LABEL", [self localizationTable], [self localizationBundle], @"Security Code", @"SECURITY_CODE_LABEL");
}

+ (NSString *)CVV_FIELD_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"CVV_FIELD_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"CVV", @"CVV_FIELD_PLACEHOLDER");
}

+ (NSString *)CVC_FIELD_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"CVC_FIELD_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"CVC", @"CVC_FIELD_PLACEHOLDER");
}

+ (NSString *)CID_FIELD_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"CID_FIELD_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"CID", @"CID_FIELD_PLACEHOLDER");
}

+ (NSString *)CVN_FIELD_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"CVN_FIELD_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"CVN", @"CVN_FIELD_PLACEHOLDER");
}

+ (NSString *)POSTAL_CODE_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"POSTAL_CODE_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"Postal Code", @"POSTAL_CODE_PLACEHOLDER");
}

+ (NSString *)MOBILE_NUMBER_LABEL {
    return NSLocalizedStringWithDefaultValue(@"MOBILE_NUMBER_LABEL", [self localizationTable], [self localizationBundle], @"Mobile Number", @"MOBILE_NUMBER_LABEL");
}

+ (NSString *)EXPIRATION_DATE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"EXPIRATION_DATE_LABEL", [self localizationTable], [self localizationBundle], @"Expiration Date", @"EXPIRATION_DATE_LABEL");
}

+ (NSString *)CARD_NUMBER_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"CARD_NUMBER_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"Card Number", @"CARD_NUMBER_PLACEHOLDER");
}

+ (NSString *)EXPIRY_PLACEHOLDER_FOUR_DIGIT_YEAR {
    return NSLocalizedStringWithDefaultValue(@"EXPIRY_PLACEHOLDER_FOUR_DIGIT_YEAR", [self localizationTable], [self localizationBundle], @"MM / YYYY", @"EXPIRY_PLACEHOLDER_FOUR_DIGIT_YEAR");
}

+ (NSString *)EXPIRY_PLACEHOLDER_TWO_DIGIT_YEAR {
    return NSLocalizedStringWithDefaultValue(@"EXPIRY_PLACEHOLDER_TWO_DIGIT_YEAR", [self localizationTable], [self localizationBundle], @"MM / YY", @"EXPIRY_PLACEHOLDER_TWO_DIGIT_YEAR");
}

+ (NSString *)CARDHOLDER_NAME_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CARDHOLDER_NAME_LABEL", [self localizationTable], [self localizationBundle], @"Cardholder Name", @"CARDHOLDER_NAME_LABEL");
}


+ (NSString *)PAYPAL {
    return NSLocalizedStringWithDefaultValue(@"PAYPAL", [self localizationTable], [self localizationBundle], @"PayPal", @"PAYPAL");
}

+ (NSString *)CARD_TYPE_AMERICAN_EXPRESS {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_AMERICAN_EXPRESS", [self localizationTable], [self localizationBundle], @"American Express", @"CARD_TYPE_AMERICAN_EXPRESS");
}

+ (NSString *)CARD_TYPE_DISCOVER {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_DISCOVER", [self localizationTable], [self localizationBundle], @"Discover", @"CARD_TYPE_DISCOVER");
}

+ (NSString *)CARD_TYPE_DINERS_CLUB {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_DINERS_CLUB", [self localizationTable], [self localizationBundle], @"Diners Club", @"CARD_TYPE_DINERS_CLUB");
}

+ (NSString *)CARD_TYPE_MASTER_CARD {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_MASTER_CARD", [self localizationTable], [self localizationBundle], @"MasterCard", @"CARD_TYPE_MASTER_CARD");
}

+ (NSString *)CARD_TYPE_VISA {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_VISA", [self localizationTable], [self localizationBundle], @"Visa", @"CARD_TYPE_VISA");
}

+ (NSString *)CARD_TYPE_JCB {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_JCB", [self localizationTable], [self localizationBundle], @"JCB", @"CARD_TYPE_JCB");
}

+ (NSString *)CARD_TYPE_MAESTRO {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_MAESTRO", [self localizationTable], [self localizationBundle], @"Maestro", @"CARD_TYPE_MAESTRO");
}

+ (NSString *)CARD_TYPE_UNION_PAY {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_UNION_PAY", [self localizationTable], [self localizationBundle], @"UnionPay", @"CARD_TYPE_UNION_PAY");
}

+ (NSString *)BRANDING_COINBASE {
    return NSLocalizedStringWithDefaultValue(@"BRANDING_COINBASE", [self localizationTable], [self localizationBundle], @"Coinbase", @"BRANDING_COINBASE");
}

+ (NSString *)BRANDING_VENMO {
    return NSLocalizedStringWithDefaultValue(@"BRANDING_VENMO", [self localizationTable], [self localizationBundle], @"Venmo", @"BRANDING_VENMO");
}

+ (NSString *)BRANDING_APPLE_PAY {
    return NSLocalizedStringWithDefaultValue(@"BRANDING_APPLE_PAY", [self localizationTable], [self localizationBundle], @"Apple Pay", @"BRANDING_APPLE_PAY");
}

+ (NSString *)USE_DIFFERENT_PHONE_NUMBER_ACTION {
    return NSLocalizedStringWithDefaultValue(@"USE_DIFFERENT_PHONE_NUMBER_ACTION", [self localizationTable], [self localizationBundle], @"Use a different phone number", @"USE_DIFFERENT_PHONE_NUMBER_ACTION");
}

+ (NSString *)CARD_NOT_ACCEPTED_ERROR_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CARD_NOT_ACCEPTED_ERROR_LABEL", [self localizationTable], [self localizationBundle], @"Card not accepted", @"CARD_NOT_ACCEPTED_ERROR_LABEL");
}

#pragma mark Development Strings (usually not localized)

+ (NSString *)DEV_SAMPLE_SMS_CODE_TITLE {
    return NSLocalizedStringWithDefaultValue(@"DEV_SAMPLE_SMS_CODE_TITLE", [self localizationTable], [self localizationBundle], @"Sandbox Sample SMS Code", @"DEV_SAMPLE_SMS_CODE_TITLE");
}

+ (NSString *)DEV_SAMPLE_SMS_CODE_INFO {
    return NSLocalizedStringWithDefaultValue(@"DEV_SAMPLE_SMS_CODE_INFO", [self localizationTable], [self localizationBundle], @"Any code passes, example: 12345 \n\nIncorrect code is: 999999", @"DEV_SAMPLE_SMS_CODE_INFO");
}

@end
