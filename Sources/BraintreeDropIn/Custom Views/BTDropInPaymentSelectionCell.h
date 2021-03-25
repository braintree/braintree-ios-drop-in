#import <UIKit/UIKit.h>
#import "BTUIKPaymentOptionCardView.h"
#import <BraintreeDropIn/BTUIKPaymentOptionType.h>

@interface BTDropInPaymentSelectionCell : UITableViewCell

@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) BTUIKPaymentOptionCardView* iconView;
@property (nonatomic, strong) UIView *bottomBorder;
@property (nonatomic) BTUIKPaymentOptionType type;

@end
