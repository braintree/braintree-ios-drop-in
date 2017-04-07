#import <XCTest/XCTest.h>
#import "BTDropInBaseViewController.h"

@interface BTDropInBaseViewControllerTests : XCTestCase

@end

@implementation BTDropInBaseViewControllerTests

- (void)testPrefersStatusBarHidden_returnsTrue {
    BTDropInBaseViewController *viewController = [[BTDropInBaseViewController alloc] init];
    XCTAssertTrue(viewController.prefersStatusBarHidden);
}

- (void)testPreferredStatusBarUpdateAnimation_returnsUIStatusBarAnimationSlide {
    BTDropInBaseViewController *viewController = [[BTDropInBaseViewController alloc] init];
    XCTAssertEqual(UIStatusBarAnimationSlide, viewController.preferredStatusBarUpdateAnimation);
}

@end
