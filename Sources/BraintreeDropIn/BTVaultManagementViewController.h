#import <BraintreeDropIn/BTDropInController.h>
#import "BTDropInBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class BTPaymentMethodNonce;
@protocol BTDropInControllerDelegate;

__attribute__((deprecated("BraintreeDropIn is deprecated. Use the Braintre SDK instead. See https://developer.paypal.com/braintree/docs/guides/client-sdk/setup/ for more information.")))
/// Contains form elements for editing vaulted payment methods.
@interface BTVaultManagementViewController : BTDropInBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<BTDropInControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
