//
//  CGXCategoryTitleImageCellModel.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleImageCellModel.h"

@implementation CGXCategoryTitleImageCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageType = CGXCategoryTitleImageType_TopImage;
        _imageSize = CGSizeMake(20, 20);
        _titleImageSpacing = 5;
        _imageZoomEnabled = NO;
        _imageZoomScale = 1.0;
         _selectImageZoomScale = 1.2;
    }
    return self;
}
@end
