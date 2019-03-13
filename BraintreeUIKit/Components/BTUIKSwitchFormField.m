#import "BTUIKSwitchFormField.h"
#import "BTUIKViewUtil.h"
#import "BTUIKAppearance.h"

@implementation BTUIKSwitchFormField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [BTUIKAppearance sharedInstance].formFieldBackgroundColor;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _switchControl = [[UISwitch alloc] init];
        [self addSubView:_switchControl];
        
        _formLabel = [[UILabel alloc] init];
        [BTUIKAppearance styleLabelBoldPrimary:_formLabel];
        _formLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _formLabel.text = @"Hi";
        [self addSubview:_formLabel];
        
        [self.formLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.formLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        self.opaque = NO;
        
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (self.layoutConstraints != nil) {
        [self removeConstraints:self.layoutConstraints];
    }
    self.layoutConstraints = [NSMutableArray array];
    
    NSMutableDictionary* viewBindings = [@{@"view":self, @"switchControl":self.switchControl, @"formLabel": self.formLabel} mutableCopy];
    
    NSDictionary* metrics = @{@"PADDING":@15};
    
    BOOL hasFormLabel = (self.formLabel.text.length > 0);
    
    [self.layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[switchControl]|"
                                                                                        options:0
                                                                                        metrics:metrics
                                                                                          views:viewBindings]];
    
    [self.layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[formLabel]|"
                                                                                        options:0
                                                                                        metrics:metrics
                                                                                          views:viewBindings]];
    if (hasFormLabel) {
        [self.layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(PADDING)-[formLabel(<=0@1)]-[switchControl]"
                                                                                            options:0
                                                                                            metrics:metrics
                                                                                              views:viewBindings]];
    } else {
        [self.layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(PADDING)-[switchControl]"
                                                                                            options:0
                                                                                            metrics:metrics
                                                                                              views:viewBindings]];
    }
    
    [self.layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[switchControl]-(PADDING)-|"
                                                                                            options:0
                                                                                            metrics:metrics
                                                                                            views:viewBindings]];
    
    NSArray *contraintsToAdd = [self.layoutConstraints copy];

    [self addConstraints:contraintsToAdd];

    NSTextAlignment newAlignment = hasFormLabel ? [BTUIKViewUtil naturalTextAlignmentInverse] : [BTUIKViewUtil naturalTextAlignment];
    if (newAlignment != self.switchControl.textAlignment) {
        self.switchControl.textAlignment = newAlignment;
    }

    [super updateConstraints];
}

@end
