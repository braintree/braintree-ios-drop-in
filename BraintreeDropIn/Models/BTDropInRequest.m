#import "BTDropInRequest.h"
#if __has_include("BraintreeCore.h")
#import "BTPostalAddress.h"
#else
#import <BraintreeCore/BTPostalAddress.h>
#endif

@implementation BTDropInRequest

- (id)copyWithZone:(__unused NSZone *)zone {
    BTDropInRequest *request = [BTDropInRequest new];
    request.amount = self.amount;
    request.payPalRequest = self.payPalRequest;
    request.applePayDisabled = self.applePayDisabled;
    request.paypalDisabled = self.paypalDisabled;
    request.venmoDisabled = self.venmoDisabled;
    request.cardDisabled = self.cardDisabled;
    request.threeDSecureVerification = self.threeDSecureVerification;
    request.cardholderNameSetting = self.cardholderNameSetting;
    request.shouldMaskSecurityCode = self.shouldMaskSecurityCode;
    request.vaultManager = self.vaultManager;
    return request;
}

- (BOOL)onlyOnePaymentMethodEnabled {
    NSArray *paymentMethods = @[[NSNumber numberWithBool:self.paypalDisabled], [NSNumber numberWithBool:self.applePayDisabled], [NSNumber numberWithBool:self.venmoDisabled], [NSNumber numberWithBool:self.cardDisabled]];
    NSCountedSet *counts = [[NSCountedSet alloc] initWithArray:paymentMethods];
    return [counts countForObject:@NO] == 1;
}

- (BOOL)onlyCardEnabled {
    return self.onlyOnePaymentMethodEnabled && !self.cardDisabled;
}

@end
