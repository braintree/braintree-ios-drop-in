#import <UIKit/UIKit.h>
#import "BTPaymentMethodNonce+DropIn.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTVaultedPaymentMethodsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray<BTPaymentMethodNonce *> *paymentMethodNonces;

@end

NS_ASSUME_NONNULL_END
