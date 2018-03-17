#import "BTDropInBaseViewController.h"
#import "BTDropInController.h"
#if __has_include("BraintreeUIKit.h")
#import "BraintreeUIKit.h"
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class BTPaymentMethodNonce;
@protocol BTVaultManagementViewControllerDelegate, BTDropInControllerDelegate;

/// Contains form elements for editing vaulted payment methods.
@interface BTVaultManagementViewController : BTDropInBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<BTVaultManagementViewControllerDelegate, BTDropInControllerDelegate> delegate;

@end

@protocol BTVaultManagementViewControllerDelegate <NSObject>

/// Called when a payment method action is selected
///
/// @param nonce The BTPaymentMethodNonce of the selected payment method.
/// @param action The manager action.
/// @param completion The callback required to update the UI after the action has been executed.
- (void) paymentMethodSelected:(BTPaymentMethodNonce *)nonce action:(BTPaymentManagerAction)action completion:(BTPaymentManagerActionHandler)completion;

@end

NS_ASSUME_NONNULL_END
