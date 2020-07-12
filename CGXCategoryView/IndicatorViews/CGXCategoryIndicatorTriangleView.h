//
//  CGXCategoryIndicatorTriangleView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorComponentView.h"

@interface CGXCategoryIndicatorTriangleView : CGXCategoryIndicatorComponentView
//三角形的尺寸。默认：CGSizeMake(14, 10)
@property (nonatomic, assign) CGSize triangleViewSize;
//三角形的颜色值。默认：[UIColor redColor]
@property (nonatomic, strong) UIColor *triangleViewColor;

@end
