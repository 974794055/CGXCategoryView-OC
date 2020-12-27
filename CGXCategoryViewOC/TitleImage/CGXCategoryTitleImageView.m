//
//  CGXCategoryImageView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleImageView.h"

#import "CGXCategoryTitleImageCell.h"
#import "CGXCategoryTitleImageCellModel.h"

@implementation CGXCategoryTitleImageView

- (void)dealloc
{
    self.loadImageCallback = nil;
}

- (void)initializeData {
    [super initializeData];
    
    _imageSize = CGSizeMake(25, 25);
    _titleImageSpacing = 5;
    _imageZoomEnabled = NO;
    _imageZoomScale = 1.2;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //部分使用者为了适配不同的手机屏幕尺寸，CGXCategoryView的宽高比要求保持一样，所以它的高度就会因为不同宽度的屏幕而不一样。计算出来的高度，有时候会是位数很长的浮点数，如果把这个高度设置给UICollectionView就会触发内部的一个错误。所以，为了规避这个问题，在这里对高度统一向下取整。
    //如果向下取整导致了你的页面异常，请自己重新设置CGXCategoryView的高度，保证为整数即可。

        [self.collectionView setNeedsLayout];
        [self.collectionView layoutSubviews];
  
}
- (Class)preferredCellClass {
    return [CGXCategoryTitleImageCell class];
}

- (void)refreshDataSource {
    
    
    if (self.imageNames.count>0) {
        NSAssert((self.imageNames.count == self.titleArray.count), @"文字titles和角标imageNames个数必须相对应------存在普通状态下的imageNames");
    }
    if (self.selectedImageNames.count>0) {
        NSAssert((self.selectedImageNames.count == self.titleArray.count), @"文字titles和角标selectedImageNames个数必须相对应------存在选中状态下的imageNames时");
    }
    
    if (self.imageURLs.count>0) {
        NSAssert((self.imageURLs.count == self.titleArray.count), @"文字titles和角标imageURLs个数必须相对应------存在普通状态下的imageURLs");
    }
    if (self.selectedImageURLs.count>0) {
        NSAssert((self.selectedImageURLs.count == self.titleArray.count), @"文字titles和角标selectedImageURLs个数必须相对应------存在选中状态下的selectedImageURLs时");
    }
    
    if (self.imageTypes.count>0) {
        NSAssert((self.imageTypes.count == self.titleArray.count), @"文字titles和图文位置属性必须相对应------存在图文位置属性时");
    }
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
        CGXCategoryTitleImageCellModel *cellModel = [[CGXCategoryTitleImageCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    if (self.imageTypes == nil || self.imageTypes.count == 0) {
        NSMutableArray *types = [NSMutableArray array];
        for (int i = 0; i < self.titleArray.count; i++) {
            [types addObject:@(CGXCategoryTitleImageType_TopImage)];
        }
        self.imageTypes = types;
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];
    
    CGXCategoryTitleImageCellModel *myCellModel = (CGXCategoryTitleImageCellModel *)cellModel;
    myCellModel.loadImageCallback = self.loadImageCallback;
    myCellModel.imageType = [self.imageTypes[index] integerValue];
    myCellModel.imageSize = self.imageSize;
    myCellModel.titleImageSpacing = self.titleImageSpacing;
    if (self.imageNames != nil) {
        myCellModel.imageName = self.imageNames[index];
    }
    else if (self.imageURLs != nil) {
        myCellModel.imageURL = self.imageURLs[index];
    }
    if (self.selectedImageNames != nil) {
        myCellModel.selectedImageName = self.selectedImageNames[index];
    }
    else if (self.selectedImageURLs != nil) {
        myCellModel.selectedImageURL = self.selectedImageURLs[index];
    }
    myCellModel.imageZoomEnabled = self.imageZoomEnabled;
    myCellModel.imageZoomScale = 1.0;
    if (index == self.selectedIndex) {
        myCellModel.imageZoomScale = self.imageZoomScale;
    }
}

- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    CGXCategoryTitleImageCellModel *myUnselectedCellModel = (CGXCategoryTitleImageCellModel *)unselectedCellModel;
    myUnselectedCellModel.imageZoomScale = 1.0;
    
    CGXCategoryTitleImageCellModel *myselectedCellModel = (CGXCategoryTitleImageCellModel *)selectedCellModel;
    myselectedCellModel.imageZoomScale = self.imageZoomScale;
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    
    CGXCategoryTitleImageCellModel *leftModel = (CGXCategoryTitleImageCellModel *)leftCellModel;
    CGXCategoryTitleImageCellModel *rightModel = (CGXCategoryTitleImageCellModel *)rightCellModel;
    
    if (self.imageZoomEnabled) {
        leftModel.imageZoomScale = [CGXCategoryFactory interpolationFrom:self.imageZoomScale to:1.0 percent:ratio];
        rightModel.imageZoomScale = [CGXCategoryFactory interpolationFrom:1.0 to:self.imageZoomScale percent:ratio];
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    CGFloat titleWidth = [super preferredCellWidthAtIndex:index];
    CGXCategoryTitleImageType type = [self.imageTypes[index] integerValue];
    CGFloat cellWidth = 0;
    switch (type) {
        case CGXCategoryTitleImageType_OnlyTitle:
            cellWidth = titleWidth+self.cellWidthIncrement;;
            break;
        case CGXCategoryTitleImageType_OnlyImage:
            cellWidth = self.imageSize.width+self.cellWidthIncrement;
            break;
        case CGXCategoryTitleImageType_LeftImage:
        case CGXCategoryTitleImageType_RightImage:
            cellWidth = titleWidth + self.titleImageSpacing + self.imageSize.width;
            break;
        case CGXCategoryTitleImageType_TopImage:
        case CGXCategoryTitleImageType_BottomImage:
            cellWidth = MAX(titleWidth, self.imageSize.width);
            break;
    }
    return cellWidth;
}

@end
