#import <BraintreeDropIn/BTDropInRequest.h>
#if __has_include(<Braintree/BraintreeCore.h>) // CocoaPods
#import <Braintree/BTPostalAddress.h>
#else
#import <BraintreeCore/BTPostalAddress.h>
#endif

@implementation BTDropInRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        _vaultCard = YES;
    }

    return self;
}

- (id)copyWithZone:(__unused NSZone *)zone {
    BTDropInRequest *request = [BTDropInRequest new];

    request.payPalRequest = self.payPalRequest;
    request.venmoRequest = self.venmoRequest;
    request.applePayDisabled = self.applePayDisabled;
    request.paypalDisabled = self.paypalDisabled;
    request.venmoDisabled = self.venmoDisabled;
    request.cardDisabled = self.cardDisabled;
    request.threeDSecureRequest = self.threeDSecureRequest;
    request.cardholderNameSetting = self.cardholderNameSetting;
    request.shouldMaskSecurityCode = self.shouldMaskSecurityCode;
    request.vaultManager = self.vaultManager;
    request.vaultCard = self.vaultCard;
    request.allowVaultCardOverride = self.allowVaultCardOverride;
    return request;
}

@end
