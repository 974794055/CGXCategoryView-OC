//
//  CGXCategoryDotView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleImageView.h"

#import "CGXCategoryDotCellModel.h"


@interface CGXCategoryDotView : CGXCategoryTitleImageView

//相对于titleLabel的位置，默认：CGXCategoryDotRelativePosition_TopRight
@property (nonatomic, assign) CGXCategoryDotRelativePosition relativePosition;
//红点的尺寸。默认：CGSizeMake(10, 10)
@property (nonatomic, assign) CGSize dotSize;
//红点的圆角值。默认：CGXCategoryViewAutomaticDimension（self.dotSize.height/2）
@property (nonatomic, assign) CGFloat dotCornerRadius;
//红点的颜色。默认：[UIColor redColor]
@property (nonatomic, strong) UIColor *dotColor;
/**
 红点  x,y方向的偏移
 
 右侧 ：（+值：水平方向向左，竖直方向向下）
      （-值：水平方向向右，竖直方向向上）
 
 左侧 ：（+值：水平方向向右，竖直方向向下）
      （-值：水平方向向左，竖直方向向上）
 */
@property (nonatomic, assign) CGPoint dotOffset;

@property (nonatomic, assign) CGXCategoryDotStyle dotStyle;
/*CGXCategoryDotStyle_Hollow 有效*/
//红点的边框颜色。默认：[UIColor redColor]
@property (nonatomic, strong) UIColor *dotborderColor;
//红点的边框。默认：5
@property (nonatomic, assign) CGFloat dotborderWidth;
/**
 更新红点的显示隐藏 YES 显示 NO：不显示
 */
- (void)updateWithDotHidden:(BOOL)hidden AtInter:(NSInteger)inter;

@end
