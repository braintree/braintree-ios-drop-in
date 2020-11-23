#import <BraintreeDropIn/BTPaymentSelectionViewController.h>

@interface BTPaymentSelectionViewController

// Exposed internally for testing
@property (nonatomic, strong) NSArray<BTUIKPaymentOptionType> *paymentOptionsData;

@end
