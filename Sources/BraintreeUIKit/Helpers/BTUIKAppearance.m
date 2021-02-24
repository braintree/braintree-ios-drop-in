#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKAppearance.h>
#import <BraintreeDropIn/UIColor+BTUIK.h>
#else
#import <BraintreeUIKit/BTUIKAppearance.h>
#import <BraintreeUIKit/UIColor+BTUIK.h>
#endif

@interface BTUIKAppearance ()

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *boldFont;

@end

@implementation BTUIKAppearance

static BTUIKAppearance *sharedTheme;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTheme = [BTUIKAppearance new];
    });
    
    return sharedTheme;
}

- (void)setFontFamily:(NSString *)fontFamily {
    _fontFamily = fontFamily;
    if (fontFamily != nil) {
        _font = [UIFont fontWithName:fontFamily size:10.0];
    } else {
        _font = [UIFont systemFontOfSize:10.0];
    }
}

- (void)setBoldFontFamily:(NSString *)boldFontFamily {
    _boldFontFamily = boldFontFamily;
    if (boldFontFamily != nil) {
        _boldFont = [UIFont fontWithName:boldFontFamily size:10.0];
    } else {
        _boldFont = [UIFont boldSystemFontOfSize:10.0];
    }
}

- (UIColor *)highlightedTintColor {
    return [sharedTheme.tintColor colorWithAlphaComponent:0.4];
}

+ (void)styleLabelPrimary:(UILabel *)label {
    label.font = [[BTUIKAppearance sharedInstance].font fontWithSize:UIFont.labelFontSize];
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleLabelBoldPrimary:(UILabel *)label {
    label.font = [[BTUIKAppearance sharedInstance].boldFont fontWithSize:UIFont.labelFontSize];
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleSmallLabelBoldPrimary:(UILabel *)label {
    label.font = [[BTUIKAppearance sharedInstance].boldFont fontWithSize:UIFont.smallSystemFontSize];
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleSmallLabelPrimary:(UILabel *)label {
    label.font = [[BTUIKAppearance sharedInstance].font fontWithSize:UIFont.smallSystemFontSize];
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleLabelSecondary:(UILabel *)label {
    label.font = [[BTUIKAppearance sharedInstance].font fontWithSize:UIFont.smallSystemFontSize];
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (void)styleLargeLabelSecondary:(UILabel *)label {
    label.font = [[BTUIKAppearance sharedInstance].font fontWithSize:UIFont.labelFontSize];
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (void)styleSystemLabelSecondary:(UILabel *)label {
    label.font = [[BTUIKAppearance sharedInstance].font fontWithSize:UIFont.systemFontSize];
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (UILabel *)styledNavigationTitleLabel {
    UILabel *tlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 40)];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.textColor = [BTUIKAppearance sharedInstance].navigationBarTitleTextColor;
    tlabel.font = [[BTUIKAppearance sharedInstance].boldFont fontWithSize:UIFont.labelFontSize];
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
