#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BTPaymentSelectionHeaderViewDelegate;

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
/// Header view displayed in the payment selection table view when there are multiple sections,
/// specifically, "RECENT" for vaulted payment methods and "OTHER" for options to add new payment method.
@interface BTPaymentSelectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, nullable, copy) NSString *title;
@property (nonatomic, nullable, copy) NSString *buttonText;
@property (nonatomic, nullable, weak) id<BTPaymentSelectionHeaderViewDelegate> delegate;

@end

@protocol BTPaymentSelectionHeaderViewDelegate <NSObject>

- (void)didTapButtonOnHeaderView:(BTPaymentSelectionHeaderView *)headerView;

@end

NS_ASSUME_NONNULL_END
