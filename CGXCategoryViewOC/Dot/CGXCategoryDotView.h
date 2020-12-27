//
//  CGXCategoryDotView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleView.h"

#import "CGXCategoryDotCellModel.h"


@interface CGXCategoryDotView : CGXCategoryTitleView

//相对于titleLabel的位置，默认：CGXCategoryDotRelativePosition_TopRight
@property (nonatomic, assign) CGXCategoryDotRelativePosition relativePosition;
//@[@(布尔值)]数组，控制红点是否显示
@property (nonatomic, strong) NSArray <NSNumber *> *dotStates;
//红点的尺寸。默认：CGSizeMake(10, 10)
@property (nonatomic, assign) CGSize dotSize;
//红点的圆角值。默认：CGXCategoryViewAutomaticDimension（self.dotSize.height/2）
@property (nonatomic, assign) CGFloat dotCornerRadius;
//红点的颜色。默认：[UIColor redColor]
@property (nonatomic, strong) UIColor *dotColor;

@end
