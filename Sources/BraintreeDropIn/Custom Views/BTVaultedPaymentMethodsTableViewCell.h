#import <UIKit/UIKit.h>
#import "BTPaymentMethodNonce+DropIn.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BTVaultedPaymentMethodsTableViewCellDelegate;

/// Table view cell that displays vaulted payment methods on the payment method selection sheet.
/// This cell contains a horizontally scrolling collection view.
@interface BTVaultedPaymentMethodsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<BTPaymentMethodNonce *> *paymentMethodNonces;
@property (nonatomic, nullable, weak) id<BTVaultedPaymentMethodsTableViewCellDelegate> delegate;

@end

@protocol BTVaultedPaymentMethodsTableViewCellDelegate <NSObject>

- (void)vaultedPaymentMethodsTableViewCell:(BTVaultedPaymentMethodsTableViewCell *)cell didSelectNonce:(BTPaymentMethodNonce *)nonce;

@end

NS_ASSUME_NONNULL_END
