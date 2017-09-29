#import "BTUIKMasterCardVectorArtView.h"

@implementation BTUIKMasterCardVectorArtView

- (void)drawArt {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Mastercard
    {
        CGContextSaveGState(context);
        
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
                    [mastercardSpacer moveToPoint:CGPointMake(0, 2.21)];
                    [mastercardSpacer addCurveToPoint:CGPointMake(2.24, 0) controlPoint1:CGPointMake(0, 0.99) controlPoint2:CGPointMake(1, 0)];
                    [mastercardSpacer addLineToPoint:CGPointMake(42.76, 0)];
                    [mastercardSpacer addCurveToPoint:CGPointMake(45, 2.21) controlPoint1:CGPointMake(44, 0) controlPoint2:CGPointMake(45, 0.99)];
                    [mastercardSpacer addLineToPoint:CGPointMake(45, 25.34)];
                    [mastercardSpacer addCurveToPoint:CGPointMake(42.76, 27.55) controlPoint1:CGPointMake(45, 26.56) controlPoint2:CGPointMake(44, 27.55)];
                    [mastercardSpacer addLineToPoint:CGPointMake(2.24, 27.55)];
                    [mastercardSpacer addCurveToPoint:CGPointMake(0, 25.34) controlPoint1:CGPointMake(1, 27.55) controlPoint2:CGPointMake(0, 26.56)];
                    [mastercardSpacer addLineToPoint:CGPointMake(0, 2.21)];
                    [mastercardSpacer closePath];
                    [mastercardSpacer moveToPoint:CGPointMake(0, 2.21)];
                    CGContextSaveGState(context);
                    [UIColor.whiteColor setFill];
                    [mastercardSpacer fill];
                    CGContextRestoreGState(context);
                    
                    //! mastercardPath4
                    UIBezierPath *mastercardPath4 = [UIBezierPath bezierPath];
                    [mastercardPath4 moveToPoint:CGPointMake(3.92, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(3.92, 1.93)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(2.94, 0.94) controlPoint1:CGPointMake(3.92, 1.33) controlPoint2:CGPointMake(3.56, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(2.07, 1.38) controlPoint1:CGPointMake(2.64, 0.94) controlPoint2:CGPointMake(2.3, 1.04)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(1.25, 0.94) controlPoint1:CGPointMake(1.89, 1.09) controlPoint2:CGPointMake(1.64, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(0.54, 1.3) controlPoint1:CGPointMake(1, 0.94) controlPoint2:CGPointMake(0.74, 1.02)];
                    [mastercardPath4 addLineToPoint:CGPointMake(0.54, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(0, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(0, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(0.54, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(0.54, 2.11)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(1.13, 1.46) controlPoint1:CGPointMake(0.54, 1.67) controlPoint2:CGPointMake(0.77, 1.46)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(1.66, 2.11) controlPoint1:CGPointMake(1.48, 1.46) controlPoint2:CGPointMake(1.66, 1.69)];
                    [mastercardPath4 addLineToPoint:CGPointMake(1.66, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(2.2, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(2.2, 2.11)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(2.79, 1.46) controlPoint1:CGPointMake(2.2, 1.67) controlPoint2:CGPointMake(2.46, 1.46)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(3.33, 2.11) controlPoint1:CGPointMake(3.15, 1.46) controlPoint2:CGPointMake(3.33, 1.69)];
                    [mastercardPath4 addLineToPoint:CGPointMake(3.33, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(3.92, 3.49)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(11.87, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(11, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(11, 0.23)];
                    [mastercardPath4 addLineToPoint:CGPointMake(10.47, 0.23)];
                    [mastercardPath4 addLineToPoint:CGPointMake(10.47, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(9.98, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(9.98, 1.48)];
                    [mastercardPath4 addLineToPoint:CGPointMake(10.47, 1.48)];
                    [mastercardPath4 addLineToPoint:CGPointMake(10.47, 2.63)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(11.31, 3.54) controlPoint1:CGPointMake(10.47, 3.2) controlPoint2:CGPointMake(10.7, 3.54)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(11.98, 3.36) controlPoint1:CGPointMake(11.54, 3.54) controlPoint2:CGPointMake(11.8, 3.46)];
                    [mastercardPath4 addLineToPoint:CGPointMake(11.82, 2.89)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(11.36, 3.02) controlPoint1:CGPointMake(11.67, 2.99) controlPoint2:CGPointMake(11.49, 3.02)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(11, 2.6) controlPoint1:CGPointMake(11.11, 3.02) controlPoint2:CGPointMake(11, 2.86)];
                    [mastercardPath4 addLineToPoint:CGPointMake(11, 1.48)];
                    [mastercardPath4 addLineToPoint:CGPointMake(11.87, 1.48)];
                    [mastercardPath4 addLineToPoint:CGPointMake(11.87, 0.99)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(16.43, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(15.79, 1.3) controlPoint1:CGPointMake(16.12, 0.94) controlPoint2:CGPointMake(15.92, 1.09)];
                    [mastercardPath4 addLineToPoint:CGPointMake(15.79, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(15.25, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(15.25, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(15.79, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(15.79, 2.08)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(16.3, 1.43) controlPoint1:CGPointMake(15.79, 1.67) controlPoint2:CGPointMake(15.97, 1.43)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(16.63, 1.48) controlPoint1:CGPointMake(16.4, 1.43) controlPoint2:CGPointMake(16.53, 1.46)];
                    [mastercardPath4 addLineToPoint:CGPointMake(16.79, 0.96)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(16.43, 0.94) controlPoint1:CGPointMake(16.68, 0.94) controlPoint2:CGPointMake(16.53, 0.94)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(9.55, 1.2)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(8.55, 0.94) controlPoint1:CGPointMake(9.29, 1.02) controlPoint2:CGPointMake(8.93, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(7.52, 1.74) controlPoint1:CGPointMake(7.93, 0.94) controlPoint2:CGPointMake(7.52, 1.25)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(8.37, 2.47) controlPoint1:CGPointMake(7.52, 2.16) controlPoint2:CGPointMake(7.83, 2.39)];
                    [mastercardPath4 addLineToPoint:CGPointMake(8.62, 2.5)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(9.06, 2.76) controlPoint1:CGPointMake(8.91, 2.55) controlPoint2:CGPointMake(9.06, 2.63)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(8.5, 3.07) controlPoint1:CGPointMake(9.06, 2.94) controlPoint2:CGPointMake(8.85, 3.07)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(7.68, 2.81) controlPoint1:CGPointMake(8.14, 3.07) controlPoint2:CGPointMake(7.86, 2.94)];
                    [mastercardPath4 addLineToPoint:CGPointMake(7.42, 3.23)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(8.47, 3.54) controlPoint1:CGPointMake(7.7, 3.44) controlPoint2:CGPointMake(8.09, 3.54)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(9.6, 2.73) controlPoint1:CGPointMake(9.19, 3.54) controlPoint2:CGPointMake(9.6, 3.2)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(8.75, 1.98) controlPoint1:CGPointMake(9.6, 2.29) controlPoint2:CGPointMake(9.26, 2.06)];
                    [mastercardPath4 addLineToPoint:CGPointMake(8.5, 1.95)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(8.09, 1.72) controlPoint1:CGPointMake(8.27, 1.93) controlPoint2:CGPointMake(8.09, 1.87)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(8.55, 1.43) controlPoint1:CGPointMake(8.09, 1.54) controlPoint2:CGPointMake(8.27, 1.43)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(9.31, 1.64) controlPoint1:CGPointMake(8.85, 1.43) controlPoint2:CGPointMake(9.16, 1.56)];
                    [mastercardPath4 addLineToPoint:CGPointMake(9.55, 1.2)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(23.82, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(23.18, 1.3) controlPoint1:CGPointMake(23.52, 0.94) controlPoint2:CGPointMake(23.31, 1.09)];
                    [mastercardPath4 addLineToPoint:CGPointMake(23.18, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(22.65, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(22.65, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(23.18, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(23.18, 2.08)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(23.7, 1.43) controlPoint1:CGPointMake(23.18, 1.67) controlPoint2:CGPointMake(23.36, 1.43)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(24.03, 1.48) controlPoint1:CGPointMake(23.8, 1.43) controlPoint2:CGPointMake(23.93, 1.46)];
                    [mastercardPath4 addLineToPoint:CGPointMake(24.18, 0.96)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(23.82, 0.94) controlPoint1:CGPointMake(24.08, 0.94) controlPoint2:CGPointMake(23.93, 0.94)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(16.97, 2.24)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(18.27, 3.54) controlPoint1:CGPointMake(16.97, 2.99) controlPoint2:CGPointMake(17.48, 3.54)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(19.14, 3.25) controlPoint1:CGPointMake(18.63, 3.54) controlPoint2:CGPointMake(18.89, 3.46)];
                    [mastercardPath4 addLineToPoint:CGPointMake(18.89, 2.81)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(18.25, 3.05) controlPoint1:CGPointMake(18.68, 2.97) controlPoint2:CGPointMake(18.48, 3.05)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(17.5, 2.24) controlPoint1:CGPointMake(17.81, 3.05) controlPoint2:CGPointMake(17.5, 2.73)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(18.25, 1.43) controlPoint1:CGPointMake(17.5, 1.77) controlPoint2:CGPointMake(17.81, 1.46)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(18.89, 1.67) controlPoint1:CGPointMake(18.48, 1.43) controlPoint2:CGPointMake(18.68, 1.51)];
                    [mastercardPath4 addLineToPoint:CGPointMake(19.14, 1.22)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(18.27, 0.94) controlPoint1:CGPointMake(18.89, 1.02) controlPoint2:CGPointMake(18.63, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(16.97, 2.24) controlPoint1:CGPointMake(17.48, 0.94) controlPoint2:CGPointMake(16.97, 1.48)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(21.93, 2.24)];
                    [mastercardPath4 addLineToPoint:CGPointMake(21.93, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(21.39, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(21.39, 1.3)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(20.63, 0.94) controlPoint1:CGPointMake(21.21, 1.07) controlPoint2:CGPointMake(20.96, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(19.4, 2.24) controlPoint1:CGPointMake(19.93, 0.94) controlPoint2:CGPointMake(19.4, 1.48)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(20.63, 3.54) controlPoint1:CGPointMake(19.4, 2.99) controlPoint2:CGPointMake(19.93, 3.54)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(21.39, 3.18) controlPoint1:CGPointMake(20.98, 3.54) controlPoint2:CGPointMake(21.24, 3.41)];
                    [mastercardPath4 addLineToPoint:CGPointMake(21.39, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(21.93, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(21.93, 2.24)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(19.96, 2.24)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(20.7, 1.43) controlPoint1:CGPointMake(19.96, 1.8) controlPoint2:CGPointMake(20.24, 1.43)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(21.44, 2.24) controlPoint1:CGPointMake(21.14, 1.43) controlPoint2:CGPointMake(21.44, 1.77)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(20.7, 3.05) controlPoint1:CGPointMake(21.44, 2.68) controlPoint2:CGPointMake(21.14, 3.05)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(19.96, 2.24) controlPoint1:CGPointMake(20.24, 3.02) controlPoint2:CGPointMake(19.96, 2.68)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(13.54, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(12.31, 2.24) controlPoint1:CGPointMake(12.82, 0.94) controlPoint2:CGPointMake(12.31, 1.46)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(13.56, 3.54) controlPoint1:CGPointMake(12.31, 3.02) controlPoint2:CGPointMake(12.82, 3.54)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(14.56, 3.2) controlPoint1:CGPointMake(13.92, 3.54) controlPoint2:CGPointMake(14.28, 3.44)];
                    [mastercardPath4 addLineToPoint:CGPointMake(14.3, 2.81)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(13.59, 3.07) controlPoint1:CGPointMake(14.1, 2.97) controlPoint2:CGPointMake(13.84, 3.07)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(12.85, 2.47) controlPoint1:CGPointMake(13.26, 3.07) controlPoint2:CGPointMake(12.92, 2.92)];
                    [mastercardPath4 addLineToPoint:CGPointMake(14.66, 2.47)];
                    [mastercardPath4 addLineToPoint:CGPointMake(14.66, 2.26)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(13.54, 0.94) controlPoint1:CGPointMake(14.69, 1.46) controlPoint2:CGPointMake(14.23, 0.94)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(13.54, 1.41)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(14.15, 2) controlPoint1:CGPointMake(13.87, 1.41) controlPoint2:CGPointMake(14.1, 1.61)];
                    [mastercardPath4 addLineToPoint:CGPointMake(12.87, 2)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(13.54, 1.41) controlPoint1:CGPointMake(12.92, 1.67) controlPoint2:CGPointMake(13.15, 1.41)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(26.87, 2.24)];
                    [mastercardPath4 addLineToPoint:CGPointMake(26.87, 0)];
                    [mastercardPath4 addLineToPoint:CGPointMake(26.33, 0)];
                    [mastercardPath4 addLineToPoint:CGPointMake(26.33, 1.3)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(25.56, 0.94) controlPoint1:CGPointMake(26.15, 1.07) controlPoint2:CGPointMake(25.9, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(24.34, 2.24) controlPoint1:CGPointMake(24.87, 0.94) controlPoint2:CGPointMake(24.34, 1.48)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(25.56, 3.54) controlPoint1:CGPointMake(24.34, 2.99) controlPoint2:CGPointMake(24.87, 3.54)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(26.33, 3.18) controlPoint1:CGPointMake(25.92, 3.54) controlPoint2:CGPointMake(26.18, 3.41)];
                    [mastercardPath4 addLineToPoint:CGPointMake(26.33, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(26.87, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(26.87, 2.24)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(24.9, 2.24)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(25.64, 1.43) controlPoint1:CGPointMake(24.9, 1.8) controlPoint2:CGPointMake(25.18, 1.43)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(26.38, 2.24) controlPoint1:CGPointMake(26.08, 1.43) controlPoint2:CGPointMake(26.38, 1.77)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(25.64, 3.05) controlPoint1:CGPointMake(26.38, 2.68) controlPoint2:CGPointMake(26.08, 3.05)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(24.9, 2.24) controlPoint1:CGPointMake(25.18, 3.02) controlPoint2:CGPointMake(24.9, 2.68)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(6.93, 2.24)];
                    [mastercardPath4 addLineToPoint:CGPointMake(6.93, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(6.4, 0.99)];
                    [mastercardPath4 addLineToPoint:CGPointMake(6.4, 1.3)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(5.63, 0.94) controlPoint1:CGPointMake(6.22, 1.07) controlPoint2:CGPointMake(5.96, 0.94)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(4.4, 2.24) controlPoint1:CGPointMake(4.94, 0.94) controlPoint2:CGPointMake(4.4, 1.48)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(5.63, 3.54) controlPoint1:CGPointMake(4.4, 2.99) controlPoint2:CGPointMake(4.94, 3.54)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(6.4, 3.18) controlPoint1:CGPointMake(5.99, 3.54) controlPoint2:CGPointMake(6.24, 3.41)];
                    [mastercardPath4 addLineToPoint:CGPointMake(6.4, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(6.93, 3.49)];
                    [mastercardPath4 addLineToPoint:CGPointMake(6.93, 2.24)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(4.94, 2.24)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(5.68, 1.43) controlPoint1:CGPointMake(4.94, 1.8) controlPoint2:CGPointMake(5.22, 1.43)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(6.42, 2.24) controlPoint1:CGPointMake(6.12, 1.43) controlPoint2:CGPointMake(6.42, 1.77)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(5.68, 3.05) controlPoint1:CGPointMake(6.42, 2.68) controlPoint2:CGPointMake(6.12, 3.05)];
                    [mastercardPath4 addCurveToPoint:CGPointMake(4.94, 2.24) controlPoint1:CGPointMake(5.22, 3.02) controlPoint2:CGPointMake(4.94, 2.68)];
                    [mastercardPath4 closePath];
                    [mastercardPath4 moveToPoint:CGPointMake(4.94, 2.24)];
                    CGContextSaveGState(context);
                    CGContextTranslateCTM(context, 8.56, 22);
                    [UIColor.blackColor setFill];
                    [mastercardPath4 fill];
                    CGContextRestoreGState(context);
                    
                    //! mastercardPath3
                    UIBezierPath *mastercardPath3 = [UIBezierPath bezierPath];
                    [mastercardPath3 moveToPoint:CGPointMake(8.06, 0)];
                    [mastercardPath3 addLineToPoint:CGPointZero];
                    [mastercardPath3 addLineToPoint:CGPointMake(0, 14.73)];
                    [mastercardPath3 addLineToPoint:CGPointMake(8.06, 14.73)];
                    [mastercardPath3 addLineToPoint:CGPointMake(8.06, 0)];
                    [mastercardPath3 closePath];
                    [mastercardPath3 moveToPoint:CGPointMake(8.06, 0)];
                    CGContextSaveGState(context);
                    CGContextTranslateCTM(context, 17.92, 4.01);
                    [[UIColor colorWithHue:0.062 saturation:1 brightness:1 alpha:1] setFill];
                    [mastercardPath3 fill];
                    CGContextRestoreGState(context);
                    
                    //! mastercardPath2
                    UIBezierPath *mastercardPath2 = [UIBezierPath bezierPath];
                    [mastercardPath2 moveToPoint:CGPointMake(11.39, 9.37)];
                    [mastercardPath2 addCurveToPoint:CGPointMake(14.89, 2) controlPoint1:CGPointMake(11.39, 6.38) controlPoint2:CGPointMake(12.77, 3.72)];
                    [mastercardPath2 addCurveToPoint:CGPointMake(9.21, 0) controlPoint1:CGPointMake(13.33, 0.75) controlPoint2:CGPointMake(11.36, 0)];
                    [mastercardPath2 addCurveToPoint:CGPointMake(0, 9.37) controlPoint1:CGPointMake(4.12, 0) controlPoint2:CGPointMake(0, 4.19)];
                    [mastercardPath2 addCurveToPoint:CGPointMake(9.21, 18.74) controlPoint1:CGPointMake(0, 14.55) controlPoint2:CGPointMake(4.12, 18.74)];
                    [mastercardPath2 addCurveToPoint:CGPointMake(14.89, 16.74) controlPoint1:CGPointMake(11.36, 18.74) controlPoint2:CGPointMake(13.33, 17.99)];
                    [mastercardPath2 addCurveToPoint:CGPointMake(11.39, 9.37) controlPoint1:CGPointMake(12.77, 15.05) controlPoint2:CGPointMake(11.39, 12.37)];
                    [mastercardPath2 closePath];
                    [mastercardPath2 moveToPoint:CGPointMake(11.39, 9.37)];
                    CGContextSaveGState(context);
                    CGContextTranslateCTM(context, 7.04, 2);
                    [[UIColor colorWithHue:0.981 saturation:1 brightness:0.922 alpha:1] setFill];
                    [mastercardPath2 fill];
                    CGContextRestoreGState(context);
                    
                    //! mastercardPath1
                    UIBezierPath *mastercardPath1 = [UIBezierPath bezierPath];
                    [mastercardPath1 moveToPoint:CGPointMake(14.89, 9.37)];
                    [mastercardPath1 addCurveToPoint:CGPointMake(5.68, 18.74) controlPoint1:CGPointMake(14.89, 14.55) controlPoint2:CGPointMake(10.77, 18.74)];
                    [mastercardPath1 addCurveToPoint:CGPointMake(0, 16.74) controlPoint1:CGPointMake(3.53, 18.74) controlPoint2:CGPointMake(1.56, 17.99)];
                    [mastercardPath1 addCurveToPoint:CGPointMake(3.51, 9.37) controlPoint1:CGPointMake(2.15, 15.02) controlPoint2:CGPointMake(3.51, 12.37)];
                    [mastercardPath1 addCurveToPoint:CGPointMake(0, 2) controlPoint1:CGPointMake(3.51, 6.38) controlPoint2:CGPointMake(2.12, 3.72)];
                    [mastercardPath1 addCurveToPoint:CGPointMake(5.68, 0) controlPoint1:CGPointMake(1.56, 0.75) controlPoint2:CGPointMake(3.53, 0)];
                    [mastercardPath1 addCurveToPoint:CGPointMake(14.89, 9.37) controlPoint1:CGPointMake(10.77, 0) controlPoint2:CGPointMake(14.89, 4.22)];
                    [mastercardPath1 closePath];
                    [mastercardPath1 moveToPoint:CGPointMake(14.89, 9.37)];
                    CGContextSaveGState(context);
                    CGContextTranslateCTM(context, 21.96, 2);
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
}
@end
