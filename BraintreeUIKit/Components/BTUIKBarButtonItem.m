#import "BTUIKBarButtonItem.h"
#import "BTUIKAppearance.h"

@implementation BTUIKBarButtonItem

- (instancetype)init {
    if (self = [super init]) {
        [self updateTitleTextAttributes];
    }
    return self;
}

- (void)setBold:(BOOL)bold {
    _bold = bold;
    [self updateTitleTextAttributes];
}

- (void)updateTitleTextAttributes {
    NSString *fontName = self.bold ? [BTUIKAppearance sharedInstance].boldFontFamily : [BTUIKAppearance sharedInstance].fontFamily;
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].tintColor, NSFontAttributeName:[UIFont fontWithName:fontName size:[UIFont labelFontSize]]} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].tintColor, NSFontAttributeName:[UIFont fontWithName:fontName size:[UIFont labelFontSize]]} forState:UIControlStateNormal | UIControlStateHighlighted];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].disabledColor, NSFontAttributeName:[UIFont fontWithName:fontName size:[UIFont labelFontSize]]} forState:UIControlStateDisabled];
}

@end
