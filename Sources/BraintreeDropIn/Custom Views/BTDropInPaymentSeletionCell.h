#import <UIKit/UIKit.h>

#ifdef COCOAPODS
#import <BraintreeDropIn/BraintreeUIKit.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

@interface BTDropInPaymentSeletionCell : UITableViewCell

@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) BTUIKPaymentOptionCardView* iconView;
@property (nonatomic, strong) UIView *bottomBorder;
@property (nonatomic) BTUIKPaymentOptionType type;

@end
