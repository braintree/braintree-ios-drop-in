#import "BTUIPaymentMethodCollectionViewCell.h"

#ifdef COCOAPODS
#import <BraintreeDropIn/BraintreeUIKit.h>
#else
#import <BraintreeUIKit/BraintreeUIKit.h>
#endif

#define LARGE_ICON_INNER_PADDING 10.0
#define LARGE_ICON_CORNER_RADIUS 20.0

@implementation BTUIPaymentMethodCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;

        self.paymentOptionCardView = [[BTUIKPaymentOptionCardView alloc] init];
        self.paymentOptionCardView.translatesAutoresizingMaskIntoConstraints = NO;
        self.paymentOptionCardView.innerPadding = LARGE_ICON_INNER_PADDING;
        self.paymentOptionCardView.vectorArtSize = BTUIKVectorArtSizeLarge;
        self.paymentOptionCardView.cornerRadius = LARGE_ICON_CORNER_RADIUS;
        self.paymentOptionCardView.borderColor = [UIColor whiteColor];
        
        self.paymentOptionCardView.layer.masksToBounds = NO;
        self.paymentOptionCardView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.paymentOptionCardView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.paymentOptionCardView.layer.shadowOpacity = 0.12f;
        self.paymentOptionCardView.layer.shadowRadius = 5.0f;
        
        [self.contentView addSubview:self.paymentOptionCardView];

        self.titleLabel = [[UILabel alloc] init];
        [BTUIKAppearance styleSmallLabelPrimary:self.titleLabel];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];
        
        self.descriptionLabel = [[UILabel alloc] init];
        [BTUIKAppearance styleLabelSecondary:self.descriptionLabel];
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.descriptionLabel.text = @"";
        self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.descriptionLabel];

        NSLayoutConstraint *widthConstraint = [self.widthAnchor constraintEqualToConstant:[BTUIKAppearance largeIconWidth] + 5];
        widthConstraint.priority = UILayoutPriorityDefaultHigh;
        widthConstraint.active = YES;

        [self.contentView.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [self.contentView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [self.contentView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;

        [self.paymentOptionCardView.widthAnchor constraintEqualToConstant:[BTUIKAppearance largeIconWidth]].active = YES;
        [self.paymentOptionCardView.heightAnchor constraintEqualToConstant:[BTUIKAppearance largeIconHeight]].active = YES;
        [self.paymentOptionCardView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
        [self.paymentOptionCardView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;

        [self.titleLabel.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.paymentOptionCardView.bottomAnchor
                                                  constant:[BTUIKAppearance horizontalFormContentPadding]].active = YES;

        [self.descriptionLabel.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor].active = YES;
        [self.descriptionLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
        [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor].active = YES;
        [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;

        NSLayoutConstraint *heightConstraint = [self.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor];
        heightConstraint.priority = UILayoutPriorityDefaultHigh;
        heightConstraint.active = YES;
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    self.alpha = highlighted ? 0.5 : 1.0;
}

@end
