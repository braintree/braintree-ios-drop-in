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
    UIFont *font;
    if (self.bold) {
        font = [BTUIKAppearance sharedInstance].staticHeadlineFont;
    } else {
        font = [BTUIKAppearance sharedInstance].staticBodyFont;
    }

    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].tintColor,
                                   NSFontAttributeName:font}
                        forState:UIControlStateNormal];

    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].tintColor,
                                   NSFontAttributeName:font}
                        forState:UIControlStateNormal | UIControlStateHighlighted];

    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [BTUIKAppearance sharedInstance].disabledColor,
                                   NSFontAttributeName:font}
                        forState:UIControlStateDisabled];
}

@end
