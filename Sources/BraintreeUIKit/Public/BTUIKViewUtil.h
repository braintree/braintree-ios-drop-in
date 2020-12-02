#import <UIKit/UIKit.h>
#import "BTUIKCardType.h"
#import "BTUIKPaymentOptionType.h"
#import "BTUIKVisualAssetType.h"

@class BTUIKVectorArtView;

/// Size for vector art
typedef NS_ENUM(NSInteger, BTUIKVectorArtSize) {
    /// Small
    BTUIKVectorArtSizeRegular,
    /// Large
    BTUIKVectorArtSizeLarge,
};

/// @class Utilities used by other views to get localized strings, a BTUIKPaymentOptionType or artwork
@interface BTUIKViewUtil : NSObject

#pragma mark BTUIKPaymentOptionType Utilities

/// Get a BTUIKPaymentOptionType from a string
///
/// @param typeString string representing a payment option type (e.g `Visa` or `PayPal`)
/// @return The BTUIKPaymentOptionType associated with the string if it can be found. Otherwise, BTUIKPaymentOptionTypeUnknown.
+ (BTUIKPaymentOptionType)paymentOptionTypeForPaymentInfoType:(NSString *)typeString;

/// Get a BTUIKPaymentOptionType from a BTUIKCardType
///
/// @param cardType A BTUIKCardType that represents a card
/// @return The BTUIKPaymentOptionType associated with the BTUIKCardType if it can be found. Otherwise, BTUIKPaymentOptionTypeUnknown.
+ (BTUIKPaymentOptionType)paymentMethodTypeForCardType:(BTUIKCardType *)cardType;

/// Determine if the payment option is a credit card type.
///
/// @param paymentOptionType A BTUIKPaymentOptionType
/// @return true if the payment option is a credit card type, false otherwise
+ (BOOL)isPaymentOptionTypeACreditCard:(BTUIKPaymentOptionType)paymentOptionType;

/// Get a localized string for a payment option.
///
/// @param paymentMethodType BTUIKPaymentOptionType
/// @return The localized string for the BTUIKPaymentOptionType if one can be found. `Card` will be returned in the case of BTUIKPaymentOptionTypeUnknown.
+ (NSString *)nameForPaymentMethodType:(BTUIKPaymentOptionType)paymentMethodType;

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
/// @param type BTUIKPaymentOptionType
/// @return The BTUIKVectorArtView for the BTUIKPaymentOptionType if one can be found. Otherwise the art for a generic card.
+ (BTUIKVectorArtView *)vectorArtViewForPaymentOptionType:(BTUIKPaymentOptionType)type;

/// Get a BTUIKVectorArtView for a payment option.
///
/// @param type BTUIKPaymentOptionType
/// @param size The BTUIKVectorArtSize (Regular or Large)
/// @return The BTUIKVectorArtView for the BTUIKPaymentOptionType if one can be found. Otherwise the art for a generic card.
+ (BTUIKVectorArtView *)vectorArtViewForPaymentOptionType:(BTUIKPaymentOptionType)type size:(BTUIKVectorArtSize)size;

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
