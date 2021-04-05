#import "BTDropInPaymentSelectionCell.h"
#import "UIColor+BTUIK.h"
#import "BTUIKAppearance.h"

@interface BTDropInPaymentSelectionCell()
@property (nonatomic, strong) UIStackView *labelContainer;
@end

@implementation BTDropInPaymentSelectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.hidden = YES;
        self.detailTextLabel.hidden = YES;
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        self.preservesSuperviewLayoutMargins = NO;

        self.labelContainer = [UIStackView new];
        self.labelContainer.axis = UILayoutConstraintAxisVertical;
        self.labelContainer.spacing = 5;
        self.labelContainer.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelContainer.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.labelContainer];

        self.label = [[UILabel alloc] init];
        [BTUIKAppearance styleLabelPrimary:self.label];
        self.label.numberOfLines = 2;
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.labelContainer addArrangedSubview:self.label];

        self.detailLabel = [[UILabel alloc] init];
        [BTUIKAppearance styleLabelSecondary:self.detailLabel];
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.labelContainer addArrangedSubview:self.detailLabel];

        self.iconView = [BTUIKPaymentOptionCardView new];
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.iconView];
        self.backgroundColor = [UIColor clearColor];

        self.bottomBorder = [UIView new];
        self.bottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
        self.bottomBorder.backgroundColor = [BTUIKAppearance sharedInstance].lineColor;
        [self.contentView addSubview:self.bottomBorder];
        UIView *backgroundView = [UIView new];
        backgroundView.backgroundColor = [[BTUIKAppearance sharedInstance].formBackgroundColor btuik_adjustedBrightness:0.8];
        self.selectedBackgroundView = backgroundView;
        self.backgroundView = nil;
        [self applyConstraints];

        self.accessibilityTraits = UIAccessibilityTraitButton;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *backgroundColor = self.iconView.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    self.iconView.backgroundColor = backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIColor *backgroundColor = self.iconView.backgroundColor;
    [super setSelected:selected animated:animated];
    self.iconView.backgroundColor = backgroundColor;
}

- (void)applyConstraints {
    [self.label removeConstraints:self.label.constraints];
    NSDictionary* viewBindings = @{@"contentView":self.contentView, @"label":self.label, @"iconView":self.iconView, @"bottomBorder":self.bottomBorder, @"detailLabel":self.detailLabel, @"labelContainer":self.labelContainer};

    [self.labelContainer.topAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.topAnchor].active = YES;
    [self.labelContainer.bottomAnchor constraintEqualToAnchor:self.contentView.layoutMarginsGuide.bottomAnchor].active = YES;

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomBorder(0.5)]|"
                                                                             options:0
                                                                             metrics:[BTUIKAppearance metrics]
                                                                               views:viewBindings]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[bottomBorder(label)]|"
                                                                             options:0
                                                                             metrics:[BTUIKAppearance metrics]
                                                                               views:viewBindings]];

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1.0f
                                                                  constant:0.0f]];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(HORIZONTAL_FORM_PADDING)-[iconView(ICON_WIDTH)]-(HORIZONTAL_FORM_PADDING)-[labelContainer]-|"
                                                                             options:0
                                                                             metrics:[BTUIKAppearance metrics]
                                                                               views:viewBindings]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[iconView(ICON_HEIGHT)]"
                                                                             options:0
                                                                             metrics:[BTUIKAppearance metrics]
                                                                               views:viewBindings]];
}

@end
