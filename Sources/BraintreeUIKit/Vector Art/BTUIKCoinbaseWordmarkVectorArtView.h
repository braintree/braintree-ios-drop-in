#if __has_include(<BraintreeDropIn/BraintreeUIKit.h>)
#import <BraintreeDropIn/BTUIKVectorArtView.h>
#else
#import <BraintreeUIKit/BTUIKVectorArtView.h>
#endif

@interface BTUIKCoinbaseWordmarkVectorArtView : BTUIKVectorArtView

@property (nonatomic, strong) UIColor *color;

@end