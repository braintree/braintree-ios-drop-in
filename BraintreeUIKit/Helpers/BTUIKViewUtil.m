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
#import "BTUIKCoinbaseMonogramCardView.h"
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
#import "BTUIKLargeCoinbaseMonogramCardView.h"
#import "BTUIKLargeVenmoMonogramCardView.h"
#import "BTUIKLargeUnionPayVectorArtView.h"
#import "BTUIKLargeHiperVectorArtView.h"
#import "BTUIKLargeHipercardVectorArtView.h"
#import "BTUIKLargeApplePayMarkVectorArtView.h"

#import "BTUIKCVVBackVectorArtView.h"
#import "BTUIKCVVFrontVectorArtView.h"

@import AudioToolbox;

@implementation BTUIKViewUtil

+ (BTUIKPaymentOptionType)paymentMethodTypeForCardType:(BTUIKCardType *)cardType {

    if (cardType == nil) {
        return BTUIKPaymentOptionTypeUnknown;
    }

    if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_AMERICAN_EXPRESS)]) {
        return BTUIKPaymentOptionTypeAMEX;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_VISA)]) {
        return BTUIKPaymentOptionTypeVisa;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_MASTER_CARD)]) {
        return BTUIKPaymentOptionTypeMasterCard;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_DISCOVER)]) {
        return BTUIKPaymentOptionTypeDiscover;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_JCB)]) {
        return BTUIKPaymentOptionTypeJCB;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_MAESTRO)]) {
        return BTUIKPaymentOptionTypeMaestro;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_DINERS_CLUB)]) {
        return BTUIKPaymentOptionTypeDinersClub;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_UNION_PAY)]) {
        return BTUIKPaymentOptionTypeUnionPay;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_HIPER)]) {
        return BTUIKPaymentOptionTypeHiper;
    } else if ([cardType.brand isEqualToString:BTUIKLocalizedString(CARD_TYPE_HIPERCARD)]) {
        return BTUIKPaymentOptionTypeHipercard;
    } else {
        return BTUIKPaymentOptionTypeUnknown;
    }
}

+ (NSString *)nameForPaymentMethodType:(BTUIKPaymentOptionType)paymentMethodType {
    switch (paymentMethodType) {
        case BTUIKPaymentOptionTypeUnknown:
            return BTUIKLocalizedString(CARD_TYPE_GENERIC_CARD);
        case BTUIKPaymentOptionTypeAMEX:
            return BTUIKLocalizedString(CARD_TYPE_AMERICAN_EXPRESS);
        case BTUIKPaymentOptionTypeDinersClub:
            return BTUIKLocalizedString(CARD_TYPE_DINERS_CLUB);
        case BTUIKPaymentOptionTypeDiscover:
            return BTUIKLocalizedString(CARD_TYPE_DISCOVER);
        case BTUIKPaymentOptionTypeMasterCard:
            return BTUIKLocalizedString(CARD_TYPE_MASTER_CARD);
        case BTUIKPaymentOptionTypeVisa:
            return BTUIKLocalizedString(CARD_TYPE_VISA);
        case BTUIKPaymentOptionTypeJCB:
            return BTUIKLocalizedString(CARD_TYPE_JCB);
        case BTUIKPaymentOptionTypeLaser:
            return BTUIKLocalizedString(CARD_TYPE_GENERIC_CARD);
        case BTUIKPaymentOptionTypeMaestro:
            return BTUIKLocalizedString(CARD_TYPE_MAESTRO);
        case BTUIKPaymentOptionTypeUnionPay:
            return BTUIKLocalizedString(CARD_TYPE_UNION_PAY);
        case BTUIKPaymentOptionTypeHiper:
            return BTUIKLocalizedString(CARD_TYPE_HIPER);
        case BTUIKPaymentOptionTypeHipercard:
            return BTUIKLocalizedString(CARD_TYPE_HIPERCARD);
        case BTUIKPaymentOptionTypeSolo:
            return BTUIKLocalizedString(CARD_TYPE_GENERIC_CARD);
        case BTUIKPaymentOptionTypeSwitch:
            return BTUIKLocalizedString(CARD_TYPE_GENERIC_CARD);
        case BTUIKPaymentOptionTypeUKMaestro:
            return BTUIKLocalizedString(CARD_TYPE_MAESTRO);
        case BTUIKPaymentOptionTypePayPal:
            return BTUIKLocalizedString(PAYPAL);
        case BTUIKPaymentOptionTypeCoinbase:
            return BTUIKLocalizedString(BRANDING_COINBASE);
        case BTUIKPaymentOptionTypeVenmo:
            return BTUIKLocalizedString(BRANDING_VENMO);
        case BTUIKPaymentOptionTypeApplePay:
            return BTUIKLocalizedString(BRANDING_APPLE_PAY);
    }
}

