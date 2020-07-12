//
//  CGXCategoryDotCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleCellModel.h"

typedef NS_ENUM(NSUInteger, CGXCategoryDotRelativePosition) {
    CGXCategoryDotRelativePosition_TopLeft = 0,
    CGXCategoryDotRelativePosition_TopRight,
    CGXCategoryDotRelativePosition_BottomLeft,
    CGXCategoryDotRelativePosition_BottomRight,
};

@interface CGXCategoryDotCellModel : CGXCategoryTitleCellModel

@property (nonatomic, assign) BOOL dotHidden;

@property (nonatomic, assign) CGXCategoryDotRelativePosition relativePosition;

@property (nonatomic, assign) CGSize dotSize;

@property (nonatomic, assign) CGFloat dotCornerRadius;

@property (nonatomic, strong) UIColor *dotColor;


@end
