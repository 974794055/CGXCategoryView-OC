//
//  CGXCategoryTitleSubCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

// subTitle相对于title的位置
typedef NS_ENUM(NSUInteger, CGXCategorySubTitlePositionStyle) {
    CGXCategorySubTitlePositionStyle_Top,
    CGXCategorySubTitlePositionStyle_Bottom
};

@interface CGXCategoryTitleSubCellModel : CGXCategoryTitleCellModel

@property (nonatomic, assign) CGXCategorySubTitlePositionStyle positionStyle;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, strong) UIColor *subTitleNormalColor;

@property (nonatomic, strong) UIColor *subTitleCurrentColor;

@property (nonatomic, strong) UIColor *subTitleSelectedColor;

@property (nonatomic, strong) UIFont *subTitleFont;

@property (nonatomic, strong) UIFont *subTitleSelectedFont;

@property (nonatomic, assign) CGFloat subTitleSpace;


@property (nonatomic, strong) UIColor *subTitleNBgColor;
@property (nonatomic, strong) UIColor *subTitleSBgColor;
@property (nonatomic, assign) CGFloat subTitleRadius;
// 边距 默认 10
@property (nonatomic, assign) CGFloat subTitleMargin;
@property (nonatomic , assign) CGFloat subAlpha;

@end

NS_ASSUME_NONNULL_END
