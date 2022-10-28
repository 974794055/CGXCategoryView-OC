//
//  CGXCategoryView-OCDefines.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const CGFloat CGXCategoryViewAutomaticDimension = -1;

typedef void(^CGXCategoryCellSelectedAnimationBlock)(CGFloat percent);

typedef NS_ENUM(NSUInteger, CGXCategoryComponentPosition) {
    CGXCategoryComponentPosition_Bottom,
    CGXCategoryComponentPosition_Top,
};

typedef NS_ENUM(NSUInteger, CGXCategoryCellClickedPosition) {
    CGXCategoryCellClickedPosition_Left,
    CGXCategoryCellClickedPosition_Right,
};

// cell被选中的类型
typedef NS_ENUM(NSUInteger, CGXCategoryCellSelectedType) {
    CGXCategoryCellSelectedTypeUnknown,          //未知，不是选中（cellForRow方法里面、两个cell过渡时）
    CGXCategoryCellSelectedTypeNode,
    CGXCategoryCellSelectedTypeClick,            //点击选中
    CGXCategoryCellSelectedTypeScroll            //通过滚动到某个cell选中
};

typedef NS_ENUM(NSUInteger, CGXCategoryTitleLabelAnchorPointStyle) {
    CGXCategoryTitleLabelAnchorPointStyleCenter,
    CGXCategoryTitleLabelAnchorPointStyleTop,
    CGXCategoryTitleLabelAnchorPointStyleBottom,
};


typedef NS_ENUM(NSUInteger, CGXCategoryIndicatorScrollStyle) {
    CGXCategoryIndicatorScrollStyleSimple,                   //简单滚动，即从当前位置过渡到目标位置
    CGXCategoryIndicatorScrollStyleSameAsUserScroll,         //和用户左右滚动列表时的效果一样
};

typedef NS_ENUM(NSUInteger, CGXCategoryTitlePosition) {
    CGXCategoryTitlePositionBottom,
    CGXCategoryTitlePositionTop,
    CGXCategoryTitlePositionLeft,
    CGXCategoryTitlePositionRight
};

typedef NS_OPTIONS (NSUInteger,CGXCategoryRoundedType) {
    CGXCategoryRoundedTypeTopLeft     = UIRectCornerTopLeft, // 左上角
    CGXCategoryRoundedTypeTopRight    = UIRectCornerTopRight, // 右上角
    CGXCategoryRoundedTypeBottomLeft  = UIRectCornerBottomLeft, // 左下角
    CGXCategoryRoundedTypeBottomRight = UIRectCornerBottomRight, // 右下角
    CGXCategoryRoundedTypeAll  = UIRectCornerAllCorners// 全部四个角
};

typedef NS_ENUM(NSUInteger, CGXCategoryTitleImageType) {
    CGXCategoryTitleImageType_TopImage = 0,
    CGXCategoryTitleImageType_LeftImage,
    CGXCategoryTitleImageType_BottomImage,
    CGXCategoryTitleImageType_RightImage,
    CGXCategoryTitleImageType_OnlyImage,
    CGXCategoryTitleImageType_OnlyTitle,
};

///DEBUG打印日志
#ifdef DEBUG
# define CGXCategorViewDebugLog(FORMAT, ...) printf("[%s 行号:%d]:\n%s\n",__FUNCTION__,__LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
# define CGXCategorViewDebugLog(FORMAT, ...)
#endif

#define CGXCategoryViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
