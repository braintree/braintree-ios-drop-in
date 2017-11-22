#import "BTDropInOverrides.h"

@implementation BTDropInOverrides

static bool _displayVenmoOption = NO;

+ (bool)displayVenmoOption {
    return _displayVenmoOption;
}

+ (void)setDisplayVenmoOption:(bool)newDisplayVenmoOption {
    _displayVenmoOption = newDisplayVenmoOption;
}

@end
