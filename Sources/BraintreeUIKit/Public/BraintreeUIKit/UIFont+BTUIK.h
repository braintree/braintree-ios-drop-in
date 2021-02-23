#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (BTUIK)

+ (UIFont *)bodyFontForFontFamily:(NSString * _Nullable)fontFamily useStaticSize:(BOOL)useStaticSize;
+ (UIFont *)headlineFontForFontFamily:(NSString * _Nullable)fontFamily useStaticSize:(BOOL)useStaticSize;
+ (UIFont *)captionFontForFontFamily:(NSString * _Nullable)fontFamily useStaticSize:(BOOL)useStaticSize;
+ (UIFont *)titleFontForFontFamily:(NSString * _Nullable)fontFamily useStaticSize:(BOOL)useStaticSize;

@end

NS_ASSUME_NONNULL_END
