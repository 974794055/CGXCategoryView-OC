//
//  CGXCategoryIndicatorDotLineView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorComponentView.h"

@interface CGXCategoryIndicatorDotLineView : CGXCategoryIndicatorComponentView

//点的尺寸。默认：CGSizeMake(10, 10)
@property (nonatomic, assign) CGSize dotSize;
//线状态的最大宽度。默认：50
@property (nonatomic, assign) CGFloat lineWidth;
//点线的颜色值。默认为[UIColor redColor]
@property (nonatomic, strong) UIColor *dotLineViewColor;

@end
