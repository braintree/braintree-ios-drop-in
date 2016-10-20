#import "BTUIKLocalizedString.h"

@implementation BTUIKLocalizedString

+ (NSBundle *)localizationBundle {

    static NSString * bundleName = @"Braintree-UIKit-Localization";
    NSString *localizationBundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    if (!localizationBundlePath) {
        localizationBundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:bundleName ofType:@"bundle"];
    }
    
    return localizationBundlePath ? [NSBundle bundleWithPath:localizationBundlePath] : [NSBundle mainBundle];
}

+ (NSString *)localizationTable {
    return @"BTUI";
}

+ (NSString *)NEXT_ACTION {
    return NSLocalizedStringWithDefaultValue(@"NEXT_ACTION", [self localizationTable], [self localizationBundle], @"Next", @"Next action");
}

+ (NSString *)EXPIRATION_DATE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"EXPIRATION_DATE_LABEL", [self localizationTable], [self localizationBundle], @"Expiration Date", @"EXPIRATION_DATE_LABEL");
}

+ (NSString *)YEAR_LABEL {
    return NSLocalizedStringWithDefaultValue(@"YEAR_LABEL", [self localizationTable], [self localizationBundle], @"Year", @"YEAR_LABEL");
}

+ (NSString *)MONTH_LABEL {
    return NSLocalizedStringWithDefaultValue(@"MONTH_LABEL", [self localizationTable], [self localizationBundle], @"Month", @"MONTH_LABEL");
}

+ (NSString *)MOBILE_COUNTRY_CODE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"MOBILE_COUNTRY_CODE_LABEL", [self localizationTable], [self localizationBundle], @"Mobile Country Code", @"MOBILE_COUNTRY_CODE_LABEL");
}

+ (NSString *)MOBILE_NUMBER_LABEL {
    return NSLocalizedStringWithDefaultValue(@"MOBILE_NUMBER_LABEL", [self localizationTable], [self localizationBundle], @"Mobile Number", @"MOBILE_NUMBER_LABEL");
}

+ (NSString *)SECURITY_CODE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"SECURITY_CODE_LABEL", [self localizationTable], [self localizationBundle], @"Security Code", @"SECURITY_CODE_LABEL");
}

+ (NSString *)CARD_TYPE_GENERIC_CARD {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_GENERIC_CARD", [self localizationTable], [self localizationBundle], @"Card", @"CARD_TYPE_GENERIC_CARD");
}

+ (NSString *)INVALID_LABEL {
    return NSLocalizedStringWithDefaultValue(@"INVALID_LABEL", [self localizationTable], [self localizationBundle], @"Invalid:", @"INVALID_LABEL");
}

+ (NSString *)CONFIRM_ENROLLMENT_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CONFIRM_ENROLLMENT_LABEL", [self localizationTable], [self localizationBundle], @"Confirm Enrollment", @"CONFIRM_ENROLLMENT_LABEL");
}

+ (NSString *)CONFIRM_ACTION {
    return NSLocalizedStringWithDefaultValue(@"CONFIRM_ACTION", [self localizationTable], [self localizationBundle], @"Confirm", @"CONFIRM_ACTION");
}

+ (NSString *)ENTER_SMS_CODE_SENT_HELP_LABEL {
    return NSLocalizedStringWithDefaultValue(@"ENTER_SMS_CODE_SENT_HELP_LABEL", [self localizationTable], [self localizationBundle], @"Enter the SMS code sent to:", @"ENTER_SMS_CODE_SENT_HELP_LABEL");
}

+ (NSString *)SMS_CODE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"SMS_CODE_LABEL", [self localizationTable], [self localizationBundle], @"SMS Code", @"SMS_CODE_LABEL");
}

+ (NSString *)USE_DIFFERENT_PHONE_NUMBER_ACTION {
    return NSLocalizedStringWithDefaultValue(@"USE_DIFFERENT_PHONE_NUMBER_ACTION", [self localizationTable], [self localizationBundle], @"Use a Different Phone Number", @"USE_DIFFERENT_PHONE_NUMBER_ACTION");
}

+ (NSString *)INVALID_SMS_CODE_LABEL {
    return NSLocalizedStringWithDefaultValue(@"INVALID_SMS_CODE_LABEL", [self localizationTable], [self localizationBundle], @"Invalid SMS Code", @"INVALID_SMS_CODE_LABEL");
}

+ (NSString *)CANCEL_ACTION {
    return NSLocalizedStringWithDefaultValue(@"CANCEL_ACTION", [self localizationTable], [self localizationBundle], @"Cancel", @"CANCEL_ACTION");
}

+ (NSString *)SELECT_PAYMENT_LABEL {
    return NSLocalizedStringWithDefaultValue(@"SELECT_PAYMENT_LABEL", [self localizationTable], [self localizationBundle], @"Select Payment Method", @"SELECT_PAYMENT_LABEL");
}

+ (NSString *)RECENT_LABEL {
    return NSLocalizedStringWithDefaultValue(@"RECENT_LABEL", [self localizationTable], [self localizationBundle], @"Recent", @"RECENT_LABEL");
}

+ (NSString *)OTHER_LABEL {
    return NSLocalizedStringWithDefaultValue(@"OTHER_LABEL", [self localizationTable], [self localizationBundle], @"Other", @"OTHER_LABEL");
}

+ (NSString *)CREDIT_OR_DEBIT_CARD_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CREDIT_OR_DEBIT_CARD_LABEL", [self localizationTable], [self localizationBundle], @"Credit or Debit Card", @"CREDIT_OR_DEBIT_CARD_LABEL");
}

+ (NSString *)CARD_DETAILS_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CARD_DETAILS_LABEL", [self localizationTable], [self localizationBundle], @"Card Details", @"CARD_DETAILS_LABEL");
}

+ (NSString *)ENTER_CARD_DETAILS_HELP_LABEL {
    return NSLocalizedStringWithDefaultValue(@"ENTER_CARD_DETAILS_HELP_LABEL", [self localizationTable], [self localizationBundle], @"Enter your card details starting with the card number.", @"ENTER_CARD_DETAILS_HELP_LABEL");
}

+ (NSString *)ENROLLMENT_REQUIRED_HELP_LABEL {
    return NSLocalizedStringWithDefaultValue(@"ENROLLMENT_REQUIRED_HELP_LABEL", [self localizationTable], [self localizationBundle], @"Enrollment is required for this card.", @"ENROLLMENT_REQUIRED_HELP_LABEL");
}

+ (NSString *)ENROLLMENT_VIA_SMS_HELP_LABEL {
    return NSLocalizedStringWithDefaultValue(@"ENROLLMENT_VIA_SMS_HELP_LABEL", [self localizationTable], [self localizationBundle], @"An enrollment number will be sent by SMS.", @"ENROLLMENT_VIA_SMS_HELP_LABEL");
}

+ (NSString *)ADD_CARD_ACTION {
    return NSLocalizedStringWithDefaultValue(@"ADD_CARD_ACTION", [self localizationTable], [self localizationBundle], @"You must provide a valid card number", @"ADD_CARD_ACTION");
}

+ (NSString *)VALID_CARD_ERROR_LABEL {
    return NSLocalizedStringWithDefaultValue(@"VALID_CARD_ERROR_LABEL", [self localizationTable], [self localizationBundle], @"", @"VALID_CARD_ERROR_LABEL");
}

+ (NSString *)CARD_NOT_ACCEPTED_ERROR_LABEL {
    return NSLocalizedStringWithDefaultValue(@"CARD_NOT_ACCEPTED_ERROR_LABEL", [self localizationTable], [self localizationBundle], @"Card not accepted", @"CARD_NOT_ACCEPTED_ERROR_LABEL");
}

+ (NSString *)CARD_NUMBER_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"CARD_NUMBER_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"Card Number", @"Credit card number field placeholder");
}

+ (NSString *)CVV_FIELD_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"CVV_FIELD_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"CVV", @"CVV (credit card security code) field placeholder");
}

+ (NSString *)EXPIRY_PLACEHOLDER_FOUR_DIGIT_YEAR {
    return NSLocalizedStringWithDefaultValue(@"EXPIRY_PLACEHOLDER_FOUR_DIGIT_YEAR", [self localizationTable], [self localizationBundle], @"MM/YYYY", @"Credit card expiration date field placeholder (MM/YYYY format)");
}

+ (NSString *)EXPIRY_PLACEHOLDER_TWO_DIGIT_YEAR {
    return NSLocalizedStringWithDefaultValue(@"EXPIRY_PLACEHOLDER_TWO_DIGIT_YEAR", [self localizationTable], [self localizationBundle], @"MM/YY", @"Credit card expiration date field placeholder (MM/YY format)");
}

+ (NSString *)POSTAL_CODE_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"POSTAL_CODE_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"Postal Code", @"Credit card billing postal code field placeholder");
}

