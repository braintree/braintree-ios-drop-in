#import <UIKit/UIKit.h>

@interface BTDropInUIUtilities : NSObject

+ (UIView *)addSpacerToStackView:(UIStackView*)stackView beforeView:(UIView*)view size:(float)size;
+ (UIStackView *)newStackView;
+ (UIStackView *)newStackViewForError:(NSString*)errorText;

@end
