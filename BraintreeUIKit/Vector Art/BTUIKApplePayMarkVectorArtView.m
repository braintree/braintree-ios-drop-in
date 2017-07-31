#import "BTUIKApplePayMarkVectorArtView.h"

@implementation BTUIKApplePayMarkVectorArtView

- (void)drawArt {
    //! General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    {
        CGContextSaveGState(context);

        //! Group 3
        {
            CGContextSaveGState(context);

            //! Clip 2
            UIBezierPath * clip2 = [UIBezierPath bezierPath];
            [clip2 moveToPoint:CGPointMake(0, 28.72)];
            [clip2 addLineToPoint:CGPointZero];
            [clip2 addLineToPoint:CGPointMake(44.85, 0)];
            [clip2 addLineToPoint:CGPointMake(44.85, 28.72)];
            [clip2 addLineToPoint:CGPointMake(0, 28.72)];
            [clip2 closePath];
            [clip2 moveToPoint:CGPointMake(0, 28.72)];
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, 0.02, 0.01);
            CGContextRestoreGState(context);

            //! Clip 2 (Outline Mask)
            CGContextSaveGState(context);
            [clip2 applyTransform:CGAffineTransformMakeTranslation(0.02, 0.01)];
            [clip2 addClip];

            //! Fill 1
            UIBezierPath * fill1 = [UIBezierPath bezierPath];
            [fill1 moveToPoint:CGPointMake(40.85, 0)];
            [fill1 addLineToPoint:CGPointMake(4.02, 0)];
            [fill1 addCurveToPoint:CGPointMake(3.56, 0) controlPoint1:CGPointMake(3.86, 0) controlPoint2:CGPointMake(3.71, 0)];
            [fill1 addCurveToPoint:CGPointMake(3.17, 0.01) controlPoint1:CGPointMake(3.43, 0) controlPoint2:CGPointMake(3.3, 0)];
            [fill1 addCurveToPoint:CGPointMake(2.33, 0.08) controlPoint1:CGPointMake(2.89, 0.01) controlPoint2:CGPointMake(2.6, 0.03)];
            [fill1 addCurveToPoint:CGPointMake(1.52, 0.35) controlPoint1:CGPointMake(2.04, 0.13) controlPoint2:CGPointMake(1.78, 0.21)];
            [fill1 addCurveToPoint:CGPointMake(0.84, 0.84) controlPoint1:CGPointMake(1.27, 0.47) controlPoint2:CGPointMake(1.04, 0.64)];
            [fill1 addCurveToPoint:CGPointMake(0.35, 1.52) controlPoint1:CGPointMake(0.64, 1.04) controlPoint2:CGPointMake(0.47, 1.27)];
            [fill1 addCurveToPoint:CGPointMake(0.08, 2.33) controlPoint1:CGPointMake(0.21, 1.78) controlPoint2:CGPointMake(0.13, 2.04)];
            [fill1 addCurveToPoint:CGPointMake(0.01, 3.17) controlPoint1:CGPointMake(0.03, 2.61) controlPoint2:CGPointMake(0.01, 2.89)];
            [fill1 addCurveToPoint:CGPointMake(0, 3.56) controlPoint1:CGPointMake(0, 3.3) controlPoint2:CGPointMake(0, 3.43)];
            [fill1 addCurveToPoint:CGPointMake(0, 4.02) controlPoint1:CGPointMake(-0, 3.71) controlPoint2:CGPointMake(0, 3.86)];
            [fill1 addLineToPoint:CGPointMake(0, 24.71)];
            [fill1 addCurveToPoint:CGPointMake(0, 25.17) controlPoint1:CGPointMake(0, 24.86) controlPoint2:CGPointMake(-0, 25.01)];
            [fill1 addCurveToPoint:CGPointMake(0.01, 25.56) controlPoint1:CGPointMake(0, 25.3) controlPoint2:CGPointMake(0, 25.43)];
            [fill1 addCurveToPoint:CGPointMake(0.08, 26.4) controlPoint1:CGPointMake(0.01, 25.84) controlPoint2:CGPointMake(0.03, 26.12)];
            [fill1 addCurveToPoint:CGPointMake(0.35, 27.2) controlPoint1:CGPointMake(0.13, 26.68) controlPoint2:CGPointMake(0.21, 26.94)];
            [fill1 addCurveToPoint:CGPointMake(0.84, 27.88) controlPoint1:CGPointMake(0.47, 27.45) controlPoint2:CGPointMake(0.64, 27.68)];
            [fill1 addCurveToPoint:CGPointMake(1.52, 28.38) controlPoint1:CGPointMake(1.04, 28.08) controlPoint2:CGPointMake(1.27, 28.25)];
            [fill1 addCurveToPoint:CGPointMake(2.33, 28.64) controlPoint1:CGPointMake(1.78, 28.51) controlPoint2:CGPointMake(2.04, 28.59)];
            [fill1 addCurveToPoint:CGPointMake(3.17, 28.72) controlPoint1:CGPointMake(2.6, 28.69) controlPoint2:CGPointMake(2.89, 28.71)];
            [fill1 addCurveToPoint:CGPointMake(3.56, 28.72) controlPoint1:CGPointMake(3.3, 28.72) controlPoint2:CGPointMake(3.43, 28.72)];
            [fill1 addCurveToPoint:CGPointMake(4.02, 28.73) controlPoint1:CGPointMake(3.71, 28.73) controlPoint2:CGPointMake(3.86, 28.73)];
            [fill1 addLineToPoint:CGPointMake(40.85, 28.73)];
            [fill1 addCurveToPoint:CGPointMake(41.31, 28.72) controlPoint1:CGPointMake(41.01, 28.73) controlPoint2:CGPointMake(41.16, 28.73)];
            [fill1 addCurveToPoint:CGPointMake(41.7, 28.72) controlPoint1:CGPointMake(41.44, 28.72) controlPoint2:CGPointMake(41.57, 28.72)];
            [fill1 addCurveToPoint:CGPointMake(42.54, 28.64) controlPoint1:CGPointMake(41.98, 28.71) controlPoint2:CGPointMake(42.27, 28.69)];
            [fill1 addCurveToPoint:CGPointMake(43.35, 28.38) controlPoint1:CGPointMake(42.83, 28.59) controlPoint2:CGPointMake(43.09, 28.51)];
            [fill1 addCurveToPoint:CGPointMake(44.03, 27.88) controlPoint1:CGPointMake(43.6, 28.25) controlPoint2:CGPointMake(43.83, 28.08)];
            [fill1 addCurveToPoint:CGPointMake(44.52, 27.2) controlPoint1:CGPointMake(44.23, 27.68) controlPoint2:CGPointMake(44.4, 27.45)];
            [fill1 addCurveToPoint:CGPointMake(44.79, 26.4) controlPoint1:CGPointMake(44.66, 26.94) controlPoint2:CGPointMake(44.74, 26.68)];
            [fill1 addCurveToPoint:CGPointMake(44.86, 25.56) controlPoint1:CGPointMake(44.84, 26.12) controlPoint2:CGPointMake(44.86, 25.84)];
            [fill1 addCurveToPoint:CGPointMake(44.87, 25.17) controlPoint1:CGPointMake(44.87, 25.43) controlPoint2:CGPointMake(44.87, 25.3)];
            [fill1 addCurveToPoint:CGPointMake(44.87, 24.71) controlPoint1:CGPointMake(44.87, 25.01) controlPoint2:CGPointMake(44.87, 24.86)];
            [fill1 addLineToPoint:CGPointMake(44.87, 4.02)];
            [fill1 addCurveToPoint:CGPointMake(44.87, 3.56) controlPoint1:CGPointMake(44.87, 3.86) controlPoint2:CGPointMake(44.87, 3.71)];
            [fill1 addCurveToPoint:CGPointMake(44.86, 3.17) controlPoint1:CGPointMake(44.87, 3.43) controlPoint2:CGPointMake(44.87, 3.3)];
            [fill1 addCurveToPoint:CGPointMake(44.79, 2.33) controlPoint1:CGPointMake(44.86, 2.89) controlPoint2:CGPointMake(44.84, 2.61)];
            [fill1 addCurveToPoint:CGPointMake(44.52, 1.52) controlPoint1:CGPointMake(44.74, 2.04) controlPoint2:CGPointMake(44.66, 1.78)];
            [fill1 addCurveToPoint:CGPointMake(44.03, 0.84) controlPoint1:CGPointMake(44.4, 1.27) controlPoint2:CGPointMake(44.23, 1.04)];
            [fill1 addCurveToPoint:CGPointMake(43.35, 0.35) controlPoint1:CGPointMake(43.83, 0.64) controlPoint2:CGPointMake(43.6, 0.47)];
            [fill1 addCurveToPoint:CGPointMake(42.54, 0.08) controlPoint1:CGPointMake(43.09, 0.21) controlPoint2:CGPointMake(42.83, 0.13)];
            [fill1 addCurveToPoint:CGPointMake(41.7, 0.01) controlPoint1:CGPointMake(42.27, 0.03) controlPoint2:CGPointMake(41.98, 0.01)];
            [fill1 addCurveToPoint:CGPointMake(41.31, 0) controlPoint1:CGPointMake(41.57, 0) controlPoint2:CGPointMake(41.44, 0)];
            [fill1 addCurveToPoint:CGPointMake(40.85, 0) controlPoint1:CGPointMake(41.16, 0) controlPoint2:CGPointMake(41.01, 0)];
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, -0, 0.01);
            fill1.usesEvenOddFillRule = YES;
            [[UIColor colorWithHue:0.045 saturation:0.059 brightness:0.104 alpha:1] setFill];
            [fill1 fill];
            CGContextRestoreGState(context);

            CGContextRestoreGState(context);
            // End Clip 2 (Outline Mask)

            CGContextRestoreGState(context);
        }

        //! Fill 4
        UIBezierPath * fill4 = [UIBezierPath bezierPath];
        [fill4 moveToPoint:CGPointMake(39.89, 0)];
        [fill4 addLineToPoint:CGPointMake(40.35, 0)];
        [fill4 addCurveToPoint:CGPointMake(40.72, 0.01) controlPoint1:CGPointMake(40.47, 0) controlPoint2:CGPointMake(40.59, 0)];
        [fill4 addCurveToPoint:CGPointMake(41.42, 0.07) controlPoint1:CGPointMake(40.93, 0.01) controlPoint2:CGPointMake(41.18, 0.02)];
        [fill4 addCurveToPoint:CGPointMake(41.95, 0.24) controlPoint1:CGPointMake(41.62, 0.1) controlPoint2:CGPointMake(41.79, 0.16)];
        [fill4 addCurveToPoint:CGPointMake(42.39, 0.56) controlPoint1:CGPointMake(42.12, 0.32) controlPoint2:CGPointMake(42.26, 0.43)];
        [fill4 addCurveToPoint:CGPointMake(42.71, 1) controlPoint1:CGPointMake(42.52, 0.69) controlPoint2:CGPointMake(42.63, 0.84)];
        [fill4 addCurveToPoint:CGPointMake(42.89, 1.54) controlPoint1:CGPointMake(42.8, 1.17) controlPoint2:CGPointMake(42.85, 1.33)];
        [fill4 addCurveToPoint:CGPointMake(42.95, 2.24) controlPoint1:CGPointMake(42.93, 1.77) controlPoint2:CGPointMake(42.94, 2.02)];
        [fill4 addCurveToPoint:CGPointMake(42.95, 2.61) controlPoint1:CGPointMake(42.95, 2.36) controlPoint2:CGPointMake(42.95, 2.48)];
        [fill4 addCurveToPoint:CGPointMake(42.96, 3.06) controlPoint1:CGPointMake(42.96, 2.76) controlPoint2:CGPointMake(42.96, 2.91)];
        [fill4 addLineToPoint:CGPointMake(42.96, 23.75)];
        [fill4 addCurveToPoint:CGPointMake(42.95, 24.21) controlPoint1:CGPointMake(42.96, 23.9) controlPoint2:CGPointMake(42.96, 24.05)];
        [fill4 addCurveToPoint:CGPointMake(42.95, 24.57) controlPoint1:CGPointMake(42.95, 24.33) controlPoint2:CGPointMake(42.95, 24.45)];
        [fill4 addCurveToPoint:CGPointMake(42.89, 25.27) controlPoint1:CGPointMake(42.94, 24.79) controlPoint2:CGPointMake(42.93, 25.04)];
        [fill4 addCurveToPoint:CGPointMake(42.71, 25.81) controlPoint1:CGPointMake(42.85, 25.48) controlPoint2:CGPointMake(42.8, 25.65)];
        [fill4 addCurveToPoint:CGPointMake(42.39, 26.25) controlPoint1:CGPointMake(42.63, 25.97) controlPoint2:CGPointMake(42.52, 26.12)];
        [fill4 addCurveToPoint:CGPointMake(41.95, 26.57) controlPoint1:CGPointMake(42.26, 26.38) controlPoint2:CGPointMake(42.12, 26.49)];
        [fill4 addCurveToPoint:CGPointMake(41.42, 26.74) controlPoint1:CGPointMake(41.79, 26.65) controlPoint2:CGPointMake(41.62, 26.71)];
        [fill4 addCurveToPoint:CGPointMake(40.72, 26.8) controlPoint1:CGPointMake(41.18, 26.79) controlPoint2:CGPointMake(40.92, 26.8)];
        [fill4 addCurveToPoint:CGPointMake(40.35, 26.81) controlPoint1:CGPointMake(40.6, 26.81) controlPoint2:CGPointMake(40.47, 26.81)];
        [fill4 addCurveToPoint:CGPointMake(39.89, 26.81) controlPoint1:CGPointMake(40.2, 26.81) controlPoint2:CGPointMake(40.05, 26.81)];
        [fill4 addLineToPoint:CGPointMake(3.06, 26.81)];
        [fill4 addLineToPoint:CGPointMake(3.05, 26.81)];
        [fill4 addCurveToPoint:CGPointMake(2.61, 26.81) controlPoint1:CGPointMake(2.91, 26.81) controlPoint2:CGPointMake(2.76, 26.81)];
        [fill4 addCurveToPoint:CGPointMake(2.24, 26.8) controlPoint1:CGPointMake(2.48, 26.81) controlPoint2:CGPointMake(2.36, 26.81)];
        [fill4 addCurveToPoint:CGPointMake(1.54, 26.74) controlPoint1:CGPointMake(2.04, 26.8) controlPoint2:CGPointMake(1.78, 26.79)];
        [fill4 addCurveToPoint:CGPointMake(1, 26.57) controlPoint1:CGPointMake(1.34, 26.71) controlPoint2:CGPointMake(1.16, 26.65)];
        [fill4 addCurveToPoint:CGPointMake(0.56, 26.25) controlPoint1:CGPointMake(0.84, 26.49) controlPoint2:CGPointMake(0.69, 26.38)];
        [fill4 addCurveToPoint:CGPointMake(0.24, 25.81) controlPoint1:CGPointMake(0.43, 26.12) controlPoint2:CGPointMake(0.32, 25.97)];
        [fill4 addCurveToPoint:CGPointMake(0.07, 25.27) controlPoint1:CGPointMake(0.16, 25.65) controlPoint2:CGPointMake(0.1, 25.48)];
        [fill4 addCurveToPoint:CGPointMake(0.01, 24.57) controlPoint1:CGPointMake(0.02, 25.04) controlPoint2:CGPointMake(0.01, 24.79)];
        [fill4 addCurveToPoint:CGPointMake(0, 24.2) controlPoint1:CGPointMake(0, 24.45) controlPoint2:CGPointMake(0, 24.33)];
        [fill4 addLineToPoint:CGPointMake(0, 23.84)];
        [fill4 addLineToPoint:CGPointMake(0, 2.97)];
        [fill4 addLineToPoint:CGPointMake(0, 2.61)];
        [fill4 addCurveToPoint:CGPointMake(0.01, 2.24) controlPoint1:CGPointMake(0, 2.48) controlPoint2:CGPointMake(0, 2.36)];
        [fill4 addCurveToPoint:CGPointMake(0.07, 1.54) controlPoint1:CGPointMake(0.01, 2.02) controlPoint2:CGPointMake(0.02, 1.77)];
        [fill4 addCurveToPoint:CGPointMake(0.24, 1) controlPoint1:CGPointMake(0.1, 1.34) controlPoint2:CGPointMake(0.16, 1.16)];
        [fill4 addCurveToPoint:CGPointMake(0.56, 0.56) controlPoint1:CGPointMake(0.32, 0.84) controlPoint2:CGPointMake(0.43, 0.69)];
        [fill4 addCurveToPoint:CGPointMake(1, 0.24) controlPoint1:CGPointMake(0.69, 0.43) controlPoint2:CGPointMake(0.84, 0.32)];
        [fill4 addCurveToPoint:CGPointMake(1.54, 0.07) controlPoint1:CGPointMake(1.16, 0.16) controlPoint2:CGPointMake(1.34, 0.1)];
        [fill4 addCurveToPoint:CGPointMake(2.24, 0.01) controlPoint1:CGPointMake(1.77, 0.02) controlPoint2:CGPointMake(2.02, 0.01)];
        [fill4 addCurveToPoint:CGPointMake(2.61, 0) controlPoint1:CGPointMake(2.36, 0) controlPoint2:CGPointMake(2.48, 0)];
        [fill4 addLineToPoint:CGPointMake(3.06, 0)];
        [fill4 addLineToPoint:CGPointMake(39.89, 0)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.96, 0.97);
        fill4.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.111 saturation:0.004 brightness:1 alpha:1] setFill];
        [fill4 fill];
        CGContextRestoreGState(context);

        //! Fill 5
        UIBezierPath * fill5 = [UIBezierPath bezierPath];
        [fill5 moveToPoint:CGPointMake(1.66, 1.77)];
        [fill5 addCurveToPoint:CGPointMake(2.23, 0) controlPoint1:CGPointMake(2.04, 1.29) controlPoint2:CGPointMake(2.3, 0.65)];
        [fill5 addCurveToPoint:CGPointMake(0.6, 0.84) controlPoint1:CGPointMake(1.67, 0.03) controlPoint2:CGPointMake(0.99, 0.37)];
        [fill5 addCurveToPoint:CGPointMake(0.01, 2.54) controlPoint1:CGPointMake(0.24, 1.25) controlPoint2:CGPointMake(-0.07, 1.92)];
        [fill5 addCurveToPoint:CGPointMake(1.66, 1.77) controlPoint1:CGPointMake(0.64, 2.6) controlPoint2:CGPointMake(1.26, 2.23)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 10.14, 7.94);
        fill5.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.045 saturation:0.059 brightness:0.104 alpha:1] setFill];
        [fill5 fill];
        CGContextRestoreGState(context);

        //! Fill 6
        UIBezierPath * fill6 = [UIBezierPath bezierPath];
        [fill6 moveToPoint:CGPointMake(6.67, 0)];
        [fill6 addCurveToPoint:CGPointMake(4.56, 0.52) controlPoint1:CGPointMake(5.76, -0.05) controlPoint2:CGPointMake(4.99, 0.52)];
        [fill6 addCurveToPoint:CGPointMake(2.74, 0.04) controlPoint1:CGPointMake(4.12, 0.52) controlPoint2:CGPointMake(3.46, 0.03)];
        [fill6 addCurveToPoint:CGPointMake(0.47, 1.43) controlPoint1:CGPointMake(1.81, 0.06) controlPoint2:CGPointMake(0.94, 0.59)];
        [fill6 addCurveToPoint:CGPointMake(1.16, 6.97) controlPoint1:CGPointMake(-0.51, 3.11) controlPoint2:CGPointMake(0.21, 5.6)];
        [fill6 addCurveToPoint:CGPointMake(2.9, 8.37) controlPoint1:CGPointMake(1.62, 7.65) controlPoint2:CGPointMake(2.17, 8.39)];
        [fill6 addCurveToPoint:CGPointMake(4.71, 7.92) controlPoint1:CGPointMake(3.59, 8.34) controlPoint2:CGPointMake(3.87, 7.92)];
        [fill6 addCurveToPoint:CGPointMake(6.52, 8.35) controlPoint1:CGPointMake(5.54, 7.92) controlPoint2:CGPointMake(5.79, 8.37)];
        [fill6 addCurveToPoint:CGPointMake(8.21, 7) controlPoint1:CGPointMake(7.28, 8.34) controlPoint2:CGPointMake(7.75, 7.68)];
        [fill6 addCurveToPoint:CGPointMake(8.97, 5.44) controlPoint1:CGPointMake(8.74, 6.23) controlPoint2:CGPointMake(8.96, 5.48)];
        [fill6 addCurveToPoint:CGPointMake(7.5, 3.2) controlPoint1:CGPointMake(8.96, 5.43) controlPoint2:CGPointMake(7.51, 4.87)];
        [fill6 addCurveToPoint:CGPointMake(8.69, 1.1) controlPoint1:CGPointMake(7.48, 1.81) controlPoint2:CGPointMake(8.63, 1.14)];
        [fill6 addCurveToPoint:CGPointMake(6.67, 0) controlPoint1:CGPointMake(8.04, 0.14) controlPoint2:CGPointMake(7.02, 0.03)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 5.69, 10.6);
        fill6.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.045 saturation:0.059 brightness:0.104 alpha:1] setFill];
        [fill6 fill];
        CGContextRestoreGState(context);

        //! Fill 7
        UIBezierPath * fill7 = [UIBezierPath bezierPath];
        [fill7 moveToPoint:CGPointMake(1.58, 5.37)];
        [fill7 addLineToPoint:CGPointMake(3.39, 5.37)];
        [fill7 addCurveToPoint:CGPointMake(5.55, 3.35) controlPoint1:CGPointMake(4.76, 5.37) controlPoint2:CGPointMake(5.55, 4.63)];
        [fill7 addCurveToPoint:CGPointMake(3.4, 1.33) controlPoint1:CGPointMake(5.55, 2.06) controlPoint2:CGPointMake(4.76, 1.33)];
        [fill7 addLineToPoint:CGPointMake(1.58, 1.33)];
        [fill7 addLineToPoint:CGPointMake(1.58, 5.37)];
        [fill7 closePath];
        [fill7 moveToPoint:CGPointMake(3.81, 0)];
        [fill7 addCurveToPoint:CGPointMake(7.16, 3.34) controlPoint1:CGPointMake(5.78, 0) controlPoint2:CGPointMake(7.16, 1.36)];
        [fill7 addCurveToPoint:CGPointMake(3.76, 6.69) controlPoint1:CGPointMake(7.16, 5.33) controlPoint2:CGPointMake(5.76, 6.69)];
        [fill7 addLineToPoint:CGPointMake(1.58, 6.69)];
        [fill7 addLineToPoint:CGPointMake(1.58, 10.17)];
        [fill7 addLineToPoint:CGPointMake(0, 10.17)];
        [fill7 addLineToPoint:CGPointZero];
        [fill7 addLineToPoint:CGPointMake(3.81, 0)];
        [fill7 addLineToPoint:CGPointMake(3.81, 0)];
        [fill7 closePath];
        [fill7 moveToPoint:CGPointMake(3.81, 0)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 17.6, 8.71);
        fill7.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.045 saturation:0.059 brightness:0.104 alpha:1] setFill];
        [fill7 fill];
        CGContextRestoreGState(context);

        //! Fill 8
        UIBezierPath * fill8 = [UIBezierPath bezierPath];
        [fill8 moveToPoint:CGPointMake(4.79, 4.71)];
        [fill8 addLineToPoint:CGPointMake(4.79, 4.14)];
        [fill8 addLineToPoint:CGPointMake(3.04, 4.25)];
        [fill8 addCurveToPoint:CGPointMake(1.54, 5.32) controlPoint1:CGPointMake(2.05, 4.31) controlPoint2:CGPointMake(1.54, 4.68)];
        [fill8 addCurveToPoint:CGPointMake(2.91, 6.34) controlPoint1:CGPointMake(1.54, 5.94) controlPoint2:CGPointMake(2.07, 6.34)];
        [fill8 addCurveToPoint:CGPointMake(4.79, 4.71) controlPoint1:CGPointMake(3.98, 6.34) controlPoint2:CGPointMake(4.79, 5.66)];
        [fill8 closePath];
        [fill8 moveToPoint:CGPointMake(0, 5.36)];
        [fill8 addCurveToPoint:CGPointMake(2.83, 3.2) controlPoint1:CGPointMake(0, 4.06) controlPoint2:CGPointMake(0.99, 3.31)];
        [fill8 addLineToPoint:CGPointMake(4.79, 3.08)];
        [fill8 addLineToPoint:CGPointMake(4.79, 2.52)];
        [fill8 addCurveToPoint:CGPointMake(3.28, 1.24) controlPoint1:CGPointMake(4.79, 1.69) controlPoint2:CGPointMake(4.25, 1.24)];
        [fill8 addCurveToPoint:CGPointMake(1.79, 2.28) controlPoint1:CGPointMake(2.49, 1.24) controlPoint2:CGPointMake(1.91, 1.65)];
        [fill8 addLineToPoint:CGPointMake(0.37, 2.28)];
        [fill8 addCurveToPoint:CGPointMake(3.33, 0) controlPoint1:CGPointMake(0.41, 0.96) controlPoint2:CGPointMake(1.65, 0)];
        [fill8 addCurveToPoint:CGPointMake(6.31, 2.41) controlPoint1:CGPointMake(5.13, 0) controlPoint2:CGPointMake(6.31, 0.94)];
        [fill8 addLineToPoint:CGPointMake(6.31, 7.47)];
        [fill8 addLineToPoint:CGPointMake(4.85, 7.47)];
        [fill8 addLineToPoint:CGPointMake(4.85, 6.25)];
        [fill8 addLineToPoint:CGPointMake(4.81, 6.25)];
        [fill8 addCurveToPoint:CGPointMake(2.49, 7.55) controlPoint1:CGPointMake(4.4, 7.05) controlPoint2:CGPointMake(3.48, 7.55)];
        [fill8 addCurveToPoint:CGPointMake(0, 5.36) controlPoint1:CGPointMake(1.02, 7.55) controlPoint2:CGPointMake(0, 6.67)];
        [fill8 addLineToPoint:CGPointMake(0, 5.36)];
        [fill8 closePath];
        [fill8 moveToPoint:CGPointMake(0, 5.36)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 25.15, 11.41);
        fill8.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.045 saturation:0.059 brightness:0.104 alpha:1] setFill];
        [fill8 fill];
        CGContextRestoreGState(context);

        //! Fill 9
        UIBezierPath * fill9 = [UIBezierPath bezierPath];
        [fill9 moveToPoint:CGPointMake(0.73, 10.1)];
        [fill9 addLineToPoint:CGPointMake(0.73, 8.88)];
        [fill9 addCurveToPoint:CGPointMake(1.2, 8.91) controlPoint1:CGPointMake(0.83, 8.89) controlPoint2:CGPointMake(1.07, 8.91)];
        [fill9 addCurveToPoint:CGPointMake(2.53, 7.85) controlPoint1:CGPointMake(1.9, 8.91) controlPoint2:CGPointMake(2.29, 8.61)];
        [fill9 addLineToPoint:CGPointMake(2.67, 7.4)];
        [fill9 addLineToPoint:CGPointZero];
        [fill9 addLineToPoint:CGPointMake(1.65, 0)];
        [fill9 addLineToPoint:CGPointMake(3.51, 6)];
        [fill9 addLineToPoint:CGPointMake(3.54, 6)];
        [fill9 addLineToPoint:CGPointMake(5.4, 0)];
        [fill9 addLineToPoint:CGPointMake(7.01, 0)];
        [fill9 addLineToPoint:CGPointMake(4.24, 7.77)];
        [fill9 addCurveToPoint:CGPointMake(1.35, 10.14) controlPoint1:CGPointMake(3.61, 9.55) controlPoint2:CGPointMake(2.88, 10.14)];
        [fill9 addCurveToPoint:CGPointMake(0.73, 10.1) controlPoint1:CGPointMake(1.23, 10.14) controlPoint2:CGPointMake(0.84, 10.13)];
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 32.06, 11.5);
        fill9.usesEvenOddFillRule = YES;
        [[UIColor colorWithHue:0.045 saturation:0.059 brightness:0.104 alpha:1] setFill];
        [fill9 fill];
        CGContextRestoreGState(context);

        CGContextRestoreGState(context);
    }
}

@end
