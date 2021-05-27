//
//  CGXCategoryTitleSubView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleView.h"
#import "CGXCategoryTitleSubCell.h"
#import "CGXCategoryTitleSubCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryTitleSubView : CGXCategoryTitleView

@property (nonatomic, strong) NSArray <NSString *> *subTitleArray;
@property (nonatomic, strong) UIColor *subTitleNormalColor;
@property (nonatomic, strong) UIColor *subTitleSelectedColor;
@property (nonatomic, strong) UIFont *subTitleFont;
@property (nonatomic, strong) UIFont *subTitleSelectedFont;
//默认：NO，title的颜色是否渐变过渡
@property (nonatomic, assign) BOOL subTitleTitleColorGradientEnabled;
// 默认在title底部
@property (nonatomic, assign) CGXCategorySubTitlePositionStyle positionStyle;

@property (nonatomic, strong) UIColor *subTitleNBgColor;
@property (nonatomic, strong) UIColor *subTitleSBgColor;
@property (nonatomic, assign) CGFloat subTitleRadius;
// 距离边缘距离
@property (nonatomic, assign) CGFloat subTitleSpace;
// 边距 默认 10
@property (nonatomic, assign) CGFloat subTitleMargin;

// 用于滚动处理隐藏副标题
- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
