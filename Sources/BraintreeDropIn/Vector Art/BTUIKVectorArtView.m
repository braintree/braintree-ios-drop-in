#import "BTUIKVectorArtView.h"

@import QuartzCore;

@implementation BTUIKVectorArtView

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGFloat scaleFactor = MIN(rect.size.width/self.artDimensions.width, rect.size.height/self.artDimensions.height);
    CGContextScaleCTM(ctx, scaleFactor, scaleFactor);
    CGContextTranslateCTM(ctx, rect.origin.x, rect.origin.y);

    [self drawArt];

    CGContextRestoreGState(ctx);
}

- (void)drawArt {
    // Subclass overrides this
}

@end