+ (void)vibrate {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

#pragma mark Icons

+ (BTUIKPaymentOptionType)paymentOptionTypeForPaymentInfoType:(NSString *)typeString {
    if ([typeString isEqualToString:@"Visa"]) {
        return BTUIKPaymentOptionTypeVisa;
    } else if ([typeString isEqualToString:@"MasterCard"]) {
        return BTUIKPaymentOptionTypeMasterCard;
    } else if ([typeString isEqualToString:@"Coinbase"]) {
        return BTUIKPaymentOptionTypeCoinbase;
    } else if ([typeString isEqualToString:@"PayPal"]) {
        return BTUIKPaymentOptionTypePayPal;
    } else if ([typeString isEqualToString:@"DinersClub"]) {
        return BTUIKPaymentOptionTypeDinersClub;
    } else if ([typeString isEqualToString:@"JCB"]) {
        return BTUIKPaymentOptionTypeJCB;
    } else if ([typeString isEqualToString:@"Maestro"]) {
        return BTUIKPaymentOptionTypeMaestro;
    } else if ([typeString isEqualToString:@"Discover"]) {
        return BTUIKPaymentOptionTypeDiscover;
    } else if ([typeString isEqualToString:@"UKMaestro"]) {
        return BTUIKPaymentOptionTypeUKMaestro;
    } else if ([typeString isEqualToString:@"AMEX"] || [typeString isEqualToString:@"American Express"]) {
        return BTUIKPaymentOptionTypeAMEX;
    } else if ([typeString isEqualToString:@"Solo"]) {
        return BTUIKPaymentOptionTypeSolo;
    } else if ([typeString isEqualToString:@"Laser"]) {
        return BTUIKPaymentOptionTypeLaser;
    } else if ([typeString isEqualToString:@"Switch"]) {
        return BTUIKPaymentOptionTypeSwitch;
    } else if ([typeString isEqualToString:@"UnionPay"]) {
        return BTUIKPaymentOptionTypeUnionPay;
    } else if ([typeString isEqualToString:@"Hiper"]) {
        return BTUIKPaymentOptionTypeHiper;
    } else if ([typeString isEqualToString:@"Hipercard"]) {
        return BTUIKPaymentOptionTypeHipercard;
    } else if ([typeString isEqualToString:@"Venmo"]) {
        return BTUIKPaymentOptionTypeVenmo;
    } else if ([typeString isEqualToString:@"ApplePay"]) {
        return BTUIKPaymentOptionTypeApplePay;
    } else {
        return BTUIKPaymentOptionTypeUnknown;
    }
}

+ (BOOL)isPaymentOptionTypeACreditCard:(BTUIKPaymentOptionType)paymentOptionType {
    switch(paymentOptionType) {
        case BTUIKPaymentOptionTypeVisa:
        case BTUIKPaymentOptionTypeMasterCard:
        case BTUIKPaymentOptionTypeDinersClub:
        case BTUIKPaymentOptionTypeJCB:
        case BTUIKPaymentOptionTypeMaestro:
        case BTUIKPaymentOptionTypeDiscover:
        case BTUIKPaymentOptionTypeUKMaestro:
        case BTUIKPaymentOptionTypeAMEX:
        case BTUIKPaymentOptionTypeSolo:
        case BTUIKPaymentOptionTypeLaser:
        case BTUIKPaymentOptionTypeSwitch:
        case BTUIKPaymentOptionTypeUnionPay:
        case BTUIKPaymentOptionTypeHiper:
        case BTUIKPaymentOptionTypeHipercard:
            return YES;
        default:
            return NO;
    }
}

+ (BTUIKVectorArtView *)vectorArtViewForPaymentInfoType:(NSString *)typeString {
    return [self vectorArtViewForPaymentOptionType:[self.class paymentOptionTypeForPaymentInfoType:typeString]];
}

+ (BTUIKVectorArtView *)vectorArtViewForPaymentOptionType:(BTUIKPaymentOptionType)type {
    return [self vectorArtViewForPaymentOptionType:type size:BTUIKVectorArtSizeRegular];
}

+ (BTUIKVectorArtView *)vectorArtViewForPaymentOptionType:(BTUIKPaymentOptionType)type size:(BTUIKVectorArtSize)size {
    switch (type) {
        case BTUIKPaymentOptionTypeVisa:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKVisaVectorArtView new] : [BTUIKLargeVisaVectorArtView new];
        case BTUIKPaymentOptionTypeMasterCard:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKMasterCardVectorArtView new] : [BTUIKLargeMasterCardVectorArtView new];
        case BTUIKPaymentOptionTypeCoinbase:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKCoinbaseMonogramCardView new] : [BTUIKLargeCoinbaseMonogramCardView new];
        case BTUIKPaymentOptionTypePayPal:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKPayPalMonogramCardView new] : [BTUIKLargePayPalMonogramCardView new];
        case BTUIKPaymentOptionTypeDinersClub:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKDinersClubVectorArtView new] : [BTUIKLargeDinersClubVectorArtView new];
        case BTUIKPaymentOptionTypeJCB:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKJCBVectorArtView new] : [BTUIKLargeJCBVectorArtView new];
        case BTUIKPaymentOptionTypeMaestro:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKMaestroVectorArtView new] : [BTUIKLargeMaestroVectorArtView new];
        case BTUIKPaymentOptionTypeDiscover:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKDiscoverVectorArtView new] : [BTUIKLargeDiscoverVectorArtView new];
        case BTUIKPaymentOptionTypeUKMaestro:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKMaestroVectorArtView new] : [BTUIKLargeMaestroVectorArtView new];
        case BTUIKPaymentOptionTypeAMEX:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKAmExVectorArtView new] : [BTUIKLargeAmExVectorArtView new];
        case BTUIKPaymentOptionTypeVenmo:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKVenmoMonogramCardView new] : [BTUIKLargeVenmoMonogramCardView new];
        case BTUIKPaymentOptionTypeUnionPay:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKUnionPayVectorArtView new] : [BTUIKLargeUnionPayVectorArtView new];
        case BTUIKPaymentOptionTypeHiper:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKHiperVectorArtView new] : [BTUIKLargeHiperVectorArtView new];
        case BTUIKPaymentOptionTypeHipercard:
            return size == BTUIKVectorArtSizeRegular ? [BTUIKHipercardVectorArtView new] : [BTUIKLargeHipercardVectorArtView new];
        case BTUIKPaymentOptionTypeApplePay:
            // No large apple pay
            return [BTUIKApplePayMarkVectorArtView new];
        case BTUIKPaymentOptionTypeSolo:
        case BTUIKPaymentOptionTypeLaser:
        case BTUIKPaymentOptionTypeSwitch:
        case BTUIKPaymentOptionTypeUnknown:
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
