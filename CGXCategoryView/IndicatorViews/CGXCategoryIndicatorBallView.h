//
//  CGXCategoryIndicatorBallView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorComponentView.h"

@interface CGXCategoryIndicatorBallView : CGXCategoryIndicatorComponentView

//球的尺寸。默认：CGSizeMake(15, 15)
@property (nonatomic, assign) CGSize ballViewSize;
//球的X轴偏移量。默认：20
@property (nonatomic, assign) CGFloat ballScrollOffsetX;
//球的颜色值。默认为[UIColor redColor]
@property (nonatomic, strong) UIColor *ballViewColor;

@end
