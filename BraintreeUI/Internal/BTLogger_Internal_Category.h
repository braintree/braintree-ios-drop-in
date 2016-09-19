#import <Foundation/Foundation.h>

#if __has_include("BraintreeCore.h")
#import "BraintreeCore.h"
#else
#import <BraintreeCore/BraintreeCore.h>
#endif

@interface BTLogger (Internal)

- (void)log:(NSString *)format, ...;
- (void)critical:(NSString *)format, ...;
- (void)error:(NSString *)format, ...;
- (void)warning:(NSString *)format, ...;
- (void)info:(NSString *)format, ...;
- (void)debug:(NSString *)format, ...;

/// Custom block for handling log messages
@property (nonatomic, copy) void (^logBlock)(BTLogLevel level, NSString *message);

@end
