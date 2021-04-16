#import "BTUIKAppearance.h"
#import "BTUIKCardListLabel.h"
#import "BTUIKPaymentOptionCardView.h"
#import "BTUIKViewUtil.h"

#import <QuartzCore/QuartzCore.h>

@interface BTUIKCardListLabel ()

@property (nonatomic, strong) NSArray *availablePaymentOptionAttachments;
@property (nonatomic) BTDropInPaymentMethodType emphasisedPaymentOption;

@end

@implementation BTUIKCardListLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;

        self.emphasisedPaymentOption = BTDropInPaymentMethodTypeUnknown;
        self.availablePaymentOptionAttachments = @[];

        self.availablePaymentOptions = @[];

        self.accessibilityTraits = UIAccessibilityTraitImage;
    }
    return self;
}

- (UIImage *) imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return img;
}

- (void)setAvailablePaymentOptions:(NSArray *)availablePaymentOptions {
    _availablePaymentOptions = [NSOrderedSet orderedSetWithArray:availablePaymentOptions].array;
    if ([BTUIKViewUtil isLanguageLayoutDirectionRightToLeft]) {
        _availablePaymentOptions = [[_availablePaymentOptions reverseObjectEnumerator] allObjects];
    }
    [self updateAppearance];
    [self emphasizePaymentOption:self.emphasisedPaymentOption];
}

- (void)updateAppearance {
    NSMutableAttributedString *at = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableArray *attachments = [NSMutableArray new];
    NSString *accessibilityLabel = [NSString stringWithFormat:@"%@: ", BTDropInLocalizedString(CARD_ICONS_LABEL)];
    BTUIKPaymentOptionCardView *cardIconView = [BTUIKPaymentOptionCardView new];
    cardIconView.frame = CGRectMake(0, 0, [BTUIKAppearance smallIconWidth], [BTUIKAppearance smallIconHeight]);
    cardIconView.borderColor = UIColor.systemGrayColor;

    for (NSUInteger i = 0; i < self.availablePaymentOptions.count; i++) {
        NSTextAttachment *composeAttachment = [NSTextAttachment new];
        BTDropInPaymentMethodType paymentOption = ((NSNumber*)self.availablePaymentOptions[i]).intValue;
        accessibilityLabel = [@[accessibilityLabel, [BTUIKViewUtil nameForPaymentMethodType:paymentOption]] componentsJoinedByString:@","];
        
        cardIconView.paymentMethodType = paymentOption;
        [cardIconView setNeedsLayout];
        [cardIconView layoutIfNeeded];
        UIImage *composeImage = [self imageWithView:cardIconView];
        [attachments addObject:composeAttachment];
        composeAttachment.image = composeImage;
        [at appendAttributedString:[NSAttributedString attributedStringWithAttachment:composeAttachment]];
        [at appendAttributedString:[[NSMutableAttributedString alloc]
                                    initWithString: i < self.availablePaymentOptions.count - 1? @" " : @""]];
    }
    self.attributedText = at;
    self.accessibilityLabel = accessibilityLabel;
    self.availablePaymentOptionAttachments = attachments;
}

- (void)emphasizePaymentOption:(BTDropInPaymentMethodType)paymentOption {
    if (paymentOption == self.emphasisedPaymentOption) {
        return;
    }

    [self updateAppearance];
    for (NSUInteger i = 0; i < self.availablePaymentOptions.count; i++) {
        BTDropInPaymentMethodType option = ((NSNumber*)self.availablePaymentOptions[i]).intValue;
        float newAlpha = (paymentOption == option || paymentOption == BTDropInPaymentMethodTypeUnknown) ? 1.0 : 0.25;
        NSTextAttachment *attachment = self.availablePaymentOptionAttachments[i];
        UIGraphicsBeginImageContextWithOptions(attachment.image.size, NO, attachment.image.scale);
        [attachment.image drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:newAlpha];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        attachment.image = image;
    }
    self.emphasisedPaymentOption = paymentOption;
    [self setNeedsDisplay];
}

@end
