#import "BTUIKAppearance.h"
#import "UIColor+BTUIK.h"
#import "UIFont+BTUIK.h"

@implementation BTUIKAppearance

static BTUIKAppearance *sharedTheme;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTheme = [BTUIKAppearance new];
    });
    
    return sharedTheme;
}

- (void)configureWithUICustomization:(BTDropInUICustomization *)uiCustomization {
    self.overlayColor = uiCustomization.overlayColor;
    self.tintColor = uiCustomization.tintColor;
    self.barBackgroundColor = uiCustomization.barBackgroundColor;
    self.fontFamily = uiCustomization.fontFamily;
    self.boldFontFamily = uiCustomization.boldFontFamily;
    self.formBackgroundColor = uiCustomization.formBackgroundColor;
    self.formFieldBackgroundColor = uiCustomization.formFieldBackgroundColor;
    self.primaryTextColor = uiCustomization.primaryTextColor;
    self.navigationBarTitleTextColor = uiCustomization.navigationBarTitleTextColor;
    self.secondaryTextColor = uiCustomization.secondaryTextColor;
    self.disabledColor = uiCustomization.disabledColor;
    self.placeholderTextColor = uiCustomization.placeholderTextColor;
    self.lineColor = uiCustomization.lineColor;
    self.errorForegroundColor = uiCustomization.errorForegroundColor;
    self.blurStyle = uiCustomization.blurStyle;
    self.activityIndicatorViewStyle = uiCustomization.activityIndicatorViewStyle;
    self.useBlurs = uiCustomization.useBlurs;
    self.postalCodeFormFieldKeyboardType = uiCustomization.postalCodeFormFieldKeyboardType;
    self.switchOnTintColor = uiCustomization.switchOnTintColor;
    self.switchThumbTintColor = uiCustomization.switchThumbTintColor;
    self.keyboardAppearance = uiCustomization.keyboardAppearance;
    self.disableDynamicType = uiCustomization.disableDynamicType;

    self.bodyFont = [UIFont bodyFontForFontFamily:uiCustomization.fontFamily useStaticSize:uiCustomization.disableDynamicType];
    self.staticBodyFont = [UIFont bodyFontForFontFamily:uiCustomization.fontFamily useStaticSize:YES];
    self.headlineFont = [UIFont headlineFontForFontFamily:uiCustomization.boldFontFamily useStaticSize:uiCustomization.disableDynamicType];
    self.staticHeadlineFont = [UIFont headlineFontForFontFamily:uiCustomization.boldFontFamily useStaticSize:YES];
    self.captionFont = [UIFont captionFontForFontFamily:uiCustomization.fontFamily useStaticSize:uiCustomization.disableDynamicType];
    self.staticCaptionFont = [UIFont captionFontForFontFamily:uiCustomization.fontFamily useStaticSize:YES];
    self.staticTitleFont = [UIFont titleFontForFontFamily:uiCustomization.fontFamily useStaticSize:YES];
}

- (UIColor *)highlightedTintColor {
    return [sharedTheme.tintColor colorWithAlphaComponent:0.4];
}

+ (void)styleLabelPrimary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].bodyFont;
    label.adjustsFontForContentSizeCategory = YES;
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleLabelBoldPrimary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].headlineFont;
    label.adjustsFontForContentSizeCategory = YES;
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleSmallLabelPrimary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].captionFont;
    label.adjustsFontForContentSizeCategory = YES;
    label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
}

+ (void)styleLabelSecondary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].captionFont;
    label.adjustsFontForContentSizeCategory = YES;
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (void)styleLargeLabelSecondary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].bodyFont;
    label.adjustsFontForContentSizeCategory = YES;
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (void)styleSystemLabelSecondary:(UILabel *)label {
    label.font = [BTUIKAppearance sharedInstance].staticBodyFont;
    label.adjustsFontForContentSizeCategory = YES;
    label.textColor = [BTUIKAppearance sharedInstance].secondaryTextColor;
}

+ (UILabel *)styledNavigationTitleLabel {
    UILabel *tlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 40)];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.textColor = [BTUIKAppearance sharedInstance].navigationBarTitleTextColor;
    tlabel.font = [BTUIKAppearance sharedInstance].staticHeadlineFont;
    tlabel.backgroundColor = UIColor.clearColor;
    tlabel.adjustsFontSizeToFitWidth = YES;
    tlabel.numberOfLines = 2;
    return tlabel;
}

+ (float)horizontalFormContentPadding {
    return 15.0f;
}

+ (float)minimumHitArea {
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
