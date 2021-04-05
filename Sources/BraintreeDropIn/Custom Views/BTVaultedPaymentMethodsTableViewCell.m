#import "BTVaultedPaymentMethodsTableViewCell.h"
#import "BTUIPaymentMethodCollectionViewCell.h"
#import "BTUIKAppearance.h"
#import "BTUIKViewUtil.h"
#import "BTUIKPaymentOptionCardView.h"

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

        NSLayoutConstraint *heightConstraint = [self.collectionView.heightAnchor constraintEqualToConstant:BTUIPaymentMethodCollectionViewCell.dynamicSize.height + [BTUIKAppearance verticalFormSpace]];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;

        [NSLayoutConstraint activateConstraints:@[
            heightConstraint,
            [self.collectionView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.collectionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [self.collectionView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
            [self.collectionView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]
        ]];
    }

    return self;
}

- (void)setPaymentMethodNonces:(NSArray<BTPaymentMethodNonce *> *)paymentMethodNonces {
    _paymentMethodNonces = paymentMethodNonces;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                atScrollPosition:([BTUIKViewUtil isLanguageLayoutDirectionRightToLeft] ? UICollectionViewScrollPositionLeft : UICollectionViewScrollPositionRight)
                                        animated:NO];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.paymentMethodNonces.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTUIPaymentMethodCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTUIPaymentMethodCollectionViewCellIdentifier" forIndexPath:indexPath];
    BTPaymentMethodNonce *paymentInfo = self.paymentMethodNonces[indexPath.row];
    cell.paymentMethodNonce = paymentInfo;
    NSString *typeString = paymentInfo.type;

    cell.highlighted = NO;
    cell.descriptionLabel.text = paymentInfo.paymentDescription;
    cell.titleLabel.text = [BTUIKViewUtil nameForPaymentMethodType:[BTUIKViewUtil paymentMethodTypeForPaymentInfoType:typeString]];
    cell.paymentOptionCardView.paymentMethodType = [BTUIKViewUtil paymentMethodTypeForPaymentInfoType:typeString];

    cell.isAccessibilityElement = YES;
    cell.accessibilityLabel = [NSString stringWithFormat:@"%@ %@", typeString, paymentInfo.paymentDescription];
    cell.accessibilityTraits = UIAccessibilityTraitButton;

    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, [BTUIKAppearance horizontalFormContentPadding], 0, [BTUIKAppearance horizontalFormContentPadding]);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return SAVED_PAYMENT_METHODS_COLLECTION_SPACING;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return SAVED_PAYMENT_METHODS_COLLECTION_SPACING;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        BTPaymentMethodNonce *nonce = self.paymentMethodNonces[indexPath.row];
        [self.delegate vaultedPaymentMethodsTableViewCell:self didSelectNonce:nonce];
    }
}

@end
