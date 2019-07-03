#import <XCTest/XCTest.h>

#import "BTUIKAppearance.h"
#import "UIColor+BTUIK.h"
#import "BTDropInController.h"

@interface BTUIKAppearanceTests : XCTestCase

@end

@implementation BTUIKAppearanceTests

- (void)test_lightTheme_setsCorrectValues {
    BTUIKAppearance *appearance = [BTUIKAppearance sharedInstance];
    [BTUIKAppearance lightTheme];
    
    XCTAssert([appearance.overlayColor isEqual:[UIColor btuik_colorFromHex:@"000000" alpha:0.5]]);
    XCTAssert([appearance.tintColor isEqual:[UIColor btuik_colorFromHex:@"2489F6" alpha:1.0]]);
    XCTAssert([appearance.disabledColor isEqual:UIColor.lightGrayColor]);
    XCTAssert([appearance.errorForegroundColor isEqual:[UIColor btuik_colorFromHex:@"ff3b30" alpha:1.0]]);
    XCTAssert([appearance.switchThumbTintColor isEqual:UIColor.whiteColor]);
    XCTAssert([appearance.switchOnTintColor isEqual:UIColor.greenColor]);
    XCTAssertEqual(appearance.font, [UIFont systemFontOfSize:10]);
    XCTAssertEqual(appearance.boldFont, [UIFont boldSystemFontOfSize:10]);
    XCTAssertEqual(appearance.useBlurs, YES);
    XCTAssertEqual(appearance.postalCodeFormFieldKeyboardType, UIKeyboardTypeNumberPad);
    
    XCTAssert([appearance.barBackgroundColor isEqual:UIColor.whiteColor]);
    XCTAssert([appearance.formBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"EFEFF4" alpha:1.0]]);
    XCTAssert([appearance.formFieldBackgroundColor isEqual: UIColor.whiteColor]);
    XCTAssert([appearance.primaryTextColor isEqual:UIColor.blackColor]);
    XCTAssert([appearance.secondaryTextColor isEqual:[UIColor btuik_colorFromHex:@"666666" alpha:1.0]]);
    XCTAssert([appearance.placeholderTextColor isEqual:UIColor.lightGrayColor]);
    XCTAssert([appearance.lineColor isEqual:[UIColor btuik_colorFromHex:@"BFBFBF" alpha:1.0]]);
    XCTAssertEqual(appearance.blurStyle, UIBlurEffectStyleExtraLight);
    XCTAssertEqual(appearance.activityIndicatorViewStyle, UIActivityIndicatorViewStyleGray);
}

- (void)test_darkTheme_setsCorrectValues {
    BTUIKAppearance *appearance = [BTUIKAppearance sharedInstance];
    [BTUIKAppearance darkTheme];
    
    XCTAssert([appearance.overlayColor isEqual:[UIColor btuik_colorFromHex:@"000000" alpha:0.5]]);
    XCTAssert([appearance.tintColor isEqual:[UIColor btuik_colorFromHex:@"2489F6" alpha:1.0]]);
    XCTAssert([appearance.disabledColor isEqual:UIColor.lightGrayColor]);
    XCTAssert([appearance.errorForegroundColor isEqual:[UIColor btuik_colorFromHex:@"ff3b30" alpha:1.0]]);
    XCTAssert([appearance.switchThumbTintColor isEqual:UIColor.whiteColor]);
    XCTAssert([appearance.switchOnTintColor isEqual:UIColor.greenColor]);
    XCTAssertEqual(appearance.font, [UIFont systemFontOfSize:10]);
    XCTAssertEqual(appearance.boldFont, [UIFont boldSystemFontOfSize:10]);
    XCTAssertEqual(appearance.useBlurs, YES);
    XCTAssertEqual(appearance.postalCodeFormFieldKeyboardType, UIKeyboardTypeNumberPad);
    
    XCTAssert([appearance.barBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"222222" alpha:1.0]]);
    XCTAssert([appearance.formBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"222222" alpha:1.0]]);
    XCTAssert([appearance.formFieldBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"333333" alpha:1.0]]);
    XCTAssert([appearance.primaryTextColor isEqual:UIColor.whiteColor]);
    XCTAssert([appearance.secondaryTextColor isEqual:[UIColor btuik_colorFromHex:@"999999" alpha:1.0]]);
    XCTAssert([appearance.placeholderTextColor isEqual:[UIColor btuik_colorFromHex:@"8E8E8E" alpha:1.0]]);
    XCTAssert([appearance.lineColor isEqual:[UIColor btuik_colorFromHex:@"666666" alpha:1.0]]);
    XCTAssertEqual(appearance.blurStyle, UIBlurEffectStyleDark);
    XCTAssertEqual(appearance.activityIndicatorViewStyle, UIActivityIndicatorViewStyleWhite);
}

