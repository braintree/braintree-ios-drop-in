#import <UIKit/UIKit.h>
#import "BTUIKPaymentOptionCardView.h"
#import <BraintreeDropIn/BTDropInPaymentMethodType.h>

@interface BTDropInPaymentSelectionCell : UITableViewCell

@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) BTUIKPaymentOptionCardView* iconView;
@property (nonatomic, strong) UIView *bottomBorder;
@property (nonatomic) BTDropInPaymentMethodType type;

@end
