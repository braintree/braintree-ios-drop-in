#import <Foundation/Foundation.h>

@interface BTDropInOverrides : NSObject

/// Used for testing. Show Venmo option when configured correctly but Venmo is not installed.
@property (class, nonatomic) BOOL displayVenmoOption;

@end
