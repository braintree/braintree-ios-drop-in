#import "BTUIKBarButtonItem.h"
#import "BTUIKAppearance.h"

@implementation BTUIKBarButtonItem

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* fontName = self.bold ? [BTUIKAppearance sharedInstance].boldFontFamily : [BTUIKAppearance sharedInstance].fontFamily;
        if (enabled) {
            [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].tintColor, NSFontAttributeName:[UIFont fontWithName:fontName size:[UIFont labelFontSize]]} forState:UIControlStateNormal];
        } else {
            [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].disabledColor, NSFontAttributeName:[UIFont fontWithName:fontName size:[UIFont labelFontSize]]} forState:UIControlStateNormal];
        }
    });
}

@end
