#import <Foundation/Foundation.h>

#define kBTUIKCardExpirationValidatorFarFutureYears 20

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
@interface BTUIKCardExpirationValidator : NSObject

+ (BOOL)month:(NSUInteger)month year:(NSUInteger)year validForDate:(NSDate *)date;

@end
