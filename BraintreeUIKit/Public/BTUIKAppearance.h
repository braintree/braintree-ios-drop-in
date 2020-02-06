#import <UIKit/UIKit.h>

@interface BTUIKAppearance : NSObject

typedef NS_ENUM(NSInteger, BTUIKColorScheme) {
    BTUIKColorSchemeLight,
    BTUIKColorSchemeDark,
    BTUIKColorSchemeDynamic API_AVAILABLE(ios(13.0))
};

/// Shared instance used by Form elements
+ (instancetype)sharedInstance;

/// Fallback color for the overlay if blur is disabled
@property (nonatomic, strong) UIColor *overlayColor;
/// Tint color
@property (nonatomic, strong) UIColor *tintColor;
/// Bar color
@property (nonatomic, strong) UIColor *barBackgroundColor;
/// Font family
@property (nonatomic, strong) NSString *fontFamily;
/// Bold font family
@property (nonatomic, strong) NSString *boldFontFamily;
// Font, defaults to system font
@property (nonatomic, strong, readonly) UIFont *font;
// Bold font, defaults to system bold font
@property (nonatomic, strong, readonly) UIFont *boldFont;
/// Sheet background color
@property (nonatomic, strong) UIColor *formBackgroundColor;
/// Form field background color
@property (nonatomic, strong) UIColor *formFieldBackgroundColor;
/// Primary text color
@property (nonatomic, strong) UIColor *primaryTextColor;
/// Navigation title text color
/// Defaults to nil. When not set, navigation titles will use primaryTextColor
@property (nonatomic, strong) UIColor *navigationBarTitleTextColor;
/// Secondary text color
@property (nonatomic, strong) UIColor *secondaryTextColor;
/// Color of disabled buttons
@property (nonatomic, strong) UIColor *disabledColor;
/// Placeholder text color for form fields
@property (nonatomic, strong) UIColor *placeholderTextColor;
/// Line and border color
@property (nonatomic, strong) UIColor *lineColor;
/// Error foreground color
@property (nonatomic, strong) UIColor *errorForegroundColor;
/// Blur style
@property (nonatomic) UIBlurEffectStyle blurStyle;
/// Activity indicator style
@property (nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/// Toggle blur effects
@property (nonatomic) BOOL useBlurs;
/// The keyboard the postal code field should use
@property (nonatomic) UIKeyboardType postalCodeFormFieldKeyboardType;
/// The highlighted version of the `tintColor`
@property (nonatomic, readonly, getter = highlightedTintColor) UIColor *highlightedTintColor;
/// Tint color for UISwitch when in the on position
@property (nonatomic, strong) UIColor *switchOnTintColor;
/// Tint color for UISwitch thumb
@property (nonatomic, strong) UIColor *switchThumbTintColor;
/// Color scheme of the Drop-In UI.
///
/// When set to BTUIKColorSchemeLight, the Drop-In UI uses a light color palette.
/// When set to BTUIKColorSchemeDark, the Drop-In UI uses a dark color palette.
/// When set to BTUIKColorSchemeDynamic, the Drop-In UI uses a dark or light color palette depending on the user's light or dark mode system preference. Only available in iOS 13+
@property (nonatomic) enum BTUIKColorScheme colorScheme;
/// Appearance style of keyboards associated with text fields
@property (nonatomic) UIKeyboardAppearance keyboardAppearance;

/// Sets the color (primary or secondary) and font with family and size (large or small)
/// These properties are on the [BTUIKAppearance sharedInstance]
+ (void)styleLabelPrimary:(UILabel *)label;
+ (void)styleLabelBoldPrimary:(UILabel *)label;
+ (void)styleSmallLabelBoldPrimary:(UILabel *)label;
+ (void)styleSmallLabelPrimary:(UILabel *)label;
+ (void)styleLabelSecondary:(UILabel *)label;
+ (void)styleLargeLabelSecondary:(UILabel *)label;
+ (void)styleSystemLabelSecondary:(UILabel *)label;
+ (UILabel *)styledNavigationTitleLabel;

+ (float)horizontalFormContentPadding;
+ (float)formCellHeight;
+ (float)verticalFormSpace;
+ (float)verticalFormSpaceTight;
+ (float)verticalSectionSpace;
+ (float)smallIconWidth;
+ (float)smallIconHeight;
+ (float)largeIconWidth;
+ (float)largeIconHeight;
+ (NSDictionary*)metrics;

@end
