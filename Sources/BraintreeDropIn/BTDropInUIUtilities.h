#import <UIKit/UIKit.h>

#ifdef COCOAPODS
#import <BraintreeDropIn/BraintreeUIKit.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

@interface BTDropInUIUtilities : NSObject

+ (UIView *)addSpacerToStackView:(UIStackView*)stackView beforeView:(UIView*)view size:(float)size;
+ (UIStackView *)newStackView;
+ (UIStackView *)newStackViewForError:(NSString*)errorText;

@end
