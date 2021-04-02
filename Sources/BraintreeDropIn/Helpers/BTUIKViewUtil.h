#import <UIKit/UIKit.h>
#import "BTUIKCardType.h"
#import <BraintreeDropIn/BTDropInPaymentMethodType.h>
#import "BTUIKVisualAssetType.h"

@class BTUIKVectorArtView;

/// Size for vector art
typedef NS_ENUM(NSInteger, BTUIKVectorArtSize) {
    /// Small
    BTUIKVectorArtSizeRegular,
    /// Large
    BTUIKVectorArtSizeLarge,
};

/// @class Utilities used by other views to get localized strings, a BTDropInPaymentMethodType or artwork
@interface BTUIKViewUtil : NSObject

#pragma mark BTDropInPaymentMethodType Utilities

/// Get a BTDropInPaymentMethodType from a string
///
/// @param typeString string representing a payment option type (e.g `Visa` or `PayPal`)
/// @return The BTDropInPaymentMethodType associated with the string if it can be found. Otherwise, BTDropInPaymentMethodTypeUnknown.
+ (BTDropInPaymentMethodType)paymentMethodTypeForPaymentInfoType:(NSString *)typeString;

/// Get a BTDropInPaymentMethodType from a BTUIKCardType
///
/// @param cardType A BTUIKCardType that represents a card
/// @return The BTDropInPaymentMethodType associated with the BTUIKCardType if it can be found. Otherwise, BTDropInPaymentMethodTypeUnknown.
+ (BTDropInPaymentMethodType)paymentMethodTypeForCardType:(BTUIKCardType *)cardType;

/// Determine if the payment option is a credit card type.
///
/// @param paymentMethodType A BTDropInPaymentMethodType
/// @return true if the payment option is a credit card type, false otherwise
+ (BOOL)isPaymentMethodTypeACreditCard:(BTDropInPaymentMethodType)paymentMethodType;

/// Get a localized string for a payment option.
///
/// @param paymentMethodType BTDropInPaymentMethodType
/// @return The localized string for the BTDropInPaymentMethodType if one can be found. `Card` will be returned in the case of BTDropInPaymentMethodTypeUnknown.
+ (NSString *)nameForPaymentMethodType:(BTDropInPaymentMethodType)paymentMethodType;

#pragma mark Helper Utilities

/// Cause the device to vibrate
+ (void)vibrate;

#pragma mark Art Utilities

/// Get a BTUIKVectorArtView from a string
///
/// @param typeString string representing a payment option type (e.g `Visa` or `PayPal`)
/// @return The BTUIKVectorArtView for the string if one can be found. Otherwise the art for a generic card.
+ (BTUIKVectorArtView *)vectorArtViewForPaymentInfoType:(NSString *)typeString;

/// Get a BTUIKVectorArtView for a payment option of BTUIKVectorArtIconSizeRegular.
///
/// @param type BTDropInPaymentMethodType
/// @return The BTUIKVectorArtView for the BTDropInPaymentMethodType if one can be found. Otherwise the art for a generic card.
+ (BTUIKVectorArtView *)vectorArtViewForPaymentMethodType:(BTDropInPaymentMethodType)type;

/// Get a BTUIKVectorArtView for a payment option.
///
/// @param type BTDropInPaymentMethodType
/// @param size The BTUIKVectorArtSize (Regular or Large)
/// @return The BTUIKVectorArtView for the BTDropInPaymentMethodType if one can be found. Otherwise the art for a generic card.
+ (BTUIKVectorArtView *)vectorArtViewForPaymentMethodType:(BTDropInPaymentMethodType)type size:(BTUIKVectorArtSize)size;

/*!
 @brief Get a BTUIKVectorArtView for a visual asset.

 @param type A BTUIKVisualAssetType
 @return The BTUIKVectorArtView for the BTUIKVisualAssetType if one can be found. Otherwise an empty BTUIKVectorArtView.
*/
+ (BTUIKVectorArtView *)vectorArtViewForVisualAssetType:(BTUIKVisualAssetType)type;

#pragma mark Right to Left Utilities

/// @return true if the language is right to left
+ (BOOL)isLanguageLayoutDirectionRightToLeft;
/// @return NSTextAlignmentRight if isLanguageLayoutDirectionRightToLeft is true. Ohterwise NSTextAlignmentLeft.
+ (NSTextAlignment)naturalTextAlignment;
/// @return NSTextAlignmentLeft if isLanguageLayoutDirectionRightToLeft is true. Ohterwise NSTextAlignmentRight.
+ (NSTextAlignment)naturalTextAlignmentInverse;

#pragma mark Orientation Utilities

/// @return true if the device is in landscape
+ (BOOL)isOrientationLandscape;

/// @return height of the status bar
+ (CGFloat)statusBarHeight;

@end
