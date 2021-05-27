//
//  CGXCategoryIndicatorArcView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CGXCategoryIndicatorArcStyle) {
    CGXCategoryIndicatorArcStyle_Normal,// 无效果
    CGXCategoryIndicatorArcStyle_Round1,// 内环圆角
    CGXCategoryIndicatorArcStyle_Round2,//外环圆角
    CGXCategoryIndicatorArcStyle_Arc , // 弧形
    CGXCategoryIndicatorArcStyle_IQIYI, // 爱奇艺弧形
};


@interface CGXCategoryIndicatorArcView : CGXCategoryIndicatorBackgroundView

//垂直方向偏移。数值越大越靠近中心。默认：30
@property (nonatomic, assign) CGFloat verticalSpace;

@property (nonatomic, assign) CGXCategoryIndicatorArcStyle specialStyle;

/*
 CGXCategoryIndicatorArcStyle_Arc  用
 */
@property (nonatomic, assign) CGFloat racStartAngle;// 0 ~ M_PI_2 之间;
@property (nonatomic, assign) CGFloat racRound; // 圆角 默认15
@property (nonatomic, assign) CGFloat racSpace; //底部边距  默认10

@end

NS_ASSUME_NONNULL_END
