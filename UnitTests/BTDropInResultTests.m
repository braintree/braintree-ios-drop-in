#import <XCTest/XCTest.h>
#import "BTDropInResult.h"

@interface BTDropInResultTests : XCTestCase

@end

@implementation BTDropInResultTests

- (void)testFetchDropInResultForAuthorization {
    XCTestExpectation *expectation = [self expectationWithDescription:@"High Expectations"];
    NSURL *clientTokenURL = [NSURL URLWithString:@"https://braintree-sample-merchant.herokuapp.com/client_token"];
    NSMutableURLRequest *clientTokenRequest = [NSMutableURLRequest requestWithURL:clientTokenURL];
    [clientTokenRequest setValue:@"text/plain" forHTTPHeaderField:@"Accept"];

    [[[NSURLSession sharedSession] dataTaskWithRequest:clientTokenRequest completionHandler:^(NSData * _Nullable data, __unused NSURLResponse * _Nullable response, __unused NSError * _Nullable error) {
        NSString *clientToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        [BTDropInResult fetchDropInResultForAuthorization:clientToken handler:^(BTDropInResult * _Nullable result, NSError * _Nullable error) {
            XCTAssertNil(error);
            XCTAssertNotNil(result);
            [expectation fulfill];
        }];
    }] resume];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
