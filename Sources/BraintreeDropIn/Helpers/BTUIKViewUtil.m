#import "BTUIKViewUtil.h"

#import "BTUIKMasterCardVectorArtView.h"
#import "BTUIKJCBVectorArtView.h"
#import "BTUIKMaestroVectorArtView.h"
#import "BTUIKVisaVectorArtView.h"
#import "BTUIKDiscoverVectorArtView.h"
#import "BTUIKUnknownCardVectorArtView.h"
#import "BTUIKDinersClubVectorArtView.h"
#import "BTUIKAmExVectorArtView.h"
#import "BTUIKPayPalMonogramCardView.h"
#import "BTUIKVenmoMonogramCardView.h"
#import "BTUIKUnionPayVectorArtView.h"
#import "BTUIKHipercardVectorArtView.h"
#import "BTUIKHiperVectorArtView.h"
#import "BTUIKApplePayMarkVectorArtView.h"
#import "BTUIKLargeMasterCardVectorArtView.h"
#import "BTUIKLargeJCBVectorArtView.h"
#import "BTUIKLargeMaestroVectorArtView.h"
#import "BTUIKLargeVisaVectorArtView.h"
#import "BTUIKLargeDiscoverVectorArtView.h"
#import "BTUIKLargeUnknownCardVectorArtView.h"
#import "BTUIKLargeDinersClubVectorArtView.h"
#import "BTUIKLargeAmExVectorArtView.h"
#import "BTUIKLargePayPalMonogramCardView.h"
#import "BTUIKLargeVenmoMonogramCardView.h"
#import "BTUIKLargeUnionPayVectorArtView.h"
#import "BTUIKLargeHiperVectorArtView.h"
#import "BTUIKLargeHipercardVectorArtView.h"
#import "BTUIKLargeApplePayMarkVectorArtView.h"

#import "BTUIKCVVBackVectorArtView.h"
#import "BTUIKCVVFrontVectorArtView.h"

@import AudioToolbox;

@implementation BTUIKViewUtil

+ (BTDropInPaymentMethodType)paymentMethodTypeForCardType:(BTUIKCardType *)cardType {

    if (cardType == nil) {
        return BTDropInPaymentMethodTypeUnknown;
    }

    if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_AMERICAN_EXPRESS)]) {
        return BTDropInPaymentMethodTypeAMEX;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_VISA)]) {
        return BTDropInPaymentMethodTypeVisa;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_MASTER_CARD)]) {
        return BTDropInPaymentMethodTypeMasterCard;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_DISCOVER)]) {
        return BTDropInPaymentMethodTypeDiscover;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_JCB)]) {
        return BTDropInPaymentMethodTypeJCB;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_MAESTRO)]) {
        return BTDropInPaymentMethodTypeMaestro;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_DINERS_CLUB)]) {
        return BTDropInPaymentMethodTypeDinersClub;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_UNION_PAY)]) {
        return BTDropInPaymentMethodTypeUnionPay;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_HIPER)]) {
        return BTDropInPaymentMethodTypeHiper;
    } else if ([cardType.brand isEqualToString:BTDropInLocalizedString(CARD_TYPE_HIPERCARD)]) {
        return BTDropInPaymentMethodTypeHipercard;
    } else {
        return BTDropInPaymentMethodTypeUnknown;
    }
}

+ (NSString *)nameForPaymentMethodType:(BTDropInPaymentMethodType)paymentMethodType {
    switch (paymentMethodType) {
        case BTDropInPaymentMethodTypeUnknown:
            return BTDropInLocalizedString(CARD_TYPE_GENERIC_CARD);
        case BTDropInPaymentMethodTypeAMEX:
            return BTDropInLocalizedString(CARD_TYPE_AMERICAN_EXPRESS);
        case BTDropInPaymentMethodTypeDinersClub:
            return BTDropInLocalizedString(CARD_TYPE_DINERS_CLUB);
        case BTDropInPaymentMethodTypeDiscover:
            return BTDropInLocalizedString(CARD_TYPE_DISCOVER);
        case BTDropInPaymentMethodTypeMasterCard:
            return BTDropInLocalizedString(CARD_TYPE_MASTER_CARD);
        case BTDropInPaymentMethodTypeVisa:
            return BTDropInLocalizedString(CARD_TYPE_VISA);
        case BTDropInPaymentMethodTypeJCB:
            return BTDropInLocalizedString(CARD_TYPE_JCB);
        case BTDropInPaymentMethodTypeLaser:
            return BTDropInLocalizedString(CARD_TYPE_GENERIC_CARD);
        case BTDropInPaymentMethodTypeMaestro:
            return BTDropInLocalizedString(CARD_TYPE_MAESTRO);
        case BTDropInPaymentMethodTypeUnionPay:
            return BTDropInLocalizedString(CARD_TYPE_UNION_PAY);
        case BTDropInPaymentMethodTypeHiper:
            return BTDropInLocalizedString(CARD_TYPE_HIPER);
        case BTDropInPaymentMethodTypeHipercard:
            return BTDropInLocalizedString(CARD_TYPE_HIPERCARD);
        case BTDropInPaymentMethodTypeSolo:
            return BTDropInLocalizedString(CARD_TYPE_GENERIC_CARD);
        case BTDropInPaymentMethodTypeSwitch:
            return BTDropInLocalizedString(CARD_TYPE_GENERIC_CARD);
        case BTDropInPaymentMethodTypeUKMaestro:
            return BTDropInLocalizedString(CARD_TYPE_MAESTRO);
        case BTDropInPaymentMethodTypePayPal:
            return BTDropInLocalizedString(PAYPAL);
        case BTDropInPaymentMethodTypeVenmo:
            return BTDropInLocalizedString(BRANDING_VENMO);
        case BTDropInPaymentMethodTypeApplePay:
            return BTDropInLocalizedString(BRANDING_APPLE_PAY);
    }
}

