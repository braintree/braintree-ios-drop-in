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
    request.applePayDisabled = self.applePayDisabled;
    request.paypalDisabled = self.paypalDisabled;
    request.threeDSecureVerification = self.threeDSecureVerification;
	request.shouldTokenize = self.shouldTokenize;
    return request;
}

@end
