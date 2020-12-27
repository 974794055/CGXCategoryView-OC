//
//  CGXCategoryTitleBadgeModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryTitleBadgeModel : NSObject

/************** 角标  *************/
/**
 需要与titles的count对应
 */
@property (nonatomic, assign) NSInteger count;


@property (nonatomic, copy) NSString *numberString;


@property (nonatomic, assign) BOOL isFormatter;
/**
  默认。 数字超过99显示99
 */
@property (nonatomic, assign) NSInteger numberMax;

/**
 numberLabel的font，默认：[UIFont systemFontOfSize:11]
 */
@property (nonatomic, strong) UIFont *numberLabelFont;

/**
 数字的背景色，默认：[UIColor colorWithRed:241/255.0 green:147/255.0 blue:95/255.0 alpha:1]
 */
@property (nonatomic, strong) UIColor *numberBackgroundColor;

/**
 数字的title颜色，默认：[UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *numberTitleColor;

/**
 numberLabel的宽度补偿，label真实的宽度是文字内容的宽度加上补偿的宽度，默认：10
 */
@property (nonatomic, assign) CGFloat numberLabelWidthIncrement;

/**
 numberLabel的高度，默认：14
 */
@property (nonatomic, assign) CGFloat numberLabelHeight;

/**
 numberLabel的宽度，默认：14
 */
@property (nonatomic, assign) CGFloat numberLabelWidth;
/**
 是否自适应角标 默认YES  NO：固定宽高
 */
@property (nonatomic, assign) BOOL badgeAdaptive;

/**
 numberLabel  x,y方向的偏移 （+值：水平方向向右，竖直方向向下）
 */
@property (nonatomic, assign) CGPoint numberLabelOffset;

@end

NS_ASSUME_NONNULL_END
