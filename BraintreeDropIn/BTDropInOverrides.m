#import "BTDropInOverrides.h"

@implementation BTDropInOverrides

static BOOL _displayVenmoOption = NO;

+ (BOOL)displayVenmoOption {
    return _displayVenmoOption;
}

+ (void)setDisplayVenmoOption:(BOOL)newDisplayVenmoOption {
    _displayVenmoOption = newDisplayVenmoOption;
}

@end
