#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTUIKSwitchFormField : UIView

- (instancetype)initWithTitle:(NSString *)title;

/// The switch
@property (nonatomic, strong) UISwitch *switchControl;

@end

NS_ASSUME_NONNULL_END
