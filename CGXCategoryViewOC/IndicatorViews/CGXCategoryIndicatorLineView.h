//
//  CGXCategoryIndicatorLineView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorComponentView.h"

typedef NS_ENUM(NSUInteger, CGXCategoryIndicatorLineStyle) {
    CGXCategoryIndicatorLineStyle_Normal             = 0,
    CGXCategoryIndicatorLineStyle_JD                 = 1,
    CGXCategoryIndicatorLineStyle_IQIYI              = 2,
};

@interface CGXCategoryIndicatorLineView : CGXCategoryIndicatorComponentView

@property (nonatomic, assign) CGXCategoryIndicatorLineStyle lineStyle;

/**
 line滚动时x的偏移量，默认为10；
 lineStyle为CGXCategoryIndicatorLineStyle_LengthenOffset有用；
 */
@property (nonatomic, assign) CGFloat lineScrollOffsetX;


@end
