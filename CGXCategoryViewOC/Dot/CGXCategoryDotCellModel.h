//
//  CGXCategoryDotCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleImageCellModel.h"

typedef NS_ENUM(NSUInteger, CGXCategoryDotRelativePosition) {
    CGXCategoryDotRelativePosition_TopLeft = 0,
    CGXCategoryDotRelativePosition_TopRight,
    CGXCategoryDotRelativePosition_BottomLeft,
    CGXCategoryDotRelativePosition_BottomRight,
};
typedef NS_ENUM(NSUInteger, JXCategoryDotStyle) {
    JXCategoryDotStyle_Solid = 0,   // 实心
    JXCategoryDotStyle_Hollow       // 空心
};
@interface CGXCategoryDotCellModel : CGXCategoryTitleImageCellModel

@property (nonatomic, assign) JXCategoryDotStyle dotStyle;

@property (nonatomic, assign) BOOL dotHidden;

@property (nonatomic, assign) CGXCategoryDotRelativePosition relativePosition;

@property (nonatomic, assign) CGSize dotSize;

@property (nonatomic, assign) CGFloat dotCornerRadius;

@property (nonatomic, strong) UIColor *dotColor;

@property (nonatomic, assign) CGPoint dotOffset;

@property (nonatomic, strong) UIColor *dotborderColor;

@property (nonatomic, assign) CGFloat dotborderWidth;

@end
