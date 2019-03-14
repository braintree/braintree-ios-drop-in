#import "BTUIKSwitchFormField.h"
#import "BTUIKViewUtil.h"
#import "BTUIKAppearance.h"

@interface BTUIKSwitchFormField ()

@property (nonatomic, strong) NSMutableArray *layoutConstraints;

@end

@implementation BTUIKSwitchFormField


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = UIColor.clearColor;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _switchControl = [[UISwitch alloc] init];
        _switchControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_switchControl];
        
        _formLabel = [[UILabel alloc] init];
        [BTUIKAppearance styleLabelBoldPrimary:_formLabel];
        _formLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_formLabel];
        
        [_formLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_formLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints {
    if (self.layoutConstraints != nil) {
        [self removeConstraints:self.layoutConstraints];
    }
    self.layoutConstraints = [NSMutableArray array];
    
    NSMutableDictionary *viewBindings = [@{@"view":self, @"switchControl":self.switchControl, @"formLabel": self.formLabel} mutableCopy];
    
    NSDictionary *metrics = @{@"PADDING":@15};
    
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
        [self.layoutConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[formLabel(<=0@1)]-(PADDING)-[switchControl]"
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

    [super updateConstraints];
}

@end
