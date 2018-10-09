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
    request.currencyCode = self.currencyCode;
    request.noShipping = self.noShipping;
    request.shippingAddress = self.shippingAddress;
    request.additionalPayPalScopes = self.additionalPayPalScopes;
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

@end
