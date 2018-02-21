#import "BTUIKExpiryInputCollectionViewCell.h"
#import "BTUIKAppearance.h"

@implementation BTUIKExpiryInputCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.backgroundColor = [BTUIKAppearance sharedInstance].formFieldBackgroundColor;
        self.label.font = [UIFont fontWithName:[BTUIKAppearance sharedInstance].fontFamily size:24];
        self.label.textColor = [BTUIKAppearance sharedInstance].primaryTextColor;
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        
        UIView* bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.layer.cornerRadius = 4;
        self.selectedBackgroundView = bgView;
        self.selectedBackgroundView.backgroundColor = [[BTUIKAppearance sharedInstance].primaryTextColor colorWithAlphaComponent:0.1];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label]|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"label":self.label}]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:@{@"label":self.label}]];
        
    }
    return self;
}

- (NSInteger)getInteger {
    return [self.label.text integerValue];
}

@end
