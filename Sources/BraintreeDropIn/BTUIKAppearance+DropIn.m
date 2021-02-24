#import "BTUIKAppearance+DropIn.h"

#ifdef COCOAPODS
#import <BraintreeDropIn/BraintreeUIKit.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

@implementation BTUIKAppearance (DropIn)

- (void)configureWithUICustomization:(BTDropInUICustomization *)uiCustomization {
    [BTUIKAppearance sharedInstance].overlayColor = uiCustomization.overlayColor;
    [BTUIKAppearance sharedInstance].tintColor = uiCustomization.tintColor;
    [BTUIKAppearance sharedInstance].barBackgroundColor = uiCustomization.barBackgroundColor;
    [BTUIKAppearance sharedInstance].fontFamily = uiCustomization.fontFamily;
    [BTUIKAppearance sharedInstance].boldFontFamily = uiCustomization.boldFontFamily;
    [BTUIKAppearance sharedInstance].formBackgroundColor = uiCustomization.formBackgroundColor;
    [BTUIKAppearance sharedInstance].formFieldBackgroundColor = uiCustomization.formFieldBackgroundColor;
    [BTUIKAppearance sharedInstance].primaryTextColor = uiCustomization.primaryTextColor;
    [BTUIKAppearance sharedInstance].navigationBarTitleTextColor = uiCustomization.navigationBarTitleTextColor;
    [BTUIKAppearance sharedInstance].secondaryTextColor = uiCustomization.secondaryTextColor;
    [BTUIKAppearance sharedInstance].disabledColor = uiCustomization.disabledColor;
    [BTUIKAppearance sharedInstance].placeholderTextColor = uiCustomization.placeholderTextColor;
    [BTUIKAppearance sharedInstance].lineColor = uiCustomization.lineColor;
    [BTUIKAppearance sharedInstance].errorForegroundColor = uiCustomization.errorForegroundColor;
    [BTUIKAppearance sharedInstance].blurStyle = uiCustomization.blurStyle;
    [BTUIKAppearance sharedInstance].activityIndicatorViewStyle = uiCustomization.activityIndicatorViewStyle;
    [BTUIKAppearance sharedInstance].useBlurs = uiCustomization.useBlurs;
    [BTUIKAppearance sharedInstance].postalCodeFormFieldKeyboardType = uiCustomization.postalCodeFormFieldKeyboardType;
    [BTUIKAppearance sharedInstance].switchOnTintColor = uiCustomization.switchOnTintColor;
    [BTUIKAppearance sharedInstance].switchThumbTintColor = uiCustomization.switchThumbTintColor;
    [BTUIKAppearance sharedInstance].keyboardAppearance = uiCustomization.keyboardAppearance;
    [BTUIKAppearance sharedInstance].disableDynamicType = uiCustomization.disableDynamicType;

    [BTUIKAppearance sharedInstance].bodyFont = [UIFont bodyFontForFontFamily:uiCustomization.fontFamily useStaticSize:uiCustomization.disableDynamicType];
    [BTUIKAppearance sharedInstance].staticBodyFont = [UIFont bodyFontForFontFamily:uiCustomization.fontFamily useStaticSize:YES];
    [BTUIKAppearance sharedInstance].headlineFont = [UIFont headlineFontForFontFamily:uiCustomization.boldFontFamily useStaticSize:uiCustomization.disableDynamicType];
    [BTUIKAppearance sharedInstance].staticHeadlineFont = [UIFont headlineFontForFontFamily:uiCustomization.boldFontFamily useStaticSize:YES];
    [BTUIKAppearance sharedInstance].captionFont = [UIFont captionFontForFontFamily:uiCustomization.fontFamily useStaticSize:uiCustomization.disableDynamicType];
    [BTUIKAppearance sharedInstance].staticCaptionFont = [UIFont captionFontForFontFamily:uiCustomization.fontFamily useStaticSize:YES];
    [BTUIKAppearance sharedInstance].staticTitleFont = [UIFont titleFontForFontFamily:uiCustomization.fontFamily useStaticSize:YES];
}

@end
