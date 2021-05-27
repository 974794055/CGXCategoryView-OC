//
//  CGXCategoryFactory.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CGXCategoryFactory : NSObject

+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent;

+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent;


+ (BOOL)supportRTL;
+ (void)horizontalFlipView:(UIView *)view;
+ (void)horizontalFlipViewIfNeeded:(UIView *)view;
@end
