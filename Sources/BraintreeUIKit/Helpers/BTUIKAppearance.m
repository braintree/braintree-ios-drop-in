#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKAppearance.h>
#import <BraintreeDropIn/UIColor+BTUIK.h>
#else
#import <BraintreeUIKit/BTUIKAppearance.h>
#import <BraintreeUIKit/UIColor+BTUIK.h>
#endif

@implementation BTUIKAppearance

static BTUIKAppearance *sharedTheme;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTheme = [BTUIKAppearance new];
    });
    
    return sharedTheme;
}

- (UIColor *)highlightedTintColor {
    return [sharedTheme.tintColor colorWithAlphaComponent:0.4];
}

+ (void)styleLabelPrimary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].bodyFont;
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleLabelBoldPrimary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].headlineFont;
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleSmallLabelPrimary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].captionFont;
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleLabelSecondary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].captionFont;
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (void)styleLargeLabelSecondary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].bodyFont;
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (void)styleSystemLabelSecondary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].subheadlineFont;
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (UILabel *)styledNavigationTitleLabel {
    UILabel *tlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 40)];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.textColor = [BTUIKAppearance sharedInstance].navigationBarTitleTextColor;
    tlabel.font = [BTUIKAppearance sharedInstance].headlineFont; // TODO: - we don't want this to scale
    tlabel.backgroundColor = UIColor.clearColor;
    tlabel.adjustsFontSizeToFitWidth = YES;
    tlabel.numberOfLines = 2;
    return tlabel;
}

+ (float)horizontalFormContentPadding {
    return 15.0f;
}

+ (float)formCellHeight {
    return 44.0f;
}

+ (float)verticalFormSpace {
    return 35.0f;
}

+ (float)verticalFormSpaceTight {
    return 10.0f;
}

+ (float)verticalSectionSpace {
    return 30.0f;
}

+ (float)smallIconWidth {
    return 45.0;
}

+ (float)smallIconHeight {
    return 29.0;
}

+ (float)largeIconWidth {
    return 100.0;
}

+ (float)largeIconHeight {
    return 100.0;
}

+ (NSDictionary*)metrics {
    static NSDictionary *sharedMetrics;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMetrics = @{@"HORIZONTAL_FORM_PADDING":@([BTUIKAppearance horizontalFormContentPadding]),
                          @"FORM_CELL_HEIGHT":@([BTUIKAppearance formCellHeight]),
                          @"VERTICAL_FORM_SPACE":@([BTUIKAppearance verticalFormSpace]),
                          @"VERTICAL_FORM_SPACE_TIGHT":@([BTUIKAppearance verticalFormSpaceTight]),
                          @"VERTICAL_SECTION_SPACE":@([BTUIKAppearance verticalSectionSpace]),
                          @"ICON_WIDTH":@([BTUIKAppearance smallIconWidth]),
                          @"ICON_HEIGHT":@([BTUIKAppearance smallIconHeight]),
                          @"LARGE_ICON_WIDTH":@([BTUIKAppearance largeIconWidth]),
                          @"LARGE_ICON_HEIGHT":@([BTUIKAppearance largeIconHeight])};
    });
    
    return sharedMetrics;
}

- (UIColor *)navigationBarTitleTextColor {
    return _navigationBarTitleTextColor ?: _primaryTextColor;
}

@end
