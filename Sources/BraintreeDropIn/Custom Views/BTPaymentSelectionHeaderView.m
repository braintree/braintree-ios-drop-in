#import "BTPaymentSelectionHeaderView.h"
#import "BTUIKAppearance.h"

@interface BTPaymentSelectionHeaderView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

@end

@implementation BTPaymentSelectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentView.backgroundColor = UIColor.clearColor;
        self.backgroundView = [UIView new]; // needed to make background clear

        _label = [UILabel new];
        self.label.textAlignment = NSTextAlignmentNatural;
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        [BTUIKAppearance styleSystemLabelSecondary:self.label];
        [self.contentView addSubview:self.label];

        _button = [UIButton new];
        self.button.titleLabel.font = [BTUIKAppearance sharedInstance].staticBodyFont;
        self.button.translatesAutoresizingMaskIntoConstraints = NO;
        self.button.hidden = YES;
        [self.button setTitleColor:[BTUIKAppearance sharedInstance].tintColor forState:UIControlStateNormal];
        [self.button setTitleColor:[BTUIKAppearance sharedInstance].highlightedTintColor forState:UIControlStateHighlighted];
        [self.button setTitleColor:[BTUIKAppearance sharedInstance].disabledColor forState:UIControlStateDisabled];
        [self.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button];

        [self.label.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:[BTUIKAppearance horizontalFormContentPadding]].active = YES;
        [self.label.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [self.label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;

        [self.button.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-[BTUIKAppearance horizontalFormContentPadding]].active = YES;
        [self.button.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [self.button.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [self.button.widthAnchor constraintGreaterThanOrEqualToConstant:BTUIKAppearance.minimumHitArea].active = YES;
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.label.text = nil;
    self.button.titleLabel.text = nil;
    self.button.hidden = YES;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = [title uppercaseString];
}

- (void)setButtonText:(NSString *)buttonText {
    _buttonText = buttonText;
    [self.button setTitle:buttonText forState:UIControlStateNormal];
    self.button.hidden = buttonText == nil;
}

- (void)buttonPressed:(UIButton *)sender {
    if (self.delegate) {
        [self.delegate didTapButtonOnHeaderView:self];
    }
}

@end
