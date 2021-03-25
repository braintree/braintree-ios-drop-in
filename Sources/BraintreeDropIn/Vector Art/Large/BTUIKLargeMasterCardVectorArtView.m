#import "BTUIKLargeMasterCardVectorArtView.h"

@implementation BTUIKLargeMasterCardVectorArtView

- (void)drawArt {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Group
    {
        CGContextSaveGState(context);
        
        //! MastercardLarge
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 0, 16);
            
            //! Icons
            {
                CGContextSaveGState(context);
                
                //! Mastercard-Copy
                {
                    CGContextSaveGState(context);
                    
                    //! mastercard
                    {
                        CGContextSaveGState(context);
                        
                        //! mastercardSpacer
                        UIBezierPath *mastercardSpacer = [UIBezierPath bezierPath];
                        [mastercardSpacer moveToPoint:CGPointMake(0, 3.85)];
                        [mastercardSpacer addCurveToPoint:CGPointMake(3.98, 0) controlPoint1:CGPointMake(0, 1.73) controlPoint2:CGPointMake(1.78, 0)];
                        [mastercardSpacer addLineToPoint:CGPointMake(76.02, 0)];
                        [mastercardSpacer addCurveToPoint:CGPointMake(80, 3.85) controlPoint1:CGPointMake(78.22, 0) controlPoint2:CGPointMake(80, 1.73)];
                        [mastercardSpacer addLineToPoint:CGPointMake(80, 44.15)];
                        [mastercardSpacer addCurveToPoint:CGPointMake(76.02, 48) controlPoint1:CGPointMake(80, 46.27) controlPoint2:CGPointMake(78.22, 48)];
                        [mastercardSpacer addLineToPoint:CGPointMake(3.98, 48)];
                        [mastercardSpacer addCurveToPoint:CGPointMake(0, 44.15) controlPoint1:CGPointMake(1.78, 48) controlPoint2:CGPointMake(0, 46.27)];
                        [mastercardSpacer addLineToPoint:CGPointMake(0, 3.85)];
                        [mastercardSpacer closePath];
                        [mastercardSpacer moveToPoint:CGPointMake(0, 3.85)];
                        CGContextSaveGState(context);
                        [UIColor.whiteColor setFill];
                        [mastercardSpacer fill];
                        CGContextRestoreGState(context);
                        
                        //! mastercardPath4
                        UIBezierPath *mastercardPath4 = [UIBezierPath bezierPath];
                        [mastercardPath4 moveToPoint:CGPointMake(6.96, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(6.96, 3.36)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(5.23, 1.63) controlPoint1:CGPointMake(6.96, 2.31) controlPoint2:CGPointMake(6.32, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(3.68, 2.4) controlPoint1:CGPointMake(4.69, 1.63) controlPoint2:CGPointMake(4.09, 1.81)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(2.23, 1.63) controlPoint1:CGPointMake(3.37, 1.9) controlPoint2:CGPointMake(2.91, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(0.96, 2.27) controlPoint1:CGPointMake(1.77, 1.63) controlPoint2:CGPointMake(1.32, 1.77)];
                        [mastercardPath4 addLineToPoint:CGPointMake(0.96, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(0, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(0, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(0.96, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(0.96, 3.67)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(2, 2.54) controlPoint1:CGPointMake(0.96, 2.9) controlPoint2:CGPointMake(1.36, 2.54)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(2.96, 3.67) controlPoint1:CGPointMake(2.64, 2.54) controlPoint2:CGPointMake(2.96, 2.95)];
                        [mastercardPath4 addLineToPoint:CGPointMake(2.96, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(3.91, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(3.91, 3.67)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(4.96, 2.54) controlPoint1:CGPointMake(3.91, 2.9) controlPoint2:CGPointMake(4.37, 2.54)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(5.91, 3.67) controlPoint1:CGPointMake(5.6, 2.54) controlPoint2:CGPointMake(5.91, 2.95)];
                        [mastercardPath4 addLineToPoint:CGPointMake(5.91, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(6.96, 6.08)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(21.11, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(19.56, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(19.56, 0.41)];
                        [mastercardPath4 addLineToPoint:CGPointMake(18.61, 0.41)];
                        [mastercardPath4 addLineToPoint:CGPointMake(18.61, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(17.74, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(17.74, 2.59)];
                        [mastercardPath4 addLineToPoint:CGPointMake(18.61, 2.59)];
                        [mastercardPath4 addLineToPoint:CGPointMake(18.61, 4.58)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(20.11, 6.17) controlPoint1:CGPointMake(18.61, 5.58) controlPoint2:CGPointMake(19.02, 6.17)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(21.29, 5.85) controlPoint1:CGPointMake(20.52, 6.17) controlPoint2:CGPointMake(20.97, 6.03)];
                        [mastercardPath4 addLineToPoint:CGPointMake(21.02, 5.03)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(20.2, 5.26) controlPoint1:CGPointMake(20.75, 5.22) controlPoint2:CGPointMake(20.43, 5.26)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(19.56, 4.54) controlPoint1:CGPointMake(19.74, 5.26) controlPoint2:CGPointMake(19.56, 4.99)];
                        [mastercardPath4 addLineToPoint:CGPointMake(19.56, 2.59)];
                        [mastercardPath4 addLineToPoint:CGPointMake(21.11, 2.59)];
                        [mastercardPath4 addLineToPoint:CGPointMake(21.11, 1.72)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(29.21, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(28.07, 2.27) controlPoint1:CGPointMake(28.66, 1.63) controlPoint2:CGPointMake(28.3, 1.9)];
                        [mastercardPath4 addLineToPoint:CGPointMake(28.07, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(27.11, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(27.11, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(28.07, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(28.07, 3.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(28.98, 2.49) controlPoint1:CGPointMake(28.07, 2.9) controlPoint2:CGPointMake(28.39, 2.49)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(29.57, 2.59) controlPoint1:CGPointMake(29.16, 2.49) controlPoint2:CGPointMake(29.39, 2.54)];
                        [mastercardPath4 addLineToPoint:CGPointMake(29.84, 1.68)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(29.21, 1.63) controlPoint1:CGPointMake(29.66, 1.63) controlPoint2:CGPointMake(29.39, 1.63)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(16.97, 2.09)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(15.19, 1.63) controlPoint1:CGPointMake(16.51, 1.77) controlPoint2:CGPointMake(15.88, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(13.38, 3.04) controlPoint1:CGPointMake(14.1, 1.63) controlPoint2:CGPointMake(13.38, 2.18)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(14.88, 4.31) controlPoint1:CGPointMake(13.38, 3.76) controlPoint2:CGPointMake(13.92, 4.17)];
                        [mastercardPath4 addLineToPoint:CGPointMake(15.33, 4.35)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(16.1, 4.81) controlPoint1:CGPointMake(15.83, 4.44) controlPoint2:CGPointMake(16.1, 4.58)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(15.1, 5.35) controlPoint1:CGPointMake(16.1, 5.13) controlPoint2:CGPointMake(15.74, 5.35)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(13.65, 4.9) controlPoint1:CGPointMake(14.47, 5.35) controlPoint2:CGPointMake(13.97, 5.13)];
                        [mastercardPath4 addLineToPoint:CGPointMake(13.19, 5.62)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(15.06, 6.17) controlPoint1:CGPointMake(13.69, 5.99) controlPoint2:CGPointMake(14.38, 6.17)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(17.06, 4.76) controlPoint1:CGPointMake(16.33, 6.17) controlPoint2:CGPointMake(17.06, 5.58)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(15.56, 3.45) controlPoint1:CGPointMake(17.06, 3.99) controlPoint2:CGPointMake(16.47, 3.58)];
                        [mastercardPath4 addLineToPoint:CGPointMake(15.1, 3.4)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(14.38, 2.99) controlPoint1:CGPointMake(14.69, 3.36) controlPoint2:CGPointMake(14.38, 3.27)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(15.19, 2.49) controlPoint1:CGPointMake(14.38, 2.68) controlPoint2:CGPointMake(14.69, 2.49)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(16.56, 2.86) controlPoint1:CGPointMake(15.74, 2.49) controlPoint2:CGPointMake(16.29, 2.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(16.97, 2.09)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(42.35, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(41.22, 2.27) controlPoint1:CGPointMake(41.81, 1.63) controlPoint2:CGPointMake(41.44, 1.9)];
                        [mastercardPath4 addLineToPoint:CGPointMake(41.22, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(40.26, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(40.26, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(41.22, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(41.22, 3.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(42.13, 2.49) controlPoint1:CGPointMake(41.22, 2.9) controlPoint2:CGPointMake(41.54, 2.49)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(42.72, 2.59) controlPoint1:CGPointMake(42.31, 2.49) controlPoint2:CGPointMake(42.54, 2.54)];
                        [mastercardPath4 addLineToPoint:CGPointMake(42.99, 1.68)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(42.35, 1.63) controlPoint1:CGPointMake(42.81, 1.63) controlPoint2:CGPointMake(42.54, 1.63)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(30.16, 3.9)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(32.48, 6.17) controlPoint1:CGPointMake(30.16, 5.22) controlPoint2:CGPointMake(31.07, 6.17)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(34.03, 5.67) controlPoint1:CGPointMake(33.12, 6.17) controlPoint2:CGPointMake(33.57, 6.03)];
                        [mastercardPath4 addLineToPoint:CGPointMake(33.57, 4.9)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(32.44, 5.31) controlPoint1:CGPointMake(33.21, 5.17) controlPoint2:CGPointMake(32.85, 5.31)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(31.12, 3.9) controlPoint1:CGPointMake(31.66, 5.31) controlPoint2:CGPointMake(31.12, 4.76)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(32.44, 2.49) controlPoint1:CGPointMake(31.12, 3.08) controlPoint2:CGPointMake(31.66, 2.54)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(33.57, 2.9) controlPoint1:CGPointMake(32.85, 2.49) controlPoint2:CGPointMake(33.21, 2.63)];
                        [mastercardPath4 addLineToPoint:CGPointMake(34.03, 2.13)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(32.48, 1.63) controlPoint1:CGPointMake(33.57, 1.77) controlPoint2:CGPointMake(33.12, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(30.16, 3.9) controlPoint1:CGPointMake(31.07, 1.63) controlPoint2:CGPointMake(30.16, 2.59)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(38.99, 3.9)];
                        [mastercardPath4 addLineToPoint:CGPointMake(38.99, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(38.03, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(38.03, 2.27)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(36.67, 1.63) controlPoint1:CGPointMake(37.71, 1.86) controlPoint2:CGPointMake(37.26, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(34.48, 3.9) controlPoint1:CGPointMake(35.44, 1.63) controlPoint2:CGPointMake(34.48, 2.59)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(36.67, 6.17) controlPoint1:CGPointMake(34.48, 5.22) controlPoint2:CGPointMake(35.44, 6.17)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(38.03, 5.53) controlPoint1:CGPointMake(37.3, 6.17) controlPoint2:CGPointMake(37.76, 5.94)];
                        [mastercardPath4 addLineToPoint:CGPointMake(38.03, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(38.99, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(38.99, 3.9)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(35.49, 3.9)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(36.8, 2.49) controlPoint1:CGPointMake(35.49, 3.13) controlPoint2:CGPointMake(35.99, 2.49)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(38.12, 3.9) controlPoint1:CGPointMake(37.58, 2.49) controlPoint2:CGPointMake(38.12, 3.08)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(36.8, 5.31) controlPoint1:CGPointMake(38.12, 4.67) controlPoint2:CGPointMake(37.58, 5.31)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(35.49, 3.9) controlPoint1:CGPointMake(35.99, 5.26) controlPoint2:CGPointMake(35.49, 4.67)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(24.07, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(21.88, 3.9) controlPoint1:CGPointMake(22.79, 1.63) controlPoint2:CGPointMake(21.88, 2.54)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(24.11, 6.17) controlPoint1:CGPointMake(21.88, 5.26) controlPoint2:CGPointMake(22.79, 6.17)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(25.89, 5.58) controlPoint1:CGPointMake(24.75, 6.17) controlPoint2:CGPointMake(25.39, 5.99)];
                        [mastercardPath4 addLineToPoint:CGPointMake(25.43, 4.9)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(24.16, 5.35) controlPoint1:CGPointMake(25.07, 5.17) controlPoint2:CGPointMake(24.61, 5.35)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(22.84, 4.31) controlPoint1:CGPointMake(23.57, 5.35) controlPoint2:CGPointMake(22.97, 5.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(26.07, 4.31)];
                        [mastercardPath4 addLineToPoint:CGPointMake(26.07, 3.95)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(24.07, 1.63) controlPoint1:CGPointMake(26.11, 2.54) controlPoint2:CGPointMake(25.29, 1.63)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(24.07, 2.45)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(25.16, 3.49) controlPoint1:CGPointMake(24.66, 2.45) controlPoint2:CGPointMake(25.07, 2.81)];
                        [mastercardPath4 addLineToPoint:CGPointMake(22.88, 3.49)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(24.07, 2.45) controlPoint1:CGPointMake(22.97, 2.9) controlPoint2:CGPointMake(23.38, 2.45)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(47.77, 3.9)];
                        [mastercardPath4 addLineToPoint:CGPointMake(47.77, 0)];
                        [mastercardPath4 addLineToPoint:CGPointMake(46.81, 0)];
                        [mastercardPath4 addLineToPoint:CGPointMake(46.81, 2.27)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(45.45, 1.63) controlPoint1:CGPointMake(46.49, 1.86) controlPoint2:CGPointMake(46.04, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(43.26, 3.9) controlPoint1:CGPointMake(44.22, 1.63) controlPoint2:CGPointMake(43.26, 2.59)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(45.45, 6.17) controlPoint1:CGPointMake(43.26, 5.22) controlPoint2:CGPointMake(44.22, 6.17)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(46.81, 5.53) controlPoint1:CGPointMake(46.09, 6.17) controlPoint2:CGPointMake(46.54, 5.94)];
                        [mastercardPath4 addLineToPoint:CGPointMake(46.81, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(47.77, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(47.77, 3.9)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(44.27, 3.9)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(45.58, 2.49) controlPoint1:CGPointMake(44.27, 3.13) controlPoint2:CGPointMake(44.77, 2.49)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(46.9, 3.9) controlPoint1:CGPointMake(46.36, 2.49) controlPoint2:CGPointMake(46.9, 3.08)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(45.58, 5.31) controlPoint1:CGPointMake(46.9, 4.67) controlPoint2:CGPointMake(46.36, 5.31)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(44.27, 3.9) controlPoint1:CGPointMake(44.77, 5.26) controlPoint2:CGPointMake(44.27, 4.67)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(12.33, 3.9)];
                        [mastercardPath4 addLineToPoint:CGPointMake(12.33, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(11.37, 1.72)];
                        [mastercardPath4 addLineToPoint:CGPointMake(11.37, 2.27)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(10.01, 1.63) controlPoint1:CGPointMake(11.05, 1.86) controlPoint2:CGPointMake(10.6, 1.63)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(7.82, 3.9) controlPoint1:CGPointMake(8.78, 1.63) controlPoint2:CGPointMake(7.82, 2.59)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(10.01, 6.17) controlPoint1:CGPointMake(7.82, 5.22) controlPoint2:CGPointMake(8.78, 6.17)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(11.37, 5.53) controlPoint1:CGPointMake(10.65, 6.17) controlPoint2:CGPointMake(11.1, 5.94)];
                        [mastercardPath4 addLineToPoint:CGPointMake(11.37, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(12.33, 6.08)];
                        [mastercardPath4 addLineToPoint:CGPointMake(12.33, 3.9)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(8.78, 3.9)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(10.1, 2.49) controlPoint1:CGPointMake(8.78, 3.13) controlPoint2:CGPointMake(9.28, 2.49)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(11.42, 3.9) controlPoint1:CGPointMake(10.87, 2.49) controlPoint2:CGPointMake(11.42, 3.08)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(10.1, 5.31) controlPoint1:CGPointMake(11.42, 4.67) controlPoint2:CGPointMake(10.87, 5.31)];
                        [mastercardPath4 addCurveToPoint:CGPointMake(8.78, 3.9) controlPoint1:CGPointMake(9.28, 5.26) controlPoint2:CGPointMake(8.78, 4.67)];
                        [mastercardPath4 closePath];
                        [mastercardPath4 moveToPoint:CGPointMake(8.78, 3.9)];
                        CGContextSaveGState(context);
                        CGContextTranslateCTM(context, 15.21, 38.32);
                        [UIColor.blackColor setFill];
                        [mastercardPath4 fill];
                        CGContextRestoreGState(context);
                        
                        //! mastercardPath3
                        UIBezierPath *mastercardPath3 = [UIBezierPath bezierPath];
                        [mastercardPath3 moveToPoint:CGPointMake(14.33, 0)];
                        [mastercardPath3 addLineToPoint:CGPointZero];
                        [mastercardPath3 addLineToPoint:CGPointMake(0, 25.67)];
                        [mastercardPath3 addLineToPoint:CGPointMake(14.33, 25.67)];
                        [mastercardPath3 addLineToPoint:CGPointMake(14.33, 0)];
                        [mastercardPath3 closePath];
                        [mastercardPath3 moveToPoint:CGPointMake(14.33, 0)];
                        CGContextSaveGState(context);
                        CGContextTranslateCTM(context, 31.86, 6.98);
                        [[UIColor colorWithHue:0.062 saturation:1 brightness:1 alpha:1] setFill];
                        [mastercardPath3 fill];
                        CGContextRestoreGState(context);
                        
                        //! mastercardPath2
                        UIBezierPath *mastercardPath2 = [UIBezierPath bezierPath];
                        [mastercardPath2 moveToPoint:CGPointMake(20.24, 16.33)];
                        [mastercardPath2 addCurveToPoint:CGPointMake(26.48, 3.49) controlPoint1:CGPointMake(20.24, 11.11) controlPoint2:CGPointMake(22.7, 6.49)];
                        [mastercardPath2 addCurveToPoint:CGPointMake(16.38, 0) controlPoint1:CGPointMake(23.7, 1.32) controlPoint2:CGPointMake(20.2, 0)];
                        [mastercardPath2 addCurveToPoint:CGPointMake(0, 16.33) controlPoint1:CGPointMake(7.32, 0) controlPoint2:CGPointMake(0, 7.3)];
                        [mastercardPath2 addCurveToPoint:CGPointMake(16.38, 32.65) controlPoint1:CGPointMake(0, 25.35) controlPoint2:CGPointMake(7.32, 32.65)];
                        [mastercardPath2 addCurveToPoint:CGPointMake(26.48, 29.16) controlPoint1:CGPointMake(20.2, 32.65) controlPoint2:CGPointMake(23.7, 31.34)];
                        [mastercardPath2 addCurveToPoint:CGPointMake(20.24, 16.33) controlPoint1:CGPointMake(22.7, 26.21) controlPoint2:CGPointMake(20.24, 21.54)];
                        [mastercardPath2 closePath];
                        [mastercardPath2 moveToPoint:CGPointMake(20.24, 16.33)];
                        CGContextSaveGState(context);
                        CGContextTranslateCTM(context, 12.52, 3.49);
                        [[UIColor colorWithHue:0.981 saturation:1 brightness:0.922 alpha:1] setFill];
                        [mastercardPath2 fill];
                        CGContextRestoreGState(context);
                        
                        //! mastercardPath1
                        UIBezierPath *mastercardPath1 = [UIBezierPath bezierPath];
                        [mastercardPath1 moveToPoint:CGPointMake(26.48, 16.33)];
                        [mastercardPath1 addCurveToPoint:CGPointMake(10.1, 32.65) controlPoint1:CGPointMake(26.48, 25.35) controlPoint2:CGPointMake(19.15, 32.65)];
                        [mastercardPath1 addCurveToPoint:CGPointMake(0, 29.16) controlPoint1:CGPointMake(6.28, 32.65) controlPoint2:CGPointMake(2.78, 31.34)];
                        [mastercardPath1 addCurveToPoint:CGPointMake(6.23, 16.33) controlPoint1:CGPointMake(3.82, 26.17) controlPoint2:CGPointMake(6.23, 21.54)];
                        [mastercardPath1 addCurveToPoint:CGPointMake(0, 3.49) controlPoint1:CGPointMake(6.23, 11.11) controlPoint2:CGPointMake(3.78, 6.49)];
                        [mastercardPath1 addCurveToPoint:CGPointMake(10.1, 0) controlPoint1:CGPointMake(2.78, 1.32) controlPoint2:CGPointMake(6.28, 0)];
                        [mastercardPath1 addCurveToPoint:CGPointMake(26.48, 16.33) controlPoint1:CGPointMake(19.15, 0) controlPoint2:CGPointMake(26.48, 7.35)];
                        [mastercardPath1 closePath];
                        [mastercardPath1 moveToPoint:CGPointMake(26.48, 16.33)];
                        CGContextSaveGState(context);
                        CGContextTranslateCTM(context, 39.04, 3.49);
                        [[UIColor colorWithHue:0.099 saturation:0.891 brightness:0.969 alpha:1] setFill];
                        [mastercardPath1 fill];
                        CGContextRestoreGState(context);
                        
                        CGContextRestoreGState(context);
                    }
                    
                    CGContextRestoreGState(context);
                }
                
                CGContextRestoreGState(context);
            }
            
            CGContextRestoreGState(context);
        }
        
        CGContextRestoreGState(context);
    }
}
@end