+ (NSString *)TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT {
    return NSLocalizedStringWithDefaultValue(@"TOP_LEVEL_ERROR_ALERT_VIEW_OK_BUTTON_TEXT", [self localizationTable], [self localizationBundle], @"OK", @"OK Button on card form alert view for top level errors");
}

+ (NSString *)PHONE_NUMBER_PLACEHOLDER {
    return NSLocalizedStringWithDefaultValue(@"PHONE_NUMBER_PLACEHOLDER", [self localizationTable], [self localizationBundle], @"Phone Number", @"Phone number field placeholder");
}

#pragma mark Card Brands

+ (NSString *)CARD_TYPE_AMERICAN_EXPRESS {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_AMERICAN_EXPRESS", [self localizationTable], [self localizationBundle], @"American Express", @"American Express card brand");
}

+ (NSString *)CARD_TYPE_DISCOVER {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_DISCOVER", [self localizationTable], [self localizationBundle], @"Discover", @"Discover card brand");
}

+ (NSString *)CARD_TYPE_DINERS_CLUB {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_DINERS_CLUB", [self localizationTable], [self localizationBundle], @"Diners Club", @"Diners Club card brand");
}

+ (NSString *)CARD_TYPE_MASTER_CARD {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_MASTER_CARD", [self localizationTable], [self localizationBundle], @"MasterCard", @"MasterCard card brand");
}

+ (NSString *)CARD_TYPE_VISA {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_VISA", [self localizationTable], [self localizationBundle], @"Visa", @"Visa card brand");
}

+ (NSString *)CARD_TYPE_JCB {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_JCB", [self localizationTable], [self localizationBundle], @"JCB", @"JCB card brand");
}

+ (NSString *)CARD_TYPE_MAESTRO {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_MAESTRO", [self localizationTable], [self localizationBundle], @"Maestro", @"Maestro card brand");
}

+ (NSString *)CARD_TYPE_UNION_PAY {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_UNION_PAY", [self localizationTable], [self localizationBundle], @"UnionPay", @"UnionPay card brand");
}

+ (NSString *)CARD_TYPE_SWITCH {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_SWITCH", [self localizationTable], [self localizationBundle], @"Switch", @"Switch card brand");
}

+ (NSString *)CARD_TYPE_SOLO {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_SOLO", [self localizationTable], [self localizationBundle], @"Solo", @"Solo card brand");
}

+ (NSString *)CARD_TYPE_LASER {
    return NSLocalizedStringWithDefaultValue(@"CARD_TYPE_LASER", [self localizationTable], [self localizationBundle], @"Laser", @"Laser card brand");
}

+ (NSString *)PAYMENT_METHOD_TYPE_PAYPAL {
    return NSLocalizedStringWithDefaultValue(@"PAYPAL", [self localizationTable], [self localizationBundle], @"PayPal", @"PayPal (as a standalone term, referring to the payment method type, analogous to Visa or Discover)");
}

+ (NSString *)PAYMENT_METHOD_TYPE_COINBASE {
    return NSLocalizedStringWithDefaultValue(@"COINBASE", [self localizationTable], [self localizationBundle], @"Coinbase", @"Coinbase (as a standalone term, referring to the bitcoin wallet company)");
}

+ (NSString *)PAYMENT_METHOD_TYPE_VENMO {
    return NSLocalizedStringWithDefaultValue(@"VENMO", [self localizationTable], [self localizationBundle], @"Venmo", @"Venmo (as a standalone term, referring to Venmo the company)");
}

+ (NSString *)PAYMENT_METHOD_TYPE_APPLE_PAY {
    return NSLocalizedStringWithDefaultValue(@"APPLE PAY", [self localizationTable], [self localizationBundle], @"Apple Pay", @"Apple Pay (as a standalone term, referring to Apple Pay the product offered by Apple.)");
}

+ (NSString *)DEV_SAMPLE_SMS_CODE_TITLE {
    return NSLocalizedStringWithDefaultValue(@"DEV_SAMPLE_SMS_CODE_TITLE", [self localizationTable], [self localizationBundle], @"Sandbox Sample SMS Code", @"DEV_SAMPLE_SMS_CODE_TITLE");
}

+ (NSString *)DEV_SAMPLE_SMS_CODE_INFO {
    return NSLocalizedStringWithDefaultValue(@"DEV_SAMPLE_SMS_CODE_INFO", [self localizationTable], [self localizationBundle], @"Any code passes, example: 12345 \n\nIncorrect code is: 999999", @"DEV_SAMPLE_SMS_CODE_INFO");
}

@end
