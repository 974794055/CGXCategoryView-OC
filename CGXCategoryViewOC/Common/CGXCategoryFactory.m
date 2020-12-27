//
//  CGXCategoryFactory.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryFactory.h"
#import "UIColor+CGXCategory.h"

@implementation CGXCategoryFactory

+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent
{
    percent = MAX(0, MIN(1, percent));
    return from + (to - from)*percent;
}

+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat red = [self interpolationFrom:fromColor.gx_red to:toColor.gx_red percent:percent];
    CGFloat green = [self interpolationFrom:fromColor.gx_green to:toColor.gx_green percent:percent];
    CGFloat blue = [self interpolationFrom:fromColor.gx_blue to:toColor.gx_blue percent:percent];
    CGFloat alpha = [self interpolationFrom:fromColor.gx_alpha to:toColor.gx_alpha percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
