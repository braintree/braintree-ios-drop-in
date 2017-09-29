#import "BTUIKLargeMaestroVectorArtView.h"

@implementation BTUIKLargeMaestroVectorArtView

- (void)drawArt {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //! Group
    {
        CGContextSaveGState(context);
        
        //! MaestroLarge
        {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 0, 15);
            
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
                        [maestroSpacer moveToPoint:CGPointMake(76.67, 49)];
                        [maestroSpacer addLineToPoint:CGPointMake(76.67, 49)];
                        [maestroSpacer addLineToPoint:CGPointMake(3.33, 49)];
                        [maestroSpacer addLineToPoint:CGPointMake(3.33, 49)];
                        [maestroSpacer addCurveToPoint:CGPointMake(0, 45.73) controlPoint1:CGPointMake(1.5, 49) controlPoint2:CGPointMake(0, 47.53)];
                        [maestroSpacer addLineToPoint:CGPointMake(0, 45.73)];
                        [maestroSpacer addLineToPoint:CGPointMake(0, 3.27)];
                        [maestroSpacer addLineToPoint:CGPointMake(0, 3.27)];
                        [maestroSpacer addCurveToPoint:CGPointMake(3.33, 0) controlPoint1:CGPointMake(0, 1.47) controlPoint2:CGPointMake(1.5, 0)];
                        [maestroSpacer addLineToPoint:CGPointMake(3.33, 0)];
                        [maestroSpacer addLineToPoint:CGPointMake(76.67, 0)];
                        [maestroSpacer addLineToPoint:CGPointMake(76.67, 0)];
                        [maestroSpacer addCurveToPoint:CGPointMake(80, 3.27) controlPoint1:CGPointMake(78.5, 0) controlPoint2:CGPointMake(80, 1.47)];
                        [maestroSpacer addLineToPoint:CGPointMake(80, 3.27)];
                        [maestroSpacer addLineToPoint:CGPointMake(80, 45.73)];
                        [maestroSpacer addLineToPoint:CGPointMake(80, 45.73)];
                        [maestroSpacer addCurveToPoint:CGPointMake(76.67, 49) controlPoint1:CGPointMake(80, 47.53) controlPoint2:CGPointMake(78.5, 49)];
                        [maestroSpacer closePath];
                        [maestroSpacer moveToPoint:CGPointMake(76.67, 49)];
                        CGContextSaveGState(context);
                        [UIColor.whiteColor setFill];
                        [maestroSpacer fill];
                        CGContextRestoreGState(context);
                        
                        //! maestroPath4
                        UIBezierPath *maestroPath4 = [UIBezierPath bezierPath];
                        [maestroPath4 moveToPoint:CGPointMake(7.1, 5.87)];
                        [maestroPath4 addLineToPoint:CGPointMake(7.1, 3.03)];
                        [maestroPath4 addCurveToPoint:CGPointMake(5.57, 1.23) controlPoint1:CGPointMake(7.14, 2.08) controlPoint2:CGPointMake(6.49, 1.28)];
                        [maestroPath4 addLineToPoint:CGPointMake(5.33, 1.23)];
                        [maestroPath4 addCurveToPoint:CGPointMake(3.76, 2.04) controlPoint1:CGPointMake(4.73, 1.18) controlPoint2:CGPointMake(4.13, 1.51)];
                        [maestroPath4 addCurveToPoint:CGPointMake(2.27, 1.23) controlPoint1:CGPointMake(3.43, 1.51) controlPoint2:CGPointMake(2.88, 1.18)];
                        [maestroPath4 addCurveToPoint:CGPointMake(0.97, 1.89) controlPoint1:CGPointMake(1.76, 1.18) controlPoint2:CGPointMake(1.25, 1.47)];
                        [maestroPath4 addLineToPoint:CGPointMake(0.97, 1.33)];
                        [maestroPath4 addLineToPoint:CGPointMake(0, 1.33)];
                        [maestroPath4 addLineToPoint:CGPointMake(0, 5.82)];
                        [maestroPath4 addLineToPoint:CGPointMake(0.97, 5.82)];
                        [maestroPath4 addLineToPoint:CGPointMake(0.97, 3.41)];
                        [maestroPath4 addCurveToPoint:CGPointMake(1.86, 2.22) controlPoint1:CGPointMake(0.88, 2.84) controlPoint2:CGPointMake(1.3, 2.32)];
                        [maestroPath4 addLineToPoint:CGPointMake(2.04, 2.22)];
                        [maestroPath4 addCurveToPoint:CGPointMake(3.02, 3.41) controlPoint1:CGPointMake(2.69, 2.22) controlPoint2:CGPointMake(3.02, 2.65)];
                        [maestroPath4 addLineToPoint:CGPointMake(3.02, 5.92)];
                        [maestroPath4 addLineToPoint:CGPointMake(3.99, 5.92)];
                        [maestroPath4 addLineToPoint:CGPointMake(3.99, 3.41)];
                        [maestroPath4 addCurveToPoint:CGPointMake(4.87, 2.22) controlPoint1:CGPointMake(3.9, 2.84) controlPoint2:CGPointMake(4.31, 2.27)];
                        [maestroPath4 addLineToPoint:CGPointMake(5.06, 2.22)];
                        [maestroPath4 addCurveToPoint:CGPointMake(6.03, 3.41) controlPoint1:CGPointMake(5.71, 2.22) controlPoint2:CGPointMake(6.03, 2.65)];
                        [maestroPath4 addLineToPoint:CGPointMake(6.03, 5.92)];
                        [maestroPath4 addLineToPoint:CGPointMake(7.1, 5.87)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(12.52, 3.64)];
                        [maestroPath4 addLineToPoint:CGPointMake(12.52, 1.37)];
                        [maestroPath4 addLineToPoint:CGPointMake(11.55, 1.37)];
                        [maestroPath4 addLineToPoint:CGPointMake(11.55, 1.94)];
                        [maestroPath4 addCurveToPoint:CGPointMake(10.16, 1.28) controlPoint1:CGPointMake(11.23, 1.51) controlPoint2:CGPointMake(10.72, 1.28)];
                        [maestroPath4 addCurveToPoint:CGPointMake(7.84, 3.64) controlPoint1:CGPointMake(8.86, 1.28) controlPoint2:CGPointMake(7.84, 2.32)];
                        [maestroPath4 addCurveToPoint:CGPointMake(10.16, 6.01) controlPoint1:CGPointMake(7.84, 4.97) controlPoint2:CGPointMake(8.86, 6.01)];
                        [maestroPath4 addCurveToPoint:CGPointMake(11.55, 5.35) controlPoint1:CGPointMake(10.72, 6.01) controlPoint2:CGPointMake(11.23, 5.77)];
                        [maestroPath4 addLineToPoint:CGPointMake(11.55, 5.92)];
                        [maestroPath4 addLineToPoint:CGPointMake(12.52, 5.92)];
                        [maestroPath4 addLineToPoint:CGPointMake(12.52, 3.64)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(8.95, 3.64)];
                        [maestroPath4 addCurveToPoint:CGPointMake(10.39, 2.37) controlPoint1:CGPointMake(9, 2.89) controlPoint2:CGPointMake(9.65, 2.32)];
                        [maestroPath4 addCurveToPoint:CGPointMake(11.64, 3.83) controlPoint1:CGPointMake(11.13, 2.41) controlPoint2:CGPointMake(11.69, 3.08)];
                        [maestroPath4 addCurveToPoint:CGPointMake(10.3, 5.11) controlPoint1:CGPointMake(11.6, 4.54) controlPoint2:CGPointMake(11.04, 5.11)];
                        [maestroPath4 addCurveToPoint:CGPointMake(8.95, 3.79) controlPoint1:CGPointMake(9.56, 5.11) controlPoint2:CGPointMake(8.95, 4.54)];
                        [maestroPath4 addCurveToPoint:CGPointMake(8.95, 3.64) controlPoint1:CGPointMake(8.91, 3.69) controlPoint2:CGPointMake(8.91, 3.69)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(33.12, 1.28)];
                        [maestroPath4 addCurveToPoint:CGPointMake(34.05, 1.47) controlPoint1:CGPointMake(33.45, 1.28) controlPoint2:CGPointMake(33.77, 1.33)];
                        [maestroPath4 addCurveToPoint:CGPointMake(34.79, 1.99) controlPoint1:CGPointMake(34.33, 1.56) controlPoint2:CGPointMake(34.61, 1.75)];
                        [maestroPath4 addCurveToPoint:CGPointMake(35.3, 2.75) controlPoint1:CGPointMake(35.02, 2.22) controlPoint2:CGPointMake(35.16, 2.46)];
                        [maestroPath4 addCurveToPoint:CGPointMake(35.3, 4.64) controlPoint1:CGPointMake(35.53, 3.36) controlPoint2:CGPointMake(35.53, 4.02)];
                        [maestroPath4 addCurveToPoint:CGPointMake(34.79, 5.4) controlPoint1:CGPointMake(35.21, 4.92) controlPoint2:CGPointMake(35.02, 5.16)];
                        [maestroPath4 addCurveToPoint:CGPointMake(34.05, 5.92) controlPoint1:CGPointMake(34.56, 5.63) controlPoint2:CGPointMake(34.33, 5.77)];
                        [maestroPath4 addCurveToPoint:CGPointMake(32.15, 5.92) controlPoint1:CGPointMake(33.45, 6.15) controlPoint2:CGPointMake(32.75, 6.15)];
                        [maestroPath4 addCurveToPoint:CGPointMake(31.41, 5.4) controlPoint1:CGPointMake(31.87, 5.82) controlPoint2:CGPointMake(31.59, 5.63)];
                        [maestroPath4 addCurveToPoint:CGPointMake(30.89, 4.64) controlPoint1:CGPointMake(31.17, 5.16) controlPoint2:CGPointMake(31.03, 4.92)];
                        [maestroPath4 addCurveToPoint:CGPointMake(30.89, 2.75) controlPoint1:CGPointMake(30.66, 4.02) controlPoint2:CGPointMake(30.66, 3.36)];
                        [maestroPath4 addCurveToPoint:CGPointMake(31.41, 1.99) controlPoint1:CGPointMake(30.99, 2.46) controlPoint2:CGPointMake(31.17, 2.22)];
                        [maestroPath4 addCurveToPoint:CGPointMake(32.15, 1.47) controlPoint1:CGPointMake(31.64, 1.75) controlPoint2:CGPointMake(31.87, 1.61)];
                        [maestroPath4 addCurveToPoint:CGPointMake(33.12, 1.28) controlPoint1:CGPointMake(32.47, 1.33) controlPoint2:CGPointMake(32.8, 1.23)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(33.12, 2.22)];
                        [maestroPath4 addCurveToPoint:CGPointMake(32.56, 2.32) controlPoint1:CGPointMake(32.94, 2.22) controlPoint2:CGPointMake(32.75, 2.27)];
                        [maestroPath4 addCurveToPoint:CGPointMake(32.1, 2.6) controlPoint1:CGPointMake(32.38, 2.37) controlPoint2:CGPointMake(32.24, 2.51)];
                        [maestroPath4 addCurveToPoint:CGPointMake(31.82, 3.08) controlPoint1:CGPointMake(31.96, 2.75) controlPoint2:CGPointMake(31.87, 2.89)];
                        [maestroPath4 addCurveToPoint:CGPointMake(31.82, 4.26) controlPoint1:CGPointMake(31.68, 3.46) controlPoint2:CGPointMake(31.68, 3.88)];
                        [maestroPath4 addCurveToPoint:CGPointMake(32.1, 4.73) controlPoint1:CGPointMake(31.87, 4.45) controlPoint2:CGPointMake(32.01, 4.59)];
                        [maestroPath4 addCurveToPoint:CGPointMake(32.56, 5.02) controlPoint1:CGPointMake(32.24, 4.88) controlPoint2:CGPointMake(32.38, 4.97)];
                        [maestroPath4 addCurveToPoint:CGPointMake(33.68, 5.02) controlPoint1:CGPointMake(32.94, 5.16) controlPoint2:CGPointMake(33.31, 5.16)];
                        [maestroPath4 addCurveToPoint:CGPointMake(34.14, 4.73) controlPoint1:CGPointMake(33.86, 4.97) controlPoint2:CGPointMake(34, 4.83)];
                        [maestroPath4 addCurveToPoint:CGPointMake(34.42, 4.26) controlPoint1:CGPointMake(34.28, 4.59) controlPoint2:CGPointMake(34.37, 4.45)];
                        [maestroPath4 addCurveToPoint:CGPointMake(34.42, 3.08) controlPoint1:CGPointMake(34.56, 3.88) controlPoint2:CGPointMake(34.56, 3.46)];
                        [maestroPath4 addCurveToPoint:CGPointMake(34.14, 2.6) controlPoint1:CGPointMake(34.37, 2.89) controlPoint2:CGPointMake(34.23, 2.75)];
                        [maestroPath4 addCurveToPoint:CGPointMake(33.68, 2.32) controlPoint1:CGPointMake(34, 2.46) controlPoint2:CGPointMake(33.86, 2.37)];
                        [maestroPath4 addCurveToPoint:CGPointMake(33.12, 2.22) controlPoint1:CGPointMake(33.49, 2.22) controlPoint2:CGPointMake(33.31, 2.18)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(17.77, 3.64)];
                        [maestroPath4 addCurveToPoint:CGPointMake(15.68, 1.28) controlPoint1:CGPointMake(17.77, 2.22) controlPoint2:CGPointMake(16.89, 1.28)];
                        [maestroPath4 addCurveToPoint:CGPointMake(13.41, 3.69) controlPoint1:CGPointMake(14.38, 1.28) controlPoint2:CGPointMake(13.36, 2.37)];
                        [maestroPath4 addCurveToPoint:CGPointMake(15.77, 6.01) controlPoint1:CGPointMake(13.45, 5.02) controlPoint2:CGPointMake(14.47, 6.06)];
                        [maestroPath4 addCurveToPoint:CGPointMake(17.58, 5.4) controlPoint1:CGPointMake(16.42, 6.01) controlPoint2:CGPointMake(17.07, 5.82)];
                        [maestroPath4 addLineToPoint:CGPointMake(17.12, 4.69)];
                        [maestroPath4 addCurveToPoint:CGPointMake(15.82, 5.16) controlPoint1:CGPointMake(16.75, 4.97) controlPoint2:CGPointMake(16.28, 5.16)];
                        [maestroPath4 addCurveToPoint:CGPointMake(14.47, 4.07) controlPoint1:CGPointMake(15.17, 5.21) controlPoint2:CGPointMake(14.57, 4.73)];
                        [maestroPath4 addLineToPoint:CGPointMake(17.77, 4.07)];
                        [maestroPath4 addLineToPoint:CGPointMake(17.77, 3.64)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(14.47, 3.22)];
                        [maestroPath4 addCurveToPoint:CGPointMake(15.63, 2.13) controlPoint1:CGPointMake(14.52, 2.6) controlPoint2:CGPointMake(15.03, 2.13)];
                        [maestroPath4 addCurveToPoint:CGPointMake(16.75, 3.22) controlPoint1:CGPointMake(16.24, 2.13) controlPoint2:CGPointMake(16.75, 2.6)];
                        [maestroPath4 addLineToPoint:CGPointMake(14.47, 3.22)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(21.8, 2.51)];
                        [maestroPath4 addCurveToPoint:CGPointMake(20.41, 2.13) controlPoint1:CGPointMake(21.39, 2.27) controlPoint2:CGPointMake(20.92, 2.13)];
                        [maestroPath4 addCurveToPoint:CGPointMake(19.58, 2.65) controlPoint1:CGPointMake(19.9, 2.13) controlPoint2:CGPointMake(19.58, 2.32)];
                        [maestroPath4 addCurveToPoint:CGPointMake(20.32, 3.08) controlPoint1:CGPointMake(19.58, 2.98) controlPoint2:CGPointMake(19.9, 3.03)];
                        [maestroPath4 addLineToPoint:CGPointMake(20.78, 3.12)];
                        [maestroPath4 addCurveToPoint:CGPointMake(22.31, 4.5) controlPoint1:CGPointMake(21.76, 3.27) controlPoint2:CGPointMake(22.31, 3.69)];
                        [maestroPath4 addCurveToPoint:CGPointMake(20.27, 5.96) controlPoint1:CGPointMake(22.31, 5.3) controlPoint2:CGPointMake(21.57, 5.96)];
                        [maestroPath4 addCurveToPoint:CGPointMake(18.37, 5.4) controlPoint1:CGPointMake(19.58, 5.96) controlPoint2:CGPointMake(18.93, 5.77)];
                        [maestroPath4 addLineToPoint:CGPointMake(18.83, 4.64)];
                        [maestroPath4 addCurveToPoint:CGPointMake(20.32, 5.11) controlPoint1:CGPointMake(19.25, 4.97) controlPoint2:CGPointMake(19.76, 5.11)];
                        [maestroPath4 addCurveToPoint:CGPointMake(21.34, 4.54) controlPoint1:CGPointMake(20.97, 5.11) controlPoint2:CGPointMake(21.34, 4.92)];
                        [maestroPath4 addCurveToPoint:CGPointMake(20.55, 4.07) controlPoint1:CGPointMake(21.34, 4.31) controlPoint2:CGPointMake(21.11, 4.17)];
                        [maestroPath4 addLineToPoint:CGPointMake(20.09, 4.02)];
                        [maestroPath4 addCurveToPoint:CGPointMake(18.56, 2.7) controlPoint1:CGPointMake(19.11, 3.88) controlPoint2:CGPointMake(18.56, 3.41)];
                        [maestroPath4 addCurveToPoint:CGPointMake(20.41, 1.23) controlPoint1:CGPointMake(18.56, 1.8) controlPoint2:CGPointMake(19.3, 1.23)];
                        [maestroPath4 addCurveToPoint:CGPointMake(22.22, 1.7) controlPoint1:CGPointMake(21.06, 1.23) controlPoint2:CGPointMake(21.66, 1.37)];
                        [maestroPath4 addLineToPoint:CGPointMake(21.8, 2.51)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(26.44, 2.27)];
                        [maestroPath4 addLineToPoint:CGPointMake(24.86, 2.27)];
                        [maestroPath4 addLineToPoint:CGPointMake(24.86, 4.31)];
                        [maestroPath4 addCurveToPoint:CGPointMake(25.51, 5.06) controlPoint1:CGPointMake(24.86, 4.78) controlPoint2:CGPointMake(25, 5.06)];
                        [maestroPath4 addCurveToPoint:CGPointMake(26.35, 4.83) controlPoint1:CGPointMake(25.79, 5.06) controlPoint2:CGPointMake(26.12, 4.97)];
                        [maestroPath4 addLineToPoint:CGPointMake(26.63, 5.68)];
                        [maestroPath4 addCurveToPoint:CGPointMake(25.42, 6.01) controlPoint1:CGPointMake(26.26, 5.92) controlPoint2:CGPointMake(25.84, 6.01)];
                        [maestroPath4 addCurveToPoint:CGPointMake(23.89, 4.35) controlPoint1:CGPointMake(24.26, 6.01) controlPoint2:CGPointMake(23.89, 5.4)];
                        [maestroPath4 addLineToPoint:CGPointMake(23.89, 2.27)];
                        [maestroPath4 addLineToPoint:CGPointMake(23.01, 2.27)];
                        [maestroPath4 addLineToPoint:CGPointMake(23.01, 1.37)];
                        [maestroPath4 addLineToPoint:CGPointMake(23.89, 1.37)];
                        [maestroPath4 addLineToPoint:CGPointMake(23.89, 0)];
                        [maestroPath4 addLineToPoint:CGPointMake(24.86, 0)];
                        [maestroPath4 addLineToPoint:CGPointMake(24.86, 1.37)];
                        [maestroPath4 addLineToPoint:CGPointMake(26.44, 1.37)];
                        [maestroPath4 addLineToPoint:CGPointMake(26.44, 2.27)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(29.78, 1.23)];
                        [maestroPath4 addCurveToPoint:CGPointMake(30.48, 1.37) controlPoint1:CGPointMake(30.01, 1.23) controlPoint2:CGPointMake(30.25, 1.28)];
                        [maestroPath4 addLineToPoint:CGPointMake(30.2, 2.32)];
                        [maestroPath4 addCurveToPoint:CGPointMake(29.6, 2.22) controlPoint1:CGPointMake(30.01, 2.22) controlPoint2:CGPointMake(29.78, 2.22)];
                        [maestroPath4 addCurveToPoint:CGPointMake(28.67, 3.41) controlPoint1:CGPointMake(28.95, 2.22) controlPoint2:CGPointMake(28.67, 2.65)];
                        [maestroPath4 addLineToPoint:CGPointMake(28.67, 5.96)];
                        [maestroPath4 addLineToPoint:CGPointMake(27.69, 5.96)];
                        [maestroPath4 addLineToPoint:CGPointMake(27.69, 1.47)];
                        [maestroPath4 addLineToPoint:CGPointMake(28.67, 1.47)];
                        [maestroPath4 addLineToPoint:CGPointMake(28.67, 2.04)];
                        [maestroPath4 addCurveToPoint:CGPointMake(29.78, 1.23) controlPoint1:CGPointMake(28.9, 1.51) controlPoint2:CGPointMake(29.32, 1.28)];
                        [maestroPath4 closePath];
                        [maestroPath4 moveToPoint:CGPointMake(29.78, 1.23)];
                        CGContextSaveGState(context);
                        CGContextTranslateCTM(context, 22.24, 39.84);
                        [UIColor.blackColor setFill];
                        [maestroPath4 fill];
                        CGContextRestoreGState(context);
                        
                        //! maestroPath3
                        UIBezierPath *maestroPath3 = [UIBezierPath bezierPath];
                        [maestroPath3 moveToPoint:CGPointMake(14.61, 0)];
                        [maestroPath3 addLineToPoint:CGPointZero];
                        [maestroPath3 addLineToPoint:CGPointMake(0, 26.79)];
                        [maestroPath3 addLineToPoint:CGPointMake(14.61, 26.79)];
                        [maestroPath3 addLineToPoint:CGPointMake(14.61, 0)];
                        [maestroPath3 closePath];
                        [maestroPath3 moveToPoint:CGPointMake(14.61, 0)];
                        CGContextSaveGState(context);
                        CGContextTranslateCTM(context, 32.67, 6.71);
                        [[UIColor colorWithHue:0.673 saturation:0.401 brightness:0.753 alpha:1] setFill];
                        [maestroPath3 fill];
                        CGContextRestoreGState(context);
                        
                        //! maestroPath2
                        UIBezierPath *maestroPath2 = [UIBezierPath bezierPath];
                        [maestroPath2 moveToPoint:CGPointMake(20.6, 17.04)];
                        [maestroPath2 addCurveToPoint:CGPointMake(27, 3.65) controlPoint1:CGPointMake(20.6, 11.84) controlPoint2:CGPointMake(22.97, 6.87)];
                        [maestroPath2 addCurveToPoint:CGPointMake(3.58, 6.54) controlPoint1:CGPointMake(19.77, -2.17) controlPoint2:CGPointMake(9.24, -0.9)];
                        [maestroPath2 addCurveToPoint:CGPointMake(6.41, 30.44) controlPoint1:CGPointMake(-2.13, 13.92) controlPoint2:CGPointMake(-0.88, 24.66)];
                        [maestroPath2 addCurveToPoint:CGPointMake(27.05, 30.44) controlPoint1:CGPointMake(12.48, 35.31) controlPoint2:CGPointMake(20.97, 35.31)];
                        [maestroPath2 addCurveToPoint:CGPointMake(20.6, 17.04) controlPoint1:CGPointMake(22.97, 27.22) controlPoint2:CGPointMake(20.6, 22.3)];
                        [maestroPath2 closePath];
                        [maestroPath2 moveToPoint:CGPointMake(20.6, 17.04)];
                        CGContextSaveGState(context);
                        CGContextTranslateCTM(context, 13, 3.06);
                        [[UIColor colorWithHue:0.981 saturation:1 brightness:0.922 alpha:1] setFill];
                        [maestroPath2 fill];
                        CGContextRestoreGState(context);
                        
                        //! maestroPath1
                        UIBezierPath *maestroPath1 = [UIBezierPath bezierPath];
                        [maestroPath1 moveToPoint:CGPointMake(27, 17.04)];
                        [maestroPath1 addCurveToPoint:CGPointMake(10.3, 34.08) controlPoint1:CGPointMake(27, 26.46) controlPoint2:CGPointMake(19.53, 34.08)];
                        [maestroPath1 addCurveToPoint:CGPointMake(0, 30.44) controlPoint1:CGPointMake(6.54, 34.08) controlPoint2:CGPointMake(2.92, 32.81)];
                        [maestroPath1 addCurveToPoint:CGPointMake(2.83, 6.54) controlPoint1:CGPointMake(7.24, 24.66) controlPoint2:CGPointMake(8.49, 13.92)];
                        [maestroPath1 addCurveToPoint:CGPointMake(0, 3.65) controlPoint1:CGPointMake(1.99, 5.45) controlPoint2:CGPointMake(1.07, 4.5)];
                        [maestroPath1 addCurveToPoint:CGPointMake(23.47, 6.54) controlPoint1:CGPointMake(7.24, -2.17) controlPoint2:CGPointMake(17.77, -0.9)];
                        [maestroPath1 addCurveToPoint:CGPointMake(27, 17.04) controlPoint1:CGPointMake(25.75, 9.52) controlPoint2:CGPointMake(27, 13.26)];
                        [maestroPath1 closePath];
                        [maestroPath1 moveToPoint:CGPointMake(27, 17.04)];
                        CGContextSaveGState(context);
                        CGContextTranslateCTM(context, 40, 3.06);
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
        
        CGContextRestoreGState(context);
    }
}
@end
