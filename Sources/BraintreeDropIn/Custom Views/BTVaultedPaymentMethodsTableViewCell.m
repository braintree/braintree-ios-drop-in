#import "BTVaultedPaymentMethodsTableViewCell.h"
#import "BTUIPaymentMethodCollectionViewCell.h"

#ifdef COCOAPODS
#import <Braintree/BraintreeUIKit.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

#define SAVED_PAYMENT_METHODS_COLLECTION_SPACING 6

@interface BTVaultedPaymentMethodsTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation BTVaultedPaymentMethodsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = BTUIPaymentMethodCollectionViewCell.dynamicSize;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.showsHorizontalScrollIndicator = NO;

        [self.collectionView registerClass:[BTUIPaymentMethodCollectionViewCell class] forCellWithReuseIdentifier:@"BTUIPaymentMethodCollectionViewCellIdentifier"];

        [self.contentView addSubview:self.collectionView];

        [self.collectionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;

        NSLayoutConstraint *heightConstraint = [self.collectionView.heightAnchor constraintEqualToConstant:BTUIPaymentMethodCollectionViewCell.dynamicSize.height];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        heightConstraint.active = YES;

    }

    return self;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(__unused UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(__unused UICollectionView *)collectionView numberOfItemsInSection:(__unused NSInteger)section {
    return [self.paymentMethodNonces count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTUIPaymentMethodCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTUIPaymentMethodCollectionViewCellIdentifier" forIndexPath:indexPath];
    BTPaymentMethodNonce *paymentInfo = self.paymentMethodNonces[indexPath.row];
    cell.paymentMethodNonce = paymentInfo;
    NSString *typeString = paymentInfo.type;

    cell.highlighted = NO;
    cell.descriptionLabel.text = paymentInfo.paymentDescription;
    cell.titleLabel.text = [BTUIKViewUtil nameForPaymentMethodType:[BTUIKViewUtil paymentOptionTypeForPaymentInfoType:typeString]];
    cell.paymentOptionCardView.paymentOptionType = [BTUIKViewUtil paymentOptionTypeForPaymentInfoType:typeString];

    cell.isAccessibilityElement = YES;
    cell.accessibilityLabel = [NSString stringWithFormat:@"%@-%@", typeString, paymentInfo.paymentDescription];

    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(__unused UICollectionView*)collectionView layout:(__unused UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(__unused NSInteger)section {
    return UIEdgeInsetsMake(0, [BTUIKAppearance horizontalFormContentPadding], 0, [BTUIKAppearance horizontalFormContentPadding]);
}

- (CGFloat)collectionView:(__unused UICollectionView *)collectionView layout:(__unused UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(__unused NSInteger)section {
    return SAVED_PAYMENT_METHODS_COLLECTION_SPACING;
}

- (CGFloat)collectionView:(__unused UICollectionView *)collectionView layout:(__unused UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(__unused NSInteger)section {
    return SAVED_PAYMENT_METHODS_COLLECTION_SPACING;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(__unused UICollectionView *)collectionView didSelectItemAtIndexPath:(__unused NSIndexPath *)indexPath {
    // TODO: - implement
//    BTUIPaymentMethodCollectionViewCell *cell = (BTUIPaymentMethodCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    if (self.delegate) {
//        [self.delegate selectionCompletedWithPaymentMethodType:[BTUIKViewUtil paymentOptionTypeForPaymentInfoType:cell.paymentMethodNonce.type]
//                                                         nonce:cell.paymentMethodNonce
//                                                         error:nil];
//
//        if ([cell.paymentMethodNonce isKindOfClass:[BTCardNonce class]]) {
//            [self.apiClient sendAnalyticsEvent:@"ios.dropin2.vaulted-card.select"];
//        }
//    }
}


@end
