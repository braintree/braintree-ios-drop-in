#import "UIFont+BTUIK.h"

@implementation UIFont (BTUIK)

+ (UIFont *)bodyFontForFontFamily:(NSString *)fontFamily useStaticSize:(BOOL)useStaticSize {
    UIFont *customFont;
    if (fontFamily) {
        customFont = [UIFont fontWithName:fontFamily size:UIFont.labelFontSize];
    }

    if (customFont) {
        if (useStaticSize) {
            return customFont;
        } else {
            return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleBody] scaledFontForFont:customFont];
        }
    } else {
        if (useStaticSize) {
            return [UIFont systemFontOfSize:UIFont.labelFontSize];
        } else {
            return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        }
    }
}

+ (UIFont *)headlineFontForFontFamily:(NSString *)fontFamily useStaticSize:(BOOL)useStaticSize {
    UIFont *customFont;
    if (fontFamily) {
        customFont = [UIFont fontWithName:fontFamily size:UIFont.labelFontSize];
    }

    if (customFont) {
        if (useStaticSize) {
            return customFont;
        } else {
            return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleHeadline] scaledFontForFont:customFont];
        }
    } else {
        if (useStaticSize) {
            return [UIFont boldSystemFontOfSize:UIFont.labelFontSize];
        } else {
            return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        }
    }
}

+ (UIFont *)captionFontForFontFamily:(NSString *)fontFamily useStaticSize:(BOOL)useStaticSize {
    UIFont *customFont;
    if (fontFamily) {
        customFont = [UIFont fontWithName:fontFamily size:UIFont.smallSystemFontSize];
    }

    if (customFont) {
        if (useStaticSize) {
            return customFont;
        } else {
            return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleCaption1] scaledFontForFont:customFont];
        }
    } else {
        if (useStaticSize) {
            return [UIFont systemFontOfSize:UIFont.smallSystemFontSize];
        } else {
            return [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        }
    }
}

+ (UIFont *)titleFontForFontFamily:(NSString *)fontFamily useStaticSize:(BOOL)useStaticSize {
    UIFont *customFont;
    if (fontFamily) {
        customFont = [UIFont fontWithName:fontFamily size:24];
    }

    if (customFont) {
        if (useStaticSize) {
            return customFont;
        } else {
            return [[UIFontMetrics metricsForTextStyle:UIFontTextStyleTitle2] scaledFontForFont:customFont];
        }
    } else {
        if (useStaticSize) {
            return [UIFont systemFontOfSize:24];
        } else {
            return [UIFont preferredFontForTextStyle:UIFontTextStyleTitle2];
        }
    }
}

@end
