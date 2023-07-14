#import <UIKit/UIKit.h>

@class BTPaymentMethodNonce;
@class BTUIKPaymentOptionCardView;

@interface BTUIPaymentMethodCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) BTUIKPaymentOptionCardView* paymentOptionCardView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* descriptionLabel;
@property (nonatomic, strong) BTPaymentMethodNonce* paymentMethodNonce;

+ (CGSize)dynamicSize;

@end
