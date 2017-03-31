#import <XCTest/XCTest.h>
#import "BTDropInBaseViewController.h"

@interface BTDropInBaseViewControllerTests : XCTestCase

@end

@implementation BTDropInBaseViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_prefersStatusBarHidden_returnsTrue {
    BTDropInBaseViewController *viewController = [[BTDropInBaseViewController alloc] init];
    XCTAssertFalse(viewController.prefersStatusBarHidden);
}

@end
