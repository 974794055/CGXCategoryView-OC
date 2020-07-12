//
//  CGXCategoryComponentBaseView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryIndicatorProtocol.h"
#import "CGXCategoryViewDefines.h"

@interface CGXCategoryIndicatorComponentView : UIView <CGXCategoryIndicatorProtocol>

//指示器的位置。底部或者顶部
@property (nonatomic, assign) CGXCategoryComponentPosition componentPosition;
//垂直方向偏移。数值越大越靠近中心。默认：0。
@property (nonatomic, assign) CGFloat verticalMargin;
//手势滚动、点击切换的时候，是否允许滚动，默认YES
@property (nonatomic, assign) BOOL scrollEnabled;
//滚动动画的时间。默认0.25
@property (nonatomic, assign) NSTimeInterval scrollAnimationDuration;
/**
 默认CGXCategoryViewAutomaticDimension（与cell的宽度相等）。内部通过`- (CGFloat)indicatorWidthValue:(CGRect)cellFrame`方法获取实际的值
 */
@property (nonatomic, assign) CGFloat indicatorWidth;

/**
 指示器的宽度增量。比如需求是指示器宽度比cell宽度多10 point。就可以将该属性赋值为10。最终指示器的宽度=indicatorWidth+indicatorWidthIncrement
 */
@property (nonatomic, assign) CGFloat indicatorWidthIncrement;

/**
 默认:3。内部通过`- (CGFloat)indicatorHeightValue:(CGRect)cellFrame`方法获取实际的值
 */
@property (nonatomic, assign) CGFloat indicatorHeight;

/**
 默认CGXCategoryViewAutomaticDimension （等于indicatorHeight/2）。内部通过`- (CGFloat)indicatorCornerRadiusValue:(CGRect)cellFrame`方法获取实际的值
 */
@property (nonatomic, assign) CGFloat indicatorCornerRadius;

/**
 指示器的颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 手势滚动、点击切换的时候，如果允许滚动，分为简单滚动和复杂滚动。默认为：CGXCategoryIndicatorScrollStyleSimple
 目前仅CGXCategoryIndicatorLineView、CGXCategoryIndicatorDotLineView支持，其他子类暂不支持。
 */
@property (nonatomic, assign) CGXCategoryIndicatorScrollStyle scrollStyle;

/**
 传入cellFrame获取指示器的最终宽度

 @param cellFrame cellFrame
 @return 指示器的最终宽度
 */
- (CGFloat)indicatorWidthValue:(CGRect)cellFrame;

/**
 传入cellFrame获取指示器的最终高度

 @param cellFrame cellFrame
 @return 指示器的最终高度
 */
- (CGFloat)indicatorHeightValue:(CGRect)cellFrame;

/**
 传入cellFrame获取指示器的最终圆角

 @param cellFrame cellFrame
 @return 指示器的最终圆角
 */
- (CGFloat)indicatorCornerRadiusValue:(CGRect)cellFrame;

@end
