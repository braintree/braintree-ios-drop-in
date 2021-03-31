#import <BraintreeDropIn/BTDropInUICustomization.h>
#import "UIColor+BTUIK.h"

@implementation BTDropInUICustomization

- (instancetype)initWithColorScheme:(BTDropInColorScheme)colorScheme {
    if (self = [super init]) {
        _useBlurs = YES;
        _postalCodeFormFieldKeyboardType = UIKeyboardTypeDefault;

        // NEXT_MAJOR_VERSION: - Remove light and dark color schemes when we drop iOS 12 support. Merchants can force a color scheme if needed by setting overrideUserInterfaceStyle on `BTDropInController`.
        switch(colorScheme) {
            case BTDropInColorSchemeLight:
                _barBackgroundColor = UIColor.whiteColor;
                _formBackgroundColor = [UIColor btuik_colorFromHex:@"EFEFF4" alpha:1.0];
                _formFieldBackgroundColor =  UIColor.whiteColor;
                _primaryTextColor = UIColor.blackColor;
                _secondaryTextColor = [UIColor btuik_colorFromHex:@"3C3C43" alpha:1.0];
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
                _secondaryTextColor = [UIColor btuik_colorFromHex:@"EBEBF5" alpha:1.0];
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

@end