+ (void)vibrate {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

#pragma mark Icons

+ (BTDropInPaymentMethodType)paymentMethodTypeForPaymentInfoType:(NSString *)typeString {
    if ([typeString isEqualToString:@"Visa"]) {
        return BTDropInPaymentMethodTypeVisa;
    } else if ([typeString isEqualToString:@"MasterCard"]) {
        return BTDropInPaymentMethodTypeMasterCard;
    } else if ([typeString isEqualToString:@"PayPal"]) {
        return BTDropInPaymentMethodTypePayPal;
    } else if ([typeString isEqualToString:@"DinersClub"]) {
        return BTDropInPaymentMethodTypeDinersClub;
    } else if ([typeString isEqualToString:@"JCB"]) {
        return BTDropInPaymentMethodTypeJCB;
    } else if ([typeString isEqualToString:@"Maestro"]) {
        return BTDropInPaymentMethodTypeMaestro;
    } else if ([typeString isEqualToString:@"Discover"]) {
        return BTDropInPaymentMethodTypeDiscover;
    } else if ([typeString isEqualToString:@"UKMaestro"]) {
        return BTDropInPaymentMethodTypeUKMaestro;
    } else if ([typeString isEqualToString:@"AMEX"] || [typeString isEqualToString:@"American Express"]) {
        return BTDropInPaymentMethodTypeAMEX;
    } else if ([typeString isEqualToString:@"Solo"]) {
        return BTDropInPaymentMethodTypeSolo;
    } else if ([typeString isEqualToString:@"Laser"]) {
        return BTDropInPaymentMethodTypeLaser;
    } else if ([typeString isEqualToString:@"Switch"]) {
        return BTDropInPaymentMethodTypeSwitch;
    } else if ([typeString isEqualToString:@"UnionPay"]) {
        return BTDropInPaymentMethodTypeUnionPay;
    } else if ([typeString isEqualToString:@"Hiper"]) {
        return BTDropInPaymentMethodTypeHiper;
    } else if ([typeString isEqualToString:@"Hipercard"]) {
        return BTDropInPaymentMethodTypeHipercard;
    } else if ([typeString isEqualToString:@"Venmo"]) {
        return BTDropInPaymentMethodTypeVenmo;
    } else if ([typeString isEqualToString:@"ApplePay"]) {
        return BTDropInPaymentMethodTypeApplePay;
    } else {
        return BTDropInPaymentMethodTypeUnknown;
    }
}

+ (BOOL)isPaymentMethodTypeACreditCard:(BTDropInPaymentMethodType)paymentMethodType {
    switch(paymentMethodType) {
        case BTDropInPaymentMethodTypeVisa:
        case BTDropInPaymentMethodTypeMasterCard:
        case BTDropInPaymentMethodTypeDinersClub:
        case BTDropInPaymentMethodTypeJCB:
        case BTDropInPaymentMethodTypeMaestro:
        case BTDropInPaymentMethodTypeDiscover:
        case BTDropInPaymentMethodTypeUKMaestro:
        case BTDropInPaymentMethodTypeAMEX:
        case BTDropInPaymentMethodTypeSolo:
        case BTDropInPaymentMethodTypeLaser:
        case BTDropInPaymentMethodTypeSwitch:
        case BTDropInPaymentMethodTypeUnionPay:
        case BTDropInPaymentMethodTypeHiper:
        case BTDropInPaymentMethodTypeHipercard:
            return YES;
        default:
            return NO;
    }
}

+ (BTUIKVectorArtView *)vectorArtViewForPaymentInfoType:(NSString *)typeString {
    return [self vectorArtViewForPaymentMethodType:[self.class paymentMethodTypeForPaymentInfoType:typeString]];
}

+ (BTUIKVectorArtView *)vectorArtViewForPaymentMethodType:(BTDropInPaymentMethodType)type {
    return [self vectorArtViewForPaymentMethodType:type size:BTUIKVectorArtSizeRegular];
}

+ (BTUIKVectorArtView *)vectorArtViewForPaymentMethodType:(BTDropInPaymentMethodType)type size:(BTUIKVectorArtSize)size {
    switch (type) {
        case BTDropInPaymentMethodTypeVisa:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKVisaVectorArtView new] : [BTUIKLargeVisaVectorArtView new];
        case BTDropInPaymentMethodTypeMasterCard:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKMasterCardVectorArtView new] : [BTUIKLargeMasterCardVectorArtView new];
        case BTDropInPaymentMethodTypePayPal:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKPayPalMonogramCardView new] : [BTUIKLargePayPalMonogramCardView new];
        case BTDropInPaymentMethodTypeDinersClub:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKDinersClubVectorArtView new] : [BTUIKLargeDinersClubVectorArtView new];
        case BTDropInPaymentMethodTypeJCB:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKJCBVectorArtView new] : [BTUIKLargeJCBVectorArtView new];
        case BTDropInPaymentMethodTypeMaestro:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKMaestroVectorArtView new] : [BTUIKLargeMaestroVectorArtView new];
        case BTDropInPaymentMethodTypeDiscover:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKDiscoverVectorArtView new] : [BTUIKLargeDiscoverVectorArtView new];
        case BTDropInPaymentMethodTypeUKMaestro:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKMaestroVectorArtView new] : [BTUIKLargeMaestroVectorArtView new];
        case BTDropInPaymentMethodTypeAMEX:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKAmExVectorArtView new] : [BTUIKLargeAmExVectorArtView new];
        case BTDropInPaymentMethodTypeVenmo:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKVenmoMonogramCardView new] : [BTUIKLargeVenmoMonogramCardView new];
        case BTDropInPaymentMethodTypeUnionPay:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKUnionPayVectorArtView new] : [BTUIKLargeUnionPayVectorArtView new];
        case BTDropInPaymentMethodTypeHiper:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKHiperVectorArtView new] : [BTUIKLargeHiperVectorArtView new];
        case BTDropInPaymentMethodTypeHipercard:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKHipercardVectorArtView new] : [BTUIKLargeHipercardVectorArtView new];
        case BTDropInPaymentMethodTypeApplePay:
            // No large apple pay
            return [BTUIKApplePayMarkVectorArtView new];
        case BTDropInPaymentMethodTypeSolo:
        case BTDropInPaymentMethodTypeLaser:
        case BTDropInPaymentMethodTypeSwitch:
        case BTDropInPaymentMethodTypeUnknown:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKUnknownCardVectorArtView new] : [BTUIKLargeUnknownCardVectorArtView new];
    }
}

