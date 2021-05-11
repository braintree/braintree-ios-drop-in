#import "BTConfiguration+DropIn.h"

@implementation BTConfiguration (DropIn)

-(NSArray<NSString *> *)supportedCardTypes {
    return (NSArray<NSString *> *)[self.json[@"creditCards"][@"supportedCardTypes"] asStringArray];
}

@end
