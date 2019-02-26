#import "BTUIKLargeHiperVectorArtView.h"

@implementation BTUIKLargeHiperVectorArtView

- (void)drawArt {
    UIColor *fillColor = [UIColor colorWithRed: 0.894 green: 0.424 blue: 0.165 alpha: 1];
    UIColor *fillColor2 = [UIColor colorWithRed: 1 green: 1 blue: 0.996 alpha: 1];
    UIColor *fillColor3 = [UIColor colorWithRed: 1 green: 0.91 blue: 0.059 alpha: 1];

    UIBezierPath *bezierPath1 = [UIBezierPath bezierPathWithRect: CGRectMake(7, 19, 66, 43)];
    [fillColor setFill];
    [bezierPath1 fill];

    UIBezierPath *bezierPath2 = [UIBezierPath bezierPath];
    [bezierPath2 moveToPoint: CGPointMake(19.81, 32.48)];
    [bezierPath2 addLineToPoint: CGPointMake(19.81, 45.9)];
    [bezierPath2 addLineToPoint: CGPointMake(22.64, 45.9)];
    [bezierPath2 addLineToPoint: CGPointMake(22.64, 40.29)];
    [bezierPath2 addLineToPoint: CGPointMake(27.29, 40.29)];
    [bezierPath2 addLineToPoint: CGPointMake(27.29, 45.9)];
    [bezierPath2 addLineToPoint: CGPointMake(30.11, 45.9)];
    [bezierPath2 addLineToPoint: CGPointMake(30.11, 32.48)];
    [bezierPath2 addLineToPoint: CGPointMake(27.29, 32.48)];
    [bezierPath2 addLineToPoint: CGPointMake(27.29, 37.64)];
    [bezierPath2 addLineToPoint: CGPointMake(22.64, 37.64)];
    [bezierPath2 addLineToPoint: CGPointMake(22.64, 32.48)];
    [bezierPath2 addLineToPoint: CGPointMake(19.81, 32.48)];
    [bezierPath2 closePath];
    bezierPath2.usesEvenOddFillRule = YES;
    [fillColor2 setFill];
    [bezierPath2 fill];

    UIBezierPath* bezierPath3 = [UIBezierPath bezierPath];
    [bezierPath3 moveToPoint: CGPointMake(54.51, 42)];
    [bezierPath3 addCurveToPoint: CGPointMake(54.6, 40.8) controlPoint1: CGPointMake(54.54, 41.78) controlPoint2: CGPointMake(54.6, 41.32)];
    [bezierPath3 addCurveToPoint: CGPointMake(50.56, 35.95) controlPoint1: CGPointMake(54.6, 38.39) controlPoint2: CGPointMake(53.49, 35.95)];
    [bezierPath3 addCurveToPoint: CGPointMake(45.98, 41.14) controlPoint1: CGPointMake(47.41, 35.95) controlPoint2: CGPointMake(45.98, 38.67)];
    [bezierPath3 addCurveToPoint: CGPointMake(50.82, 46.1) controlPoint1: CGPointMake(45.98, 44.19) controlPoint2: CGPointMake(47.74, 46.1)];
    [bezierPath3 addCurveToPoint: CGPointMake(54.1, 45.5) controlPoint1: CGPointMake(52.04, 46.1) controlPoint2: CGPointMake(53.17, 45.9)];
    [bezierPath3 addLineToPoint: CGPointMake(53.73, 43.45)];
    [bezierPath3 addCurveToPoint: CGPointMake(51.23, 43.85) controlPoint1: CGPointMake(52.97, 43.71) controlPoint2: CGPointMake(52.19, 43.85)];
    [bezierPath3 addCurveToPoint: CGPointMake(48.67, 42) controlPoint1: CGPointMake(49.91, 43.85) controlPoint2: CGPointMake(48.76, 43.25)];
    [bezierPath3 addLineToPoint: CGPointMake(54.51, 42)];
    [bezierPath3 closePath];
    [bezierPath3 moveToPoint: CGPointMake(48.65, 39.93)];
    [bezierPath3 addCurveToPoint: CGPointMake(50.39, 37.96) controlPoint1: CGPointMake(48.72, 39.11) controlPoint2: CGPointMake(49.21, 37.96)];
    [bezierPath3 addCurveToPoint: CGPointMake(51.99, 39.93) controlPoint1: CGPointMake(51.69, 37.96) controlPoint2: CGPointMake(51.99, 39.19)];
    [bezierPath3 addLineToPoint: CGPointMake(48.65, 39.93)];
    [bezierPath3 closePath];
    bezierPath3.usesEvenOddFillRule = YES;
    [fillColor2 setFill];
    [bezierPath3 fill];

    UIBezierPath* bezierPath4 = [UIBezierPath bezierPath];
    [bezierPath4 moveToPoint: CGPointMake(55.5, 45.9)];
    [bezierPath4 addLineToPoint: CGPointMake(58.32, 45.9)];
    [bezierPath4 addLineToPoint: CGPointMake(58.32, 40.96)];
    [bezierPath4 addCurveToPoint: CGPointMake(58.37, 40.29) controlPoint1: CGPointMake(58.32, 40.72) controlPoint2: CGPointMake(58.34, 40.49)];
    [bezierPath4 addCurveToPoint: CGPointMake(60.3, 38.75) controlPoint1: CGPointMake(58.56, 39.35) controlPoint2: CGPointMake(59.26, 38.75)];
    [bezierPath4 addCurveToPoint: CGPointMake(61.06, 38.83) controlPoint1: CGPointMake(60.62, 38.75) controlPoint2: CGPointMake(60.86, 38.79)];
    [bezierPath4 addLineToPoint: CGPointMake(61.06, 35.99)];
    [bezierPath4 addCurveToPoint: CGPointMake(60.47, 35.95) controlPoint1: CGPointMake(60.86, 35.95) controlPoint2: CGPointMake(60.73, 35.95)];
    [bezierPath4 addCurveToPoint: CGPointMake(58.02, 37.96) controlPoint1: CGPointMake(59.6, 35.95) controlPoint2: CGPointMake(58.49, 36.54)];
    [bezierPath4 addLineToPoint: CGPointMake(57.95, 37.96)];
    [bezierPath4 addLineToPoint: CGPointMake(57.86, 36.16)];
    [bezierPath4 addLineToPoint: CGPointMake(55.43, 36.16)];
    [bezierPath4 addCurveToPoint: CGPointMake(55.5, 39.37) controlPoint1: CGPointMake(55.46, 37) controlPoint2: CGPointMake(55.5, 37.94)];
    [bezierPath4 addLineToPoint: CGPointMake(55.5, 45.9)];
    [bezierPath4 closePath];
    bezierPath4.usesEvenOddFillRule = YES;
    [fillColor2 setFill];
    [bezierPath4 fill];

    UIBezierPath* bezierPath5 = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(31.6, 31.94, 3.2, 3.2)];
    [fillColor3 setFill];
    [bezierPath5 fill];

    UIBezierPath* bezierPath6 = [UIBezierPath bezierPath];
    [bezierPath6 moveToPoint: CGPointMake(38.93, 43.63)];
    [bezierPath6 addLineToPoint: CGPointMake(40.34, 43.63)];
    [bezierPath6 addCurveToPoint: CGPointMake(42.4, 41.64) controlPoint1: CGPointMake(41.76, 43.63) controlPoint2: CGPointMake(42.4, 42.66)];
    [bezierPath6 addCurveToPoint: CGPointMake(40.58, 38.32) controlPoint1: CGPointMake(42.4, 40.62) controlPoint2: CGPointMake(42.33, 38.32)];
    [bezierPath6 addCurveToPoint: CGPointMake(38.9, 42.67) controlPoint1: CGPointMake(38.56, 38.32) controlPoint2: CGPointMake(38.89, 41.18)];
    [bezierPath6 addCurveToPoint: CGPointMake(38.93, 43.63) controlPoint1: CGPointMake(38.9, 42.99) controlPoint2: CGPointMake(38.92, 43.31)];
    [bezierPath6 closePath];
    [bezierPath6 moveToPoint: CGPointMake(31.53, 36.15)];
    [bezierPath6 addLineToPoint: CGPointMake(34.42, 36.15)];
    [bezierPath6 addLineToPoint: CGPointMake(34.42, 41.64)];
    [bezierPath6 addCurveToPoint: CGPointMake(36.11, 43.63) controlPoint1: CGPointMake(34.42, 42.66) controlPoint2: CGPointMake(34.95, 43.63)];
    [bezierPath6 addCurveToPoint: CGPointMake(36.03, 36.15) controlPoint1: CGPointMake(36.12, 41.16) controlPoint2: CGPointMake(36.11, 38.62)];
    [bezierPath6 addLineToPoint: CGPointMake(38.45, 36.15)];
    [bezierPath6 addCurveToPoint: CGPointMake(38.6, 37.58) controlPoint1: CGPointMake(38.51, 36.63) controlPoint2: CGPointMake(38.56, 37.1)];
    [bezierPath6 addCurveToPoint: CGPointMake(44.56, 37.74) controlPoint1: CGPointMake(39.74, 35.12) controlPoint2: CGPointMake(43.34, 35.67)];
    [bezierPath6 addCurveToPoint: CGPointMake(40.34, 46.01) controlPoint1: CGPointMake(45.81, 39.88) controlPoint2: CGPointMake(46.23, 46.01)];
    [bezierPath6 addLineToPoint: CGPointMake(38.97, 46.01)];
    [bezierPath6 addCurveToPoint: CGPointMake(38.98, 49.75) controlPoint1: CGPointMake(38.98, 47.26) controlPoint2: CGPointMake(38.98, 48.5)];
    [bezierPath6 addLineToPoint: CGPointMake(36.09, 49.75)];
    [bezierPath6 addCurveToPoint: CGPointMake(36.1, 46.01) controlPoint1: CGPointMake(36.09, 48.55) controlPoint2: CGPointMake(36.09, 47.3)];
    [bezierPath6 addCurveToPoint: CGPointMake(31.53, 41.64) controlPoint1: CGPointMake(32.97, 46) controlPoint2: CGPointMake(31.53, 43.86)];
    [bezierPath6 addLineToPoint: CGPointMake(31.53, 36.15)];
    [bezierPath6 closePath];
    bezierPath6.usesEvenOddFillRule = YES;
    [fillColor2 setFill];
    [bezierPath6 fill];
}

@end
