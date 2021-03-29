#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Braintree Drop-in color scheme
typedef NS_ENUM(NSInteger, BTDropInColorScheme) {
    /// Light color palette
    BTDropInColorSchemeLight,
    /// Dark color palette
    BTDropInColorSchemeDark,
    /// Light or dark color palette, depending on the user's light or dark mode system preference. Only available in iOS 13+.
    BTDropInColorSchemeDynamic API_AVAILABLE(ios(13.0))
};

/**
 Options for customizing Braintree Drop-in's user interface.
 */
@interface BTDropInUICustomization : NSObject

+ (instancetype)new __attribute__((unavailable("Please use initWithColorScheme:")));

- (instancetype)init __attribute__((unavailable("Please use initWithColorScheme:")));

/// Creates an instance of BTDropInUICustomization with the given color scheme.
///
/// @param colorScheme The color scheme used to determine the default colors used. These defaults may be overriden by setting additional properties on BTDropInUICustomization.
///
/// @return UI customization options for Braintree Drop-in
- (instancetype)initWithColorScheme:(BTDropInColorScheme)colorScheme;

/// Fallback color for the overlay if blur is disabled
@property (nonatomic, strong) UIColor *overlayColor;

/// Tint color
@property (nonatomic, strong) UIColor *tintColor;

/// Bar color
@property (nonatomic, strong) UIColor *barBackgroundColor;

/// Font family. When not set, system font will be used.
@property (nonatomic, strong, nullable) NSString *fontFamily;

/// Bold font family. When not set, bold system font will be used.
@property (nonatomic, strong, nullable) NSString *boldFontFamily;

/// Sheet background color
@property (nonatomic, strong) UIColor *formBackgroundColor;

/// Form field background color
@property (nonatomic, strong) UIColor *formFieldBackgroundColor;

/// Primary text color
@property (nonatomic, strong) UIColor *primaryTextColor;

/// Navigation title text color
/// Defaults to nil. When not set, navigation titles will use primaryTextColor
@property (nonatomic, strong, nullable) UIColor *navigationBarTitleTextColor;

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

/// Tint color for UISwitch when in the on position
@property (nonatomic, strong) UIColor *switchOnTintColor;

/// Tint color for UISwitch thumb
@property (nonatomic, strong) UIColor *switchThumbTintColor;

/// Appearance style of keyboards associated with text fields
@property (nonatomic) UIKeyboardAppearance keyboardAppearance;

/// Defaults to false. Disabling this feature is highly discouraged, as it prevents users from adjusting Drop-in's text size to fit their needs.
@property (nonatomic) BOOL disableDynamicType;

@end

NS_ASSUME_NONNULL_END
