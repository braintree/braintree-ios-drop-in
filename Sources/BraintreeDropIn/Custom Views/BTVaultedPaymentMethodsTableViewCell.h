#import <UIKit/UIKit.h>
#import "BTPaymentMethodNonce+DropIn.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BTVaultedPaymentMethodsTableViewCellDelegate;

@interface BTVaultedPaymentMethodsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<BTPaymentMethodNonce *> *paymentMethodNonces;
@property (nonatomic, nullable, weak) id<BTVaultedPaymentMethodsTableViewCellDelegate> delegate;

@end

@protocol BTVaultedPaymentMethodsTableViewCellDelegate <NSObject>

- (void)vaultedPaymentMethodsTableViewCell:(BTVaultedPaymentMethodsTableViewCell *)cell didSelectNonce:(BTPaymentMethodNonce *)nonce;

@end

NS_ASSUME_NONNULL_END
