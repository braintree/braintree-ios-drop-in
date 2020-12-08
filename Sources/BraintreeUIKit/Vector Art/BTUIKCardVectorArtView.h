#ifdef COCOAPODS
#import <BraintreeDropIn/BTUIKVectorArtView.h>
#else
#import <BraintreeUIKit/BTUIKVectorArtView.h>
#endif

@interface BTUIKCardVectorArtView : BTUIKVectorArtView

@property (nonatomic, strong) UIColor *highlightColor;

@end