- (void)test_useSystemAppearance_inLightMode {
    if (@available(iOS 13.0, *)) {
        BTUIKAppearance *appearance = [BTUIKAppearance sharedInstance];
        appearance.useSystemAppearance = YES;

        BTDropInController *dropInVC = [[BTDropInController alloc] init];
        dropInVC.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        [dropInVC viewDidLoad];

        XCTAssert([appearance.overlayColor isEqual:[UIColor btuik_colorFromHex:@"000000" alpha:0.5]]);
        XCTAssert([appearance.tintColor isEqual:[UIColor btuik_colorFromHex:@"2489F6" alpha:1.0]]);
        XCTAssert([appearance.disabledColor isEqual:UIColor.lightGrayColor]);
        XCTAssert([appearance.errorForegroundColor isEqual:[UIColor btuik_colorFromHex:@"ff3b30" alpha:1.0]]);
        XCTAssert([appearance.switchThumbTintColor isEqual:UIColor.whiteColor]);
        XCTAssert([appearance.switchOnTintColor isEqual:UIColor.greenColor]);
        XCTAssertEqual(appearance.font, [UIFont systemFontOfSize:10]);
        XCTAssertEqual(appearance.boldFont, [UIFont boldSystemFontOfSize:10]);
        XCTAssertEqual(appearance.useBlurs, YES);
        XCTAssertEqual(appearance.postalCodeFormFieldKeyboardType, UIKeyboardTypeNumberPad);

        XCTAssert([appearance.barBackgroundColor isEqual:UIColor.whiteColor]);
        XCTAssert([appearance.formBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"EFEFF4" alpha:1.0]]);
        XCTAssert([appearance.formFieldBackgroundColor isEqual: UIColor.whiteColor]);
        XCTAssert([appearance.primaryTextColor isEqual:UIColor.blackColor]);
        XCTAssert([appearance.secondaryTextColor isEqual:[UIColor btuik_colorFromHex:@"666666" alpha:1.0]]);
        XCTAssert([appearance.placeholderTextColor isEqual:UIColor.lightGrayColor]);
        XCTAssert([appearance.lineColor isEqual:[UIColor btuik_colorFromHex:@"BFBFBF" alpha:1.0]]);
        XCTAssertEqual(appearance.blurStyle, UIBlurEffectStyleExtraLight);
        XCTAssertEqual(appearance.activityIndicatorViewStyle, UIActivityIndicatorViewStyleGray);
    }
}

- (void)test_useSystemAppearance_inDarkMode {
    if (@available(iOS 13.0, *)) {
        BTUIKAppearance *appearance = [BTUIKAppearance sharedInstance];
        appearance.useSystemAppearance = YES;

        BTDropInController *dropInVC = [[BTDropInController alloc] init];
        dropInVC.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        [dropInVC viewDidLoad];

        XCTAssert([appearance.overlayColor isEqual:[UIColor btuik_colorFromHex:@"000000" alpha:0.5]]);
        XCTAssert([appearance.tintColor isEqual:[UIColor btuik_colorFromHex:@"2489F6" alpha:1.0]]);
        XCTAssert([appearance.disabledColor isEqual:UIColor.lightGrayColor]);
        XCTAssert([appearance.errorForegroundColor isEqual:[UIColor btuik_colorFromHex:@"ff3b30" alpha:1.0]]);
        XCTAssert([appearance.switchThumbTintColor isEqual:UIColor.whiteColor]);
        XCTAssert([appearance.switchOnTintColor isEqual:UIColor.greenColor]);
        XCTAssertEqual(appearance.font, [UIFont systemFontOfSize:10]);
        XCTAssertEqual(appearance.boldFont, [UIFont boldSystemFontOfSize:10]);
        XCTAssertEqual(appearance.useBlurs, YES);
        XCTAssertEqual(appearance.postalCodeFormFieldKeyboardType, UIKeyboardTypeNumberPad);

        XCTAssert([appearance.barBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"222222" alpha:1.0]]);
        XCTAssert([appearance.formBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"222222" alpha:1.0]]);
        XCTAssert([appearance.formFieldBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"333333" alpha:1.0]]);
        XCTAssert([appearance.primaryTextColor isEqual:UIColor.whiteColor]);
        XCTAssert([appearance.secondaryTextColor isEqual:[UIColor btuik_colorFromHex:@"999999" alpha:1.0]]);
        XCTAssert([appearance.placeholderTextColor isEqual:[UIColor btuik_colorFromHex:@"8E8E8E" alpha:1.0]]);
        XCTAssert([appearance.lineColor isEqual:[UIColor btuik_colorFromHex:@"666666" alpha:1.0]]);
        XCTAssertEqual(appearance.blurStyle, UIBlurEffectStyleDark);
        XCTAssertEqual(appearance.activityIndicatorViewStyle, UIActivityIndicatorViewStyleWhite);
    }
}

- (void)test_useSystemAppearance_switchBetweenLightAndDarkMode {
    if (@available(iOS 13.0, *)) {
        BTUIKAppearance *appearance = [BTUIKAppearance sharedInstance];
        appearance.useSystemAppearance = YES;

        BTDropInController *dropInVC = [[BTDropInController alloc] init];
        dropInVC.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        [dropInVC viewDidLoad];

        dropInVC.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        [dropInVC viewDidLoad];

        XCTAssert([appearance.barBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"222222" alpha:1.0]]);
        XCTAssert([appearance.formBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"222222" alpha:1.0]]);
        XCTAssert([appearance.formFieldBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"333333" alpha:1.0]]);
        XCTAssert([appearance.primaryTextColor isEqual:UIColor.whiteColor]);
        XCTAssert([appearance.secondaryTextColor isEqual:[UIColor btuik_colorFromHex:@"999999" alpha:1.0]]);
        XCTAssert([appearance.placeholderTextColor isEqual:[UIColor btuik_colorFromHex:@"8E8E8E" alpha:1.0]]);
        XCTAssert([appearance.lineColor isEqual:[UIColor btuik_colorFromHex:@"666666" alpha:1.0]]);
        XCTAssertEqual(appearance.blurStyle, UIBlurEffectStyleDark);
        XCTAssertEqual(appearance.activityIndicatorViewStyle, UIActivityIndicatorViewStyleWhite);

        dropInVC.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        [dropInVC viewDidLoad];

        XCTAssert([appearance.barBackgroundColor isEqual:UIColor.whiteColor]);
        XCTAssert([appearance.formBackgroundColor isEqual:[UIColor btuik_colorFromHex:@"EFEFF4" alpha:1.0]]);
        XCTAssert([appearance.formFieldBackgroundColor isEqual: UIColor.whiteColor]);
        XCTAssert([appearance.primaryTextColor isEqual:UIColor.blackColor]);
        XCTAssert([appearance.secondaryTextColor isEqual:[UIColor btuik_colorFromHex:@"666666" alpha:1.0]]);
        XCTAssert([appearance.placeholderTextColor isEqual:UIColor.lightGrayColor]);
        XCTAssert([appearance.lineColor isEqual:[UIColor btuik_colorFromHex:@"BFBFBF" alpha:1.0]]);
        XCTAssertEqual(appearance.blurStyle, UIBlurEffectStyleExtraLight);
        XCTAssertEqual(appearance.activityIndicatorViewStyle, UIActivityIndicatorViewStyleGray);
    }
}

- (void)test_navigationTitleTextColor_defaultsToPrimaryTextColor_whenNotSet {
    [BTUIKAppearance sharedInstance].primaryTextColor = [UIColor purpleColor];
    [BTUIKAppearance sharedInstance].navigationBarTitleTextColor = nil;
    XCTAssertEqual([BTUIKAppearance sharedInstance].navigationBarTitleTextColor, [BTUIKAppearance sharedInstance].primaryTextColor);
}

- (void)test_navigationTitleTextColor_returnsWhenSet {
    [BTUIKAppearance sharedInstance].primaryTextColor = [UIColor yellowColor];
    [BTUIKAppearance sharedInstance].navigationBarTitleTextColor = [UIColor brownColor];
    XCTAssertEqual([BTUIKAppearance sharedInstance].navigationBarTitleTextColor, [UIColor brownColor]);
}

- (void)test_styledNavigationTitleLabel_returnsLabelWithCorrectColor {
    [BTUIKAppearance sharedInstance].primaryTextColor = [UIColor whiteColor];
    [BTUIKAppearance sharedInstance].navigationBarTitleTextColor = [UIColor greenColor];
    XCTAssertEqual([BTUIKAppearance styledNavigationTitleLabel].textColor, [UIColor greenColor]);
}

- (void)test_settingFontFamily_returnsCorrectFont {
    [BTUIKAppearance sharedInstance].fontFamily = @"Verdana";
    XCTAssert([[BTUIKAppearance sharedInstance].font.fontName isEqualToString:@"Verdana"]);
}

- (void)test_settingBoldFontFamily_returnsCorrectBoldFont {
    [BTUIKAppearance sharedInstance].boldFontFamily = @"Courier-Bold";
    XCTAssert([[BTUIKAppearance sharedInstance].boldFont.fontName isEqualToString:@"Courier-Bold"]);
}

- (void)test_defaultFontFamily_returnsSystemFont {
    XCTAssertEqual([BTUIKAppearance sharedInstance].font, [UIFont systemFontOfSize:10.0]);
}

- (void)test_defaultBoldFontFamily_returnsBoldSystemFont {
    XCTAssertEqual([BTUIKAppearance sharedInstance].boldFont, [UIFont boldSystemFontOfSize:10.0]);
}

@end
