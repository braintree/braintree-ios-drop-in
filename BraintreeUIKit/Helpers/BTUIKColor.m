#import "BTUIKColor.h"
#import "UIColor+BTUIK.h"

@implementation BTUIKColor

 + (UIColor *)dynamicBarBackgroundColor {
     return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
         if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
             return [UIColor btuik_colorFromHex:@"222222" alpha:1.0];
         } else {
             return UIColor.whiteColor;
         }
     }];
}

+ (UIColor *)dynamicFormBackgroundColor {
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return [UIColor btuik_colorFromHex:@"222222" alpha:1.0];
        } else {
            return [UIColor btuik_colorFromHex:@"EFEFF4" alpha:1.0];
        }
    }];
}

+ (UIColor *)dynamicFormFieldBackgroundColor {
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return [UIColor btuik_colorFromHex:@"333333" alpha:1.0];
        } else {
            return UIColor.whiteColor;
        }
    }];
}

+ (UIColor *)dynamicPrimaryTextColor {
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return UIColor.whiteColor;
        } else {
            return UIColor.blackColor;
        }
    }];
}

+ (UIColor *)dynamicSecondaryTextColor {
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return [UIColor btuik_colorFromHex:@"999999" alpha:1.0];
        } else {
            return [UIColor btuik_colorFromHex:@"666666" alpha:1.0];
        }
    }];
}

+ (UIColor *)dynamicPlaceholderTextColor {
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return [UIColor btuik_colorFromHex:@"8E8E8E" alpha:1.0];
        } else {
            return UIColor.lightGrayColor;
        }
    }];
}

+ (UIColor *)dynamicLineColor {
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trait) {
        if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
            return [UIColor btuik_colorFromHex:@"666666" alpha:1.0];
        } else {
            return [UIColor btuik_colorFromHex:@"BFBFBF" alpha:1.0];
        }
    }];
}

@end
