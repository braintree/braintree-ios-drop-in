#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(13.0)) @interface BTUIKColor : NSObject

@property (class, nonatomic, readonly) UIColor *dynamicBarBackgroundColor;
@property (class, nonatomic, readonly) UIColor *dynamicFormBackgroundColor;
@property (class, nonatomic, readonly) UIColor *dynamicFormFieldBackgroundColor;
@property (class, nonatomic, readonly) UIColor *dynamicPrimaryTextColor;
@property (class, nonatomic, readonly) UIColor *dynamicSecondaryTextColor;
@property (class, nonatomic, readonly) UIColor *dynamicPlaceholderTextColor;
@property (class, nonatomic, readonly) UIColor *dynamicLineColor;

@end

NS_ASSUME_NONNULL_END