+ (BTUIKVectorArtView *)vectorArtViewForVisualAssetType:(BTUIKVisualAssetType)type {
    switch (type) {
        case BTUIKVisualAssetTypeCVVFront:
            return [BTUIKCVVFrontVectorArtView new];
        case BTUIKVisualAssetTypeCVVBack:
            return [BTUIKCVVBackVectorArtView new];
        case BTUIKVisualAssetTypeUnknown:
            return [BTUIKVectorArtView new];
    }
}

+ (BOOL)isLanguageLayoutDirectionRightToLeft {
    return [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

+ (NSTextAlignment)naturalTextAlignment {
    return [self isLanguageLayoutDirectionRightToLeft] ? NSTextAlignmentRight : NSTextAlignmentLeft;
}

+ (NSTextAlignment)naturalTextAlignmentInverse {
    return [self isLanguageLayoutDirectionRightToLeft] ? NSTextAlignmentLeft : NSTextAlignmentRight;
}

+ (UIWindowScene *)activeWindowScene API_AVAILABLE(ios(13.0)) {
    for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
        if (scene.activationState == UISceneActivationStateForegroundActive) {
            return (UIWindowScene *)scene;
        }
    }

    return nil;
}

+ (BOOL)isOrientationLandscape {
    if (@available(iOS 13, *)) {
        return UIInterfaceOrientationIsLandscape([self activeWindowScene].interfaceOrientation);
    } else {
        return UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication.statusBarOrientation);
    }
}

+ (CGFloat)statusBarHeight {
    if (@available(iOS 13, *)) {
        return CGRectGetHeight([self activeWindowScene].statusBarManager.statusBarFrame);
    } else {
        return CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame);
    }
}

@end
