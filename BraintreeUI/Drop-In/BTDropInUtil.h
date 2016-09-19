#if __has_include("BraintreeCard.h")
#import "BraintreeCard.h"
#else
#import <BraintreeCard/BraintreeCard.h>
#endif
#import "BTUIPaymentOptionType.h"

@interface BTDropInUtil : NSObject

+ (BTUIPaymentOptionType)uiForCardNetwork:(BTCardNetwork)cardNetwork;

@end
