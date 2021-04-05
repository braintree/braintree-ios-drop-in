#import <Foundation/Foundation.h>

@interface BTDropInLocalization : NSObject

/// Sets custom translation locales for the Drop-In UI
///
/// @param locales An array of locale codes
+ (void)setCustomTranslations:(NSArray<NSString *> *)locales;

@end
