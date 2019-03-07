#import "BTUIKHiperVectorArtView.h"

@implementation BTUIKHiperVectorArtView

- (void)drawArt {
    //// Color Declarations
    UIColor *fillColor1 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor *fillColor2 = [UIColor colorWithRed: 1 green: 0.91 blue: 0.059 alpha: 1];

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0.894, .424, .165, 1);
    CGContextFillRect(ctx, CGRectMake(0, 0, self.artDimensions.width, self.artDimensions.height));

    UIBezierPath *bezierPath1 = [UIBezierPath bezierPath];
    [bezierPath1 moveToPoint: CGPointMake(8.81, 9.3)];
    [bezierPath1 addLineToPoint: CGPointMake(8.81, 18.2)];
    [bezierPath1 addLineToPoint: CGPointMake(10.75, 18.2)];
    [bezierPath1 addLineToPoint: CGPointMake(10.75, 14.47)];
    [bezierPath1 addLineToPoint: CGPointMake(13.93, 14.47)];
    [bezierPath1 addLineToPoint: CGPointMake(13.93, 18.2)];
    [bezierPath1 addLineToPoint: CGPointMake(15.86, 18.2)];
    [bezierPath1 addLineToPoint: CGPointMake(15.86, 9.3)];
    [bezierPath1 addLineToPoint: CGPointMake(13.93, 9.3)];
    [bezierPath1 addLineToPoint: CGPointMake(13.93, 12.72)];
    [bezierPath1 addLineToPoint: CGPointMake(10.75, 12.72)];
    [bezierPath1 addLineToPoint: CGPointMake(10.75, 9.3)];
    [bezierPath1 addLineToPoint: CGPointMake(8.81, 9.3)];
    [bezierPath1 closePath];
    bezierPath1.usesEvenOddFillRule = YES;
    [fillColor1 setFill];
    [bezierPath1 fill];

    UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
    [bezierPath2 moveToPoint: CGPointMake(32.57, 15.61)];
    [bezierPath2 addCurveToPoint: CGPointMake(32.64, 14.82) controlPoint1: CGPointMake(32.6, 15.47) controlPoint2: CGPointMake(32.64, 15.16)];
    [bezierPath2 addCurveToPoint: CGPointMake(29.87, 11.6) controlPoint1: CGPointMake(32.64, 13.22) controlPoint2: CGPointMake(31.87, 11.6)];
    [bezierPath2 addCurveToPoint: CGPointMake(26.73, 15.04) controlPoint1: CGPointMake(27.71, 11.6) controlPoint2: CGPointMake(26.73, 13.41)];
    [bezierPath2 addCurveToPoint: CGPointMake(30.05, 18.33) controlPoint1: CGPointMake(26.73, 17.06) controlPoint2: CGPointMake(27.94, 18.33)];
    [bezierPath2 addCurveToPoint: CGPointMake(32.29, 17.93) controlPoint1: CGPointMake(30.88, 18.33) controlPoint2: CGPointMake(31.66, 18.2)];
    [bezierPath2 addLineToPoint: CGPointMake(32.04, 16.57)];
    [bezierPath2 addCurveToPoint: CGPointMake(30.33, 16.84) controlPoint1: CGPointMake(31.52, 16.75) controlPoint2: CGPointMake(30.99, 16.84)];
    [bezierPath2 addCurveToPoint: CGPointMake(28.57, 15.61) controlPoint1: CGPointMake(29.42, 16.84) controlPoint2: CGPointMake(28.64, 16.44)];
    [bezierPath2 addLineToPoint: CGPointMake(32.57, 15.61)];
    [bezierPath2 closePath];
    [bezierPath2 moveToPoint: CGPointMake(28.56, 14.24)];
    [bezierPath2 addCurveToPoint: CGPointMake(29.75, 12.93) controlPoint1: CGPointMake(28.61, 13.7) controlPoint2: CGPointMake(28.94, 12.93)];
    [bezierPath2 addCurveToPoint: CGPointMake(30.85, 14.24) controlPoint1: CGPointMake(30.64, 12.93) controlPoint2: CGPointMake(30.85, 13.75)];
    [bezierPath2 addLineToPoint: CGPointMake(28.56, 14.24)];
    [bezierPath2 closePath];
    bezierPath2.usesEvenOddFillRule = YES;
    [fillColor1 setFill];
    [bezierPath2 fill];

    UIBezierPath *bezierPath3 = [UIBezierPath bezierPath];
    [bezierPath3 moveToPoint: CGPointMake(33.25, 18.2)];
    [bezierPath3 addLineToPoint: CGPointMake(35.18, 18.2)];
    [bezierPath3 addLineToPoint: CGPointMake(35.18, 14.92)];
    [bezierPath3 addCurveToPoint: CGPointMake(35.22, 14.47) controlPoint1: CGPointMake(35.18, 14.77) controlPoint2: CGPointMake(35.2, 14.61)];
    [bezierPath3 addCurveToPoint: CGPointMake(36.54, 13.46) controlPoint1: CGPointMake(35.35, 13.85) controlPoint2: CGPointMake(35.83, 13.46)];
    [bezierPath3 addCurveToPoint: CGPointMake(37.06, 13.51) controlPoint1: CGPointMake(36.76, 13.46) controlPoint2: CGPointMake(36.92, 13.48)];
    [bezierPath3 addLineToPoint: CGPointMake(37.06, 11.62)];
    [bezierPath3 addCurveToPoint: CGPointMake(36.66, 11.6) controlPoint1: CGPointMake(36.92, 11.6) controlPoint2: CGPointMake(36.83, 11.6)];
    [bezierPath3 addCurveToPoint: CGPointMake(34.98, 12.93) controlPoint1: CGPointMake(36.06, 11.6) controlPoint2: CGPointMake(35.3, 11.99)];
    [bezierPath3 addLineToPoint: CGPointMake(34.93, 12.93)];
    [bezierPath3 addLineToPoint: CGPointMake(34.87, 11.74)];
    [bezierPath3 addLineToPoint: CGPointMake(33.2, 11.74)];
    [bezierPath3 addCurveToPoint: CGPointMake(33.25, 13.87) controlPoint1: CGPointMake(33.23, 12.3) controlPoint2: CGPointMake(33.25, 12.92)];
    [bezierPath3 addLineToPoint: CGPointMake(33.25, 18.2)];
    [bezierPath3 closePath];
    bezierPath3.usesEvenOddFillRule = YES;
    [fillColor1 setFill];
    [bezierPath3 fill];

    UIBezierPath *bezierPath4 = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(16.6, 8.94, 2.2, 2.2)];
    [fillColor2 setFill];
    [bezierPath4 fill];

    UIBezierPath *bezierPath5 = [UIBezierPath bezierPath];
    [bezierPath5 moveToPoint: CGPointMake(21.9, 16.69)];
    [bezierPath5 addLineToPoint: CGPointMake(22.87, 16.69)];
    [bezierPath5 addCurveToPoint: CGPointMake(24.28, 15.37) controlPoint1: CGPointMake(23.84, 16.69) controlPoint2: CGPointMake(24.28, 16.05)];
    [bezierPath5 addCurveToPoint: CGPointMake(23.03, 13.17) controlPoint1: CGPointMake(24.28, 14.7) controlPoint2: CGPointMake(24.23, 13.17)];
    [bezierPath5 addCurveToPoint: CGPointMake(21.88, 16.06) controlPoint1: CGPointMake(21.65, 13.17) controlPoint2: CGPointMake(21.88, 15.06)];
    [bezierPath5 addCurveToPoint: CGPointMake(21.9, 16.69) controlPoint1: CGPointMake(21.88, 16.27) controlPoint2: CGPointMake(21.9, 16.48)];
    [bezierPath5 closePath];
    [bezierPath5 moveToPoint: CGPointMake(16.83, 11.73)];
    [bezierPath5 addLineToPoint: CGPointMake(18.82, 11.73)];
    [bezierPath5 addLineToPoint: CGPointMake(18.82, 15.37)];
    [bezierPath5 addCurveToPoint: CGPointMake(19.97, 16.69) controlPoint1: CGPointMake(18.82, 16.05) controlPoint2: CGPointMake(19.18, 16.69)];
    [bezierPath5 addCurveToPoint: CGPointMake(19.92, 11.73) controlPoint1: CGPointMake(19.98, 15.06) controlPoint2: CGPointMake(19.97, 13.37)];
    [bezierPath5 addLineToPoint: CGPointMake(21.58, 11.73)];
    [bezierPath5 addCurveToPoint: CGPointMake(21.68, 12.68) controlPoint1: CGPointMake(21.61, 12.05) controlPoint2: CGPointMake(21.65, 12.36)];
    [bezierPath5 addCurveToPoint: CGPointMake(25.76, 12.79) controlPoint1: CGPointMake(22.46, 11.05) controlPoint2: CGPointMake(24.93, 11.41)];
    [bezierPath5 addCurveToPoint: CGPointMake(22.87, 18.27) controlPoint1: CGPointMake(26.62, 14.21) controlPoint2: CGPointMake(26.91, 18.27)];
    [bezierPath5 addLineToPoint: CGPointMake(21.93, 18.27)];
    [bezierPath5 addCurveToPoint: CGPointMake(21.94, 20.75) controlPoint1: CGPointMake(21.94, 19.1) controlPoint2: CGPointMake(21.94, 19.92)];
    [bezierPath5 addLineToPoint: CGPointMake(19.96, 20.75)];
    [bezierPath5 addCurveToPoint: CGPointMake(19.97, 18.27) controlPoint1: CGPointMake(19.96, 19.96) controlPoint2: CGPointMake(19.96, 19.13)];
    [bezierPath5 addCurveToPoint: CGPointMake(16.83, 15.37) controlPoint1: CGPointMake(17.82, 18.26) controlPoint2: CGPointMake(16.83, 16.85)];
    [bezierPath5 addLineToPoint: CGPointMake(16.83, 11.73)];
    [bezierPath5 closePath];
    bezierPath5.usesEvenOddFillRule = YES;
    [fillColor1 setFill];
    [bezierPath5 fill];
}

@end
