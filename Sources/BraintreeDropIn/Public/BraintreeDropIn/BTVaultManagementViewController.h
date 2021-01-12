#import <BraintreeDropIn/BTDropInBaseViewController.h>
#import <BraintreeDropIn/BTDropInController.h>
#if __has_include(<BraintreeDropIn/BraintreeUIKit.h>)
#import <BraintreeDropIn/BraintreeUIKit.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class BTPaymentMethodNonce;
@protocol BTDropInControllerDelegate;

/// Contains form elements for editing vaulted payment methods.
@interface BTVaultManagementViewController : BTDropInBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<BTDropInControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
