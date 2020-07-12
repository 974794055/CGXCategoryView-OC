//
//  CGXCategoryTitleSortCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CGXCategoryTitleSortUIType) {
    CGXCategoryTitleSortUIType_OnlyTitle,// 仅文字
    CGXCategoryTitleSortUIType_ArrowBoth,
    CGXCategoryTitleSortUIType_ArrowUpDown,// 展开 箭头上下
    CGXCategoryTitleSortUIType_OnlyImage,//仅图片
    CGXCategoryTitleSortUIType_SingleImage,// 筛选
};

typedef NS_ENUM(NSUInteger, CGXCategoryTitleSortArrowDirection) {
    CGXCategoryTitleSortArrowDirection_Down,
    CGXCategoryTitleSortArrowDirection_Up,
    CGXCategoryTitleSortArrowDirection_Both,
};


@interface CGXCategoryTitleSortCellModel : CGXCategoryTitleCellModel

@property (nonatomic, assign) CGXCategoryTitleSortUIType sortUIType;

@property (nonatomic, assign) CGXCategoryTitleSortArrowDirection arrowDirection;

@property (nonatomic, strong) UIImage *singleImage;
@property (nonatomic, strong) UIImage *arrowTopImage;
@property (nonatomic, strong) UIImage *arrowBottomImage;



@end

NS_ASSUME_NONNULL_END
