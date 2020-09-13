//
//  CGXCategoryTitleVerticalZoomView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 垂直方向的缩放值范围：minVerticalFontScale~maxVerticalFontScale；
 垂直方向左边距范围：minVerticalContentEdgeInsetLeft~maxVerticalContentEdgeInsetLeft，用于达到第一个cell左对齐的效果；
 垂直方向cellSpacing范围：minVerticalCellSpacing~maxVerticalCellSpacing，用于达到缩小时cell更加紧凑
 */
@interface CGXCategoryTitleVerticalZoomView : CGXCategoryTitleView

@property (nonatomic, assign) CGFloat currentVerticalScale; //当前垂直方向的缩放基准值
@property (nonatomic, assign) CGFloat maxVerticalFontScale; //垂直方向最大的缩放值
@property (nonatomic, assign) CGFloat minVerticalFontScale; //垂直方向最小的缩放值
@property (nonatomic, assign) CGFloat maxVerticalContentEdgeInsetLeft;  //垂直方向左右水平滚动时，最大的左边距值，用于达到左边距对齐的效果
@property (nonatomic, assign) CGFloat minVerticalContentEdgeInsetLeft;  //垂直方向左右水平滚动时，最小的左边距值，用于达到左边距对齐的效果
@property (nonatomic, assign) CGFloat maxVerticalCellSpacing;   //垂直方向最大的cellSpacing
@property (nonatomic, assign) CGFloat minVerticalCellSpacing;   //垂直方向最小的cellSpacing
@property (nonatomic, assign, readonly, getter=isHorizontalZoomTransitionAnimating) BOOL horizontalZoomTransitionAnimating; //是否正在水平缩放动画

/**
 当前列表滚动时，根据当前垂直方向categoryView高度变化的百分比，刷新布局

 @param percent 当前垂直方向categoryView高度变化百分比
 */
- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
