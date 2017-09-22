#import "BTUIKMaestroVectorArtView.h"

@implementation BTUIKMaestroVectorArtView

- (void)drawArt {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Maestro
    {
        CGContextSaveGState(context);
        
        //! Icons
        {
            CGContextSaveGState(context);
            
            //! Maestro-Copy
            {
                CGContextSaveGState(context);
                
                //! maestro
                {
                    CGContextSaveGState(context);
                    
                    //! maestroSpacer
                    UIBezierPath *maestroSpacer = [UIBezierPath bezierPath];
                    [maestroSpacer moveToPoint:CGPointMake(43.12, 27.56)];
                    [maestroSpacer addLineToPoint:CGPointMake(43.12, 27.56)];
                    [maestroSpacer addLineToPoint:CGPointMake(1.88, 27.56)];
                    [maestroSpacer addLineToPoint:CGPointMake(1.88, 27.56)];
                    [maestroSpacer addCurveToPoint:CGPointMake(0, 25.72) controlPoint1:CGPointMake(0.84, 27.56) controlPoint2:CGPointMake(0, 26.74)];
                    [maestroSpacer addLineToPoint:CGPointMake(0, 25.72)];
                    [maestroSpacer addLineToPoint:CGPointMake(0, 1.84)];
                    [maestroSpacer addLineToPoint:CGPointMake(0, 1.84)];
                    [maestroSpacer addCurveToPoint:CGPointMake(1.88, 0) controlPoint1:CGPointMake(0, 0.83) controlPoint2:CGPointMake(0.84, 0)];
                    [maestroSpacer addLineToPoint:CGPointMake(1.88, 0)];
                    [maestroSpacer addLineToPoint:CGPointMake(43.12, 0)];
                    [maestroSpacer addLineToPoint:CGPointMake(43.12, 0)];
                    [maestroSpacer addCurveToPoint:CGPointMake(45, 1.84) controlPoint1:CGPointMake(44.16, 0) controlPoint2:CGPointMake(45, 0.83)];
                    [maestroSpacer addLineToPoint:CGPointMake(45, 1.84)];
                    [maestroSpacer addLineToPoint:CGPointMake(45, 25.72)];
                    [maestroSpacer addLineToPoint:CGPointMake(45, 25.72)];
                    [maestroSpacer addCurveToPoint:CGPointMake(43.12, 27.56) controlPoint1:CGPointMake(45, 26.74) controlPoint2:CGPointMake(44.16, 27.56)];
                    [maestroSpacer closePath];
                    [maestroSpacer moveToPoint:CGPointMake(43.12, 27.56)];
                    CGContextSaveGState(context);
                    [UIColor.whiteColor setFill];
                    [maestroSpacer fill];
                    CGContextRestoreGState(context);
                    
                    //! maestroPath4
                    UIBezierPath *maestroPath4 = [UIBezierPath bezierPath];
                    [maestroPath4 moveToPoint:CGPointMake(3.99, 3.3)];
                    [maestroPath4 addLineToPoint:CGPointMake(3.99, 1.7)];
                    [maestroPath4 addCurveToPoint:CGPointMake(3.13, 0.69) controlPoint1:CGPointMake(4.02, 1.17) controlPoint2:CGPointMake(3.65, 0.72)];
                    [maestroPath4 addLineToPoint:CGPointMake(3, 0.69)];
                    [maestroPath4 addCurveToPoint:CGPointMake(2.11, 1.14) controlPoint1:CGPointMake(2.66, 0.67) controlPoint2:CGPointMake(2.32, 0.85)];
                    [maestroPath4 addCurveToPoint:CGPointMake(1.28, 0.69) controlPoint1:CGPointMake(1.93, 0.85) controlPoint2:CGPointMake(1.62, 0.67)];
                    [maestroPath4 addCurveToPoint:CGPointMake(0.55, 1.06) controlPoint1:CGPointMake(0.99, 0.67) controlPoint2:CGPointMake(0.7, 0.83)];
                    [maestroPath4 addLineToPoint:CGPointMake(0.55, 0.75)];
                    [maestroPath4 addLineToPoint:CGPointMake(0, 0.75)];
                    [maestroPath4 addLineToPoint:CGPointMake(0, 3.27)];
                    [maestroPath4 addLineToPoint:CGPointMake(0.55, 3.27)];
                    [maestroPath4 addLineToPoint:CGPointMake(0.55, 1.92)];
                    [maestroPath4 addCurveToPoint:CGPointMake(1.04, 1.25) controlPoint1:CGPointMake(0.5, 1.6) controlPoint2:CGPointMake(0.73, 1.3)];
                    [maestroPath4 addLineToPoint:CGPointMake(1.15, 1.25)];
                    [maestroPath4 addCurveToPoint:CGPointMake(1.7, 1.92) controlPoint1:CGPointMake(1.51, 1.25) controlPoint2:CGPointMake(1.7, 1.49)];
                    [maestroPath4 addLineToPoint:CGPointMake(1.7, 3.33)];
                    [maestroPath4 addLineToPoint:CGPointMake(2.24, 3.33)];
                    [maestroPath4 addLineToPoint:CGPointMake(2.24, 1.92)];
                    [maestroPath4 addCurveToPoint:CGPointMake(2.74, 1.25) controlPoint1:CGPointMake(2.19, 1.6) controlPoint2:CGPointMake(2.43, 1.28)];
                    [maestroPath4 addLineToPoint:CGPointMake(2.84, 1.25)];
                    [maestroPath4 addCurveToPoint:CGPointMake(3.39, 1.92) controlPoint1:CGPointMake(3.21, 1.25) controlPoint2:CGPointMake(3.39, 1.49)];
                    [maestroPath4 addLineToPoint:CGPointMake(3.39, 3.33)];
                    [maestroPath4 addLineToPoint:CGPointMake(3.99, 3.3)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(7.05, 2.05)];
                    [maestroPath4 addLineToPoint:CGPointMake(7.05, 0.77)];
                    [maestroPath4 addLineToPoint:CGPointMake(6.5, 0.77)];
                    [maestroPath4 addLineToPoint:CGPointMake(6.5, 1.09)];
                    [maestroPath4 addCurveToPoint:CGPointMake(5.71, 0.72) controlPoint1:CGPointMake(6.31, 0.85) controlPoint2:CGPointMake(6.03, 0.72)];
                    [maestroPath4 addCurveToPoint:CGPointMake(4.41, 2.05) controlPoint1:CGPointMake(4.98, 0.72) controlPoint2:CGPointMake(4.41, 1.3)];
                    [maestroPath4 addCurveToPoint:CGPointMake(5.71, 3.38) controlPoint1:CGPointMake(4.41, 2.8) controlPoint2:CGPointMake(4.98, 3.38)];
                    [maestroPath4 addCurveToPoint:CGPointMake(6.5, 3.01) controlPoint1:CGPointMake(6.03, 3.38) controlPoint2:CGPointMake(6.31, 3.25)];
                    [maestroPath4 addLineToPoint:CGPointMake(6.5, 3.33)];
                    [maestroPath4 addLineToPoint:CGPointMake(7.05, 3.33)];
                    [maestroPath4 addLineToPoint:CGPointMake(7.05, 2.05)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(5.04, 2.05)];
                    [maestroPath4 addCurveToPoint:CGPointMake(5.84, 1.33) controlPoint1:CGPointMake(5.06, 1.62) controlPoint2:CGPointMake(5.43, 1.3)];
                    [maestroPath4 addCurveToPoint:CGPointMake(6.55, 2.16) controlPoint1:CGPointMake(6.26, 1.36) controlPoint2:CGPointMake(6.58, 1.73)];
                    [maestroPath4 addCurveToPoint:CGPointMake(5.79, 2.88) controlPoint1:CGPointMake(6.52, 2.56) controlPoint2:CGPointMake(6.21, 2.88)];
                    [maestroPath4 addCurveToPoint:CGPointMake(5.04, 2.13) controlPoint1:CGPointMake(5.38, 2.88) controlPoint2:CGPointMake(5.04, 2.56)];
                    [maestroPath4 addCurveToPoint:CGPointMake(5.04, 2.05) controlPoint1:CGPointMake(5.01, 2.08) controlPoint2:CGPointMake(5.01, 2.08)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(18.63, 0.72)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.15, 0.83) controlPoint1:CGPointMake(18.81, 0.72) controlPoint2:CGPointMake(19, 0.75)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.57, 1.12) controlPoint1:CGPointMake(19.31, 0.88) controlPoint2:CGPointMake(19.47, 0.99)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.86, 1.54) controlPoint1:CGPointMake(19.7, 1.25) controlPoint2:CGPointMake(19.78, 1.38)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.86, 2.61) controlPoint1:CGPointMake(19.99, 1.89) controlPoint2:CGPointMake(19.99, 2.26)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.57, 3.04) controlPoint1:CGPointMake(19.8, 2.77) controlPoint2:CGPointMake(19.7, 2.9)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.15, 3.33) controlPoint1:CGPointMake(19.44, 3.17) controlPoint2:CGPointMake(19.31, 3.25)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.08, 3.33) controlPoint1:CGPointMake(18.81, 3.46) controlPoint2:CGPointMake(18.42, 3.46)];
                    [maestroPath4 addCurveToPoint:CGPointMake(17.67, 3.04) controlPoint1:CGPointMake(17.93, 3.27) controlPoint2:CGPointMake(17.77, 3.17)];
                    [maestroPath4 addCurveToPoint:CGPointMake(17.38, 2.61) controlPoint1:CGPointMake(17.53, 2.9) controlPoint2:CGPointMake(17.46, 2.77)];
                    [maestroPath4 addCurveToPoint:CGPointMake(17.38, 1.54) controlPoint1:CGPointMake(17.25, 2.26) controlPoint2:CGPointMake(17.25, 1.89)];
                    [maestroPath4 addCurveToPoint:CGPointMake(17.67, 1.12) controlPoint1:CGPointMake(17.43, 1.38) controlPoint2:CGPointMake(17.53, 1.25)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.08, 0.83) controlPoint1:CGPointMake(17.8, 0.99) controlPoint2:CGPointMake(17.93, 0.91)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.63, 0.72) controlPoint1:CGPointMake(18.27, 0.75) controlPoint2:CGPointMake(18.45, 0.69)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(18.63, 1.25)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.32, 1.3) controlPoint1:CGPointMake(18.53, 1.25) controlPoint2:CGPointMake(18.42, 1.28)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.06, 1.46) controlPoint1:CGPointMake(18.21, 1.33) controlPoint2:CGPointMake(18.13, 1.41)];
                    [maestroPath4 addCurveToPoint:CGPointMake(17.9, 1.73) controlPoint1:CGPointMake(17.98, 1.54) controlPoint2:CGPointMake(17.93, 1.62)];
                    [maestroPath4 addCurveToPoint:CGPointMake(17.9, 2.4) controlPoint1:CGPointMake(17.82, 1.94) controlPoint2:CGPointMake(17.82, 2.18)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.06, 2.66) controlPoint1:CGPointMake(17.93, 2.5) controlPoint2:CGPointMake(18, 2.58)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.32, 2.82) controlPoint1:CGPointMake(18.13, 2.74) controlPoint2:CGPointMake(18.21, 2.8)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.94, 2.82) controlPoint1:CGPointMake(18.53, 2.9) controlPoint2:CGPointMake(18.74, 2.9)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.2, 2.66) controlPoint1:CGPointMake(19.05, 2.8) controlPoint2:CGPointMake(19.13, 2.72)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.36, 2.4) controlPoint1:CGPointMake(19.28, 2.58) controlPoint2:CGPointMake(19.34, 2.5)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.36, 1.73) controlPoint1:CGPointMake(19.44, 2.18) controlPoint2:CGPointMake(19.44, 1.94)];
                    [maestroPath4 addCurveToPoint:CGPointMake(19.2, 1.46) controlPoint1:CGPointMake(19.34, 1.62) controlPoint2:CGPointMake(19.26, 1.54)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.94, 1.3) controlPoint1:CGPointMake(19.13, 1.38) controlPoint2:CGPointMake(19.05, 1.33)];
                    [maestroPath4 addCurveToPoint:CGPointMake(18.63, 1.25) controlPoint1:CGPointMake(18.84, 1.25) controlPoint2:CGPointMake(18.74, 1.22)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(9.99, 2.05)];
                    [maestroPath4 addCurveToPoint:CGPointMake(8.82, 0.72) controlPoint1:CGPointMake(9.99, 1.25) controlPoint2:CGPointMake(9.5, 0.72)];
                    [maestroPath4 addCurveToPoint:CGPointMake(7.54, 2.08) controlPoint1:CGPointMake(8.09, 0.72) controlPoint2:CGPointMake(7.51, 1.33)];
                    [maestroPath4 addCurveToPoint:CGPointMake(8.87, 3.38) controlPoint1:CGPointMake(7.57, 2.82) controlPoint2:CGPointMake(8.14, 3.41)];
                    [maestroPath4 addCurveToPoint:CGPointMake(9.89, 3.04) controlPoint1:CGPointMake(9.24, 3.38) controlPoint2:CGPointMake(9.6, 3.27)];
                    [maestroPath4 addLineToPoint:CGPointMake(9.63, 2.64)];
                    [maestroPath4 addCurveToPoint:CGPointMake(8.9, 2.9) controlPoint1:CGPointMake(9.42, 2.8) controlPoint2:CGPointMake(9.16, 2.9)];
                    [maestroPath4 addCurveToPoint:CGPointMake(8.14, 2.29) controlPoint1:CGPointMake(8.53, 2.93) controlPoint2:CGPointMake(8.19, 2.66)];
                    [maestroPath4 addLineToPoint:CGPointMake(9.99, 2.29)];
                    [maestroPath4 addLineToPoint:CGPointMake(9.99, 2.05)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(8.14, 1.81)];
                    [maestroPath4 addCurveToPoint:CGPointMake(8.79, 1.2) controlPoint1:CGPointMake(8.17, 1.46) controlPoint2:CGPointMake(8.45, 1.2)];
                    [maestroPath4 addCurveToPoint:CGPointMake(9.42, 1.81) controlPoint1:CGPointMake(9.13, 1.2) controlPoint2:CGPointMake(9.42, 1.46)];
                    [maestroPath4 addLineToPoint:CGPointMake(8.14, 1.81)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(12.26, 1.41)];
                    [maestroPath4 addCurveToPoint:CGPointMake(11.48, 1.2) controlPoint1:CGPointMake(12.03, 1.28) controlPoint2:CGPointMake(11.77, 1.2)];
                    [maestroPath4 addCurveToPoint:CGPointMake(11.01, 1.49) controlPoint1:CGPointMake(11.19, 1.2) controlPoint2:CGPointMake(11.01, 1.3)];
                    [maestroPath4 addCurveToPoint:CGPointMake(11.43, 1.73) controlPoint1:CGPointMake(11.01, 1.68) controlPoint2:CGPointMake(11.19, 1.7)];
                    [maestroPath4 addLineToPoint:CGPointMake(11.69, 1.76)];
                    [maestroPath4 addCurveToPoint:CGPointMake(12.55, 2.53) controlPoint1:CGPointMake(12.24, 1.84) controlPoint2:CGPointMake(12.55, 2.08)];
                    [maestroPath4 addCurveToPoint:CGPointMake(11.4, 3.35) controlPoint1:CGPointMake(12.55, 2.98) controlPoint2:CGPointMake(12.13, 3.35)];
                    [maestroPath4 addCurveToPoint:CGPointMake(10.33, 3.04) controlPoint1:CGPointMake(11.01, 3.35) controlPoint2:CGPointMake(10.65, 3.25)];
                    [maestroPath4 addLineToPoint:CGPointMake(10.59, 2.61)];
                    [maestroPath4 addCurveToPoint:CGPointMake(11.43, 2.88) controlPoint1:CGPointMake(10.83, 2.8) controlPoint2:CGPointMake(11.12, 2.88)];
                    [maestroPath4 addCurveToPoint:CGPointMake(12, 2.56) controlPoint1:CGPointMake(11.79, 2.88) controlPoint2:CGPointMake(12, 2.77)];
                    [maestroPath4 addCurveToPoint:CGPointMake(11.56, 2.29) controlPoint1:CGPointMake(12, 2.42) controlPoint2:CGPointMake(11.87, 2.34)];
                    [maestroPath4 addLineToPoint:CGPointMake(11.3, 2.26)];
                    [maestroPath4 addCurveToPoint:CGPointMake(10.44, 1.52) controlPoint1:CGPointMake(10.75, 2.18) controlPoint2:CGPointMake(10.44, 1.92)];
                    [maestroPath4 addCurveToPoint:CGPointMake(11.48, 0.69) controlPoint1:CGPointMake(10.44, 1.01) controlPoint2:CGPointMake(10.85, 0.69)];
                    [maestroPath4 addCurveToPoint:CGPointMake(12.5, 0.96) controlPoint1:CGPointMake(11.85, 0.69) controlPoint2:CGPointMake(12.19, 0.77)];
                    [maestroPath4 addLineToPoint:CGPointMake(12.26, 1.41)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(14.87, 1.28)];
                    [maestroPath4 addLineToPoint:CGPointMake(13.99, 1.28)];
                    [maestroPath4 addLineToPoint:CGPointMake(13.99, 2.42)];
                    [maestroPath4 addCurveToPoint:CGPointMake(14.35, 2.85) controlPoint1:CGPointMake(13.99, 2.69) controlPoint2:CGPointMake(14.06, 2.85)];
                    [maestroPath4 addCurveToPoint:CGPointMake(14.82, 2.72) controlPoint1:CGPointMake(14.51, 2.85) controlPoint2:CGPointMake(14.69, 2.8)];
                    [maestroPath4 addLineToPoint:CGPointMake(14.98, 3.19)];
                    [maestroPath4 addCurveToPoint:CGPointMake(14.3, 3.38) controlPoint1:CGPointMake(14.77, 3.33) controlPoint2:CGPointMake(14.53, 3.38)];
                    [maestroPath4 addCurveToPoint:CGPointMake(13.44, 2.45) controlPoint1:CGPointMake(13.65, 3.38) controlPoint2:CGPointMake(13.44, 3.04)];
                    [maestroPath4 addLineToPoint:CGPointMake(13.44, 1.28)];
                    [maestroPath4 addLineToPoint:CGPointMake(12.94, 1.28)];
                    [maestroPath4 addLineToPoint:CGPointMake(12.94, 0.77)];
                    [maestroPath4 addLineToPoint:CGPointMake(13.44, 0.77)];
                    [maestroPath4 addLineToPoint:CGPointMake(13.44, 0)];
                    [maestroPath4 addLineToPoint:CGPointMake(13.99, 0)];
                    [maestroPath4 addLineToPoint:CGPointMake(13.99, 0.77)];
                    [maestroPath4 addLineToPoint:CGPointMake(14.87, 0.77)];
                    [maestroPath4 addLineToPoint:CGPointMake(14.87, 1.28)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(16.75, 0.69)];
                    [maestroPath4 addCurveToPoint:CGPointMake(17.14, 0.77) controlPoint1:CGPointMake(16.88, 0.69) controlPoint2:CGPointMake(17.01, 0.72)];
                    [maestroPath4 addLineToPoint:CGPointMake(16.99, 1.3)];
                    [maestroPath4 addCurveToPoint:CGPointMake(16.65, 1.25) controlPoint1:CGPointMake(16.88, 1.25) controlPoint2:CGPointMake(16.75, 1.25)];
                    [maestroPath4 addCurveToPoint:CGPointMake(16.13, 1.92) controlPoint1:CGPointMake(16.28, 1.25) controlPoint2:CGPointMake(16.13, 1.49)];
                    [maestroPath4 addLineToPoint:CGPointMake(16.13, 3.35)];
                    [maestroPath4 addLineToPoint:CGPointMake(15.58, 3.35)];
                    [maestroPath4 addLineToPoint:CGPointMake(15.58, 0.83)];
                    [maestroPath4 addLineToPoint:CGPointMake(16.13, 0.83)];
                    [maestroPath4 addLineToPoint:CGPointMake(16.13, 1.14)];
                    [maestroPath4 addCurveToPoint:CGPointMake(16.75, 0.69) controlPoint1:CGPointMake(16.26, 0.85) controlPoint2:CGPointMake(16.49, 0.72)];
                    [maestroPath4 closePath];
                    [maestroPath4 moveToPoint:CGPointMake(16.75, 0.69)];
                    CGContextSaveGState(context);
                    CGContextTranslateCTM(context, 12.51, 22.41);
                    [UIColor.blackColor setFill];
                    [maestroPath4 fill];
                    CGContextRestoreGState(context);
                    
                    //! maestroPath3
                    UIBezierPath *maestroPath3 = [UIBezierPath bezierPath];
                    [maestroPath3 moveToPoint:CGPointMake(8.22, 0)];
                    [maestroPath3 addLineToPoint:CGPointZero];
                    [maestroPath3 addLineToPoint:CGPointMake(0, 15.07)];
                    [maestroPath3 addLineToPoint:CGPointMake(8.22, 15.07)];
                    [maestroPath3 addLineToPoint:CGPointMake(8.22, 0)];
                    [maestroPath3 closePath];
                    [maestroPath3 moveToPoint:CGPointMake(8.22, 0)];
                    CGContextSaveGState(context);
                    CGContextTranslateCTM(context, 18.38, 3.77);
                    [[UIColor colorWithHue:0.673 saturation:0.401 brightness:0.753 alpha:1] setFill];
                    [maestroPath3 fill];
                    CGContextRestoreGState(context);
                    
                    //! maestroPath2
                    UIBezierPath *maestroPath2 = [UIBezierPath bezierPath];
                    [maestroPath2 moveToPoint:CGPointMake(11.59, 9.59)];
                    [maestroPath2 addCurveToPoint:CGPointMake(15.19, 2.05) controlPoint1:CGPointMake(11.59, 6.66) controlPoint2:CGPointMake(12.92, 3.86)];
                    [maestroPath2 addCurveToPoint:CGPointMake(2.01, 3.68) controlPoint1:CGPointMake(11.12, -1.22) controlPoint2:CGPointMake(5.19, -0.5)];
                    [maestroPath2 addCurveToPoint:CGPointMake(3.6, 17.12) controlPoint1:CGPointMake(-1.2, 7.83) controlPoint2:CGPointMake(-0.49, 13.87)];
                    [maestroPath2 addCurveToPoint:CGPointMake(15.21, 17.12) controlPoint1:CGPointMake(7.02, 19.86) controlPoint2:CGPointMake(11.8, 19.86)];
                    [maestroPath2 addCurveToPoint:CGPointMake(11.59, 9.59) controlPoint1:CGPointMake(12.92, 15.31) controlPoint2:CGPointMake(11.59, 12.54)];
                    [maestroPath2 closePath];
                    [maestroPath2 moveToPoint:CGPointMake(11.59, 9.59)];
                    CGContextSaveGState(context);
                    CGContextTranslateCTM(context, 7.31, 1.72);
                    [[UIColor colorWithHue:0.981 saturation:1 brightness:0.922 alpha:1] setFill];
                    [maestroPath2 fill];
                    CGContextRestoreGState(context);
                    
                    //! maestroPath1
                    UIBezierPath *maestroPath1 = [UIBezierPath bezierPath];
                    [maestroPath1 moveToPoint:CGPointMake(15.19, 9.59)];
                    [maestroPath1 addCurveToPoint:CGPointMake(5.79, 19.17) controlPoint1:CGPointMake(15.19, 14.89) controlPoint2:CGPointMake(10.99, 19.17)];
                    [maestroPath1 addCurveToPoint:CGPointMake(0, 17.12) controlPoint1:CGPointMake(3.68, 19.17) controlPoint2:CGPointMake(1.64, 18.45)];
                    [maestroPath1 addCurveToPoint:CGPointMake(1.59, 3.68) controlPoint1:CGPointMake(4.07, 13.87) controlPoint2:CGPointMake(4.78, 7.83)];
                    [maestroPath1 addCurveToPoint:CGPointMake(0, 2.05) controlPoint1:CGPointMake(1.12, 3.06) controlPoint2:CGPointMake(0.6, 2.53)];
                    [maestroPath1 addCurveToPoint:CGPointMake(13.2, 3.68) controlPoint1:CGPointMake(4.07, -1.22) controlPoint2:CGPointMake(9.99, -0.5)];
                    [maestroPath1 addCurveToPoint:CGPointMake(15.19, 9.59) controlPoint1:CGPointMake(14.48, 5.35) controlPoint2:CGPointMake(15.19, 7.46)];
                    [maestroPath1 closePath];
                    [maestroPath1 moveToPoint:CGPointMake(15.19, 9.59)];
                    CGContextSaveGState(context);
                    CGContextTranslateCTM(context, 22.5, 1.72);
                    [[UIColor colorWithHue:0.546 saturation:1 brightness:0.875 alpha:1] setFill];
                    [maestroPath1 fill];
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
