#import "BTDropInUICustomization_Internal.h"

#ifdef COCOAPODS
#import <BraintreeDropIn/UIColor+BTUIK.h>
#else
#import <BraintreeUIKit/UIColor+BTUIK.h>
#endif

@implementation BTDropInUICustomization

- (instancetype)initWithColorScheme:(BTDropInColorScheme)colorScheme {
    if (self = [super init]) {
        _useBlurs = YES;
        _postalCodeFormFieldKeyboardType = UIKeyboardTypeDefault;

        switch(colorScheme) {
            case BTDropInColorSchemeLight:
                _barBackgroundColor = UIColor.whiteColor;
                _formBackgroundColor = [UIColor btuik_colorFromHex:@"EFEFF4" alpha:1.0];
                _formFieldBackgroundColor =  UIColor.whiteColor;
                _primaryTextColor = UIColor.blackColor;
                _secondaryTextColor = [UIColor btuik_colorFromHex:@"666666" alpha:1.0];
                _placeholderTextColor = UIColor.lightGrayColor;
                _lineColor = [UIColor btuik_colorFromHex:@"BFBFBF" alpha:1.0];
                _blurStyle = UIBlurEffectStyleExtraLight;
                _activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                _overlayColor = [UIColor btuik_colorFromHex:@"000000" alpha:0.5];
                _tintColor = [UIColor btuik_colorFromHex:@"2489F6" alpha:1.0];
                _disabledColor = UIColor.lightGrayColor;
                _errorForegroundColor = [UIColor btuik_colorFromHex:@"ff3b30" alpha:1.0];
                _switchThumbTintColor =  UIColor.whiteColor;
                _switchOnTintColor = UIColor.greenColor;
                _keyboardAppearance = UIKeyboardAppearanceLight;
                break;

            case BTDropInColorSchemeDark:
                _barBackgroundColor = [UIColor btuik_colorFromHex:@"222222" alpha:1.0];
                _formBackgroundColor = [UIColor btuik_colorFromHex:@"222222" alpha:1.0];
                _formFieldBackgroundColor = [UIColor btuik_colorFromHex:@"333333" alpha:1.0];
                _primaryTextColor = UIColor.whiteColor;
                _secondaryTextColor = [UIColor btuik_colorFromHex:@"999999" alpha:1.0];
                _placeholderTextColor = [UIColor btuik_colorFromHex:@"8E8E8E" alpha:1.0];
                _lineColor = [UIColor btuik_colorFromHex:@"666666" alpha:1.0];
                _blurStyle = UIBlurEffectStyleDark;
                _activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
                _overlayColor = [UIColor btuik_colorFromHex:@"000000" alpha:0.5];
                _tintColor = [UIColor btuik_colorFromHex:@"2489F6" alpha:1.0];
                _disabledColor = UIColor.lightGrayColor;
                _errorForegroundColor = [UIColor btuik_colorFromHex:@"ff3b30" alpha:1.0];
                _switchThumbTintColor =  UIColor.whiteColor;
                _switchOnTintColor = UIColor.greenColor;
                _keyboardAppearance = UIKeyboardAppearanceDark;
                break;

            default: // dynamic
                if (@available(iOS 13, *)) {
                    _barBackgroundColor = UIColor.systemBackgroundColor;
                    _formBackgroundColor = UIColor.systemGroupedBackgroundColor;
                    _formFieldBackgroundColor = UIColor.secondarySystemGroupedBackgroundColor;
                    _primaryTextColor = UIColor.labelColor;
                    _secondaryTextColor = UIColor.secondaryLabelColor;
                    _placeholderTextColor = UIColor.placeholderTextColor;
                    _lineColor = UIColor.separatorColor;
                    _blurStyle = UIBlurEffectStyleSystemMaterial;
                    _activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
                }
                _overlayColor = [UIColor.blackColor colorWithAlphaComponent:0.5];
                _tintColor = UIColor.systemBlueColor;
                _disabledColor = UIColor.systemGrayColor;
                _errorForegroundColor = UIColor.systemRedColor;
                _switchThumbTintColor =  UIColor.whiteColor;
                _switchOnTintColor = UIColor.systemGreenColor;
        }
    }

    return self;
}

