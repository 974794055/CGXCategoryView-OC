//
//  CGXCategoryTitleSubtitleView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleView.h"
#import "CGXCategoryTitleSubtitleCell.h"
#import "CGXCategoryTitleSubtitleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryTitleSubtitleView : CGXCategoryTitleView

@property (nonatomic, strong) NSArray <NSString *> *subTitleArray;
@property (nonatomic, strong) UIColor *subTitleNormalColor;
@property (nonatomic, strong) UIColor *subTitleSelectedColor;
@property (nonatomic, strong) UIFont *subTitleFont;
@property (nonatomic, strong) UIFont *subTitleSelectedFont;

//默认：NO，title的颜色是否渐变过渡
@property (nonatomic, assign) BOOL subTitleTitleColorGradientEnabled;
@property (nonatomic, assign) BOOL isHiddenSubTitle;

@property (nonatomic, assign) CGFloat titleSpace;

@property (nonatomic, assign) BOOL issubTitleBg;
@property (nonatomic, strong) UIColor *subTitleNBgColor;
@property (nonatomic, strong) UIColor *subTitleSBgColor;
@property (nonatomic, assign) CGFloat subTitleRadius;
// 距离中心距离
@property (nonatomic, assign) CGFloat subTitleSpace;
// 边距 默认 10
@property (nonatomic, assign) CGFloat subTitleMargin;

- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent;
@end

NS_ASSUME_NONNULL_END
