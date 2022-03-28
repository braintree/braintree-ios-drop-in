#import "BTPaymentSelectionPresentationController.h"

@implementation BTPaymentSelectionPresentationController

- (CGRect)frameOfPresentedViewInContainerView {
    UINavigationController *nav = (UINavigationController *)self.presentedViewController;

    CGFloat targetHeight = [nav.topViewController.view systemLayoutSizeFittingSize:self.containerView.frame.size].height;

    return CGRectMake(0,
                      self.containerView.frame.size.height - targetHeight,
                      self.containerView.frame.size.width,
                      targetHeight);
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    self.presentedView.layer.masksToBounds = YES;
    self.presentedView.layer.cornerRadius = 10;
    [UIView animateWithDuration:0.5 animations:^{
        self.presentedView.frame = self.frameOfPresentedViewInContainerView;
    }];
}

@end