// TODO: - remove these font methods in favor of UIFont extension methods

- (UIFont *)bodyFont {
    UIFont *customFont;
    if (self.fontFamily) {
        customFont = [UIFont fontWithName:self.fontFamily size:UIFont.labelFontSize];
    }

    if (customFont) {
        if (self.disableDynamicType) {
            return customFont;
        } else {
            return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody] scaledFontForFont:customFont];
        }
    } else {
        if (self.disableDynamicType) {
            return [UIFont systemFontOfSize:UIFont.labelFontSize];
        } else {
            return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        }
    }
}

- (UIFont *)staticBodyFont {
    UIFont *customFont;
    if (self.fontFamily) {
        customFont = [UIFont fontWithName:self.fontFamily size:UIFont.labelFontSize];
    }

    if (customFont) {
        return customFont;
    } else {
        return [UIFont systemFontOfSize:UIFont.labelFontSize];
    }
}


- (UIFont *)headlineFont {
    UIFont *customFont;
    if (self.boldFontFamily) {
        customFont = [UIFont fontWithName:self.boldFontFamily size:UIFont.labelFontSize];
    }

    if (customFont) {
        if (self.disableDynamicType) {
            return customFont;
        } else {
            return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleHeadline] scaledFontForFont:customFont];
        }
    } else {
        if (self.disableDynamicType) {
            return [UIFont boldSystemFontOfSize:UIFont.labelFontSize];
        } else {
            return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        }
    }
}

- (UIFont *)staticHeadlineFont {
    UIFont *customFont;
    if (self.boldFontFamily) {
        customFont = [UIFont fontWithName:self.boldFontFamily size:UIFont.labelFontSize];
    }

    if (customFont) {
        return customFont;
    } else {
        return [UIFont boldSystemFontOfSize:UIFont.labelFontSize];
    }
}

- (UIFont *)subheadlineFont {
    UIFont *customFont;
    if (self.fontFamily) {
        customFont = [UIFont fontWithName:self.fontFamily size:UIFont.systemFontSize];
    }

    if (customFont) {
        if (self.disableDynamicType) {
            return customFont;
        } else {
            return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleSubheadline] scaledFontForFont:customFont];
        }
    } else {
        if (self.disableDynamicType) {
            return [UIFont systemFontOfSize:UIFont.systemFontSize];
        } else {
            return [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        }
    }
}

- (UIFont *)captionFont {
    UIFont *customFont;
    if (self.fontFamily) {
        customFont = [UIFont fontWithName:self.fontFamily size:UIFont.smallSystemFontSize];
    }

    if (customFont) {
        if (self.disableDynamicType) {
            return customFont;
        } else {
            return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleCaption1] scaledFontForFont:customFont];
        }
    } else {
        if (self.disableDynamicType) {
            return [UIFont systemFontOfSize:UIFont.smallSystemFontSize];
        } else {
            return [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        }
    }
}

- (UIFont *)staticCaptionFont {
    UIFont *customFont;
    if (self.fontFamily) {
        customFont = [UIFont fontWithName:self.fontFamily size:UIFont.smallSystemFontSize];
    }

    if (customFont) {
        return customFont;
    } else {
        return [UIFont systemFontOfSize:UIFont.smallSystemFontSize];
    }
}

- (UIFont *)staticTitleFont {
    UIFont *customFont;
    if (self.fontFamily) {
        customFont = [UIFont fontWithName:self.fontFamily size:24];
    }

    if (customFont) {
        return customFont;
    } else {
        return [UIFont systemFontOfSize:24];
    }
}

@end
