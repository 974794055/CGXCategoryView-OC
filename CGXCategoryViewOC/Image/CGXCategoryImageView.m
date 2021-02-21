//
//  CGXCategoryImageView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryImageView.h"
#import "CGXCategoryFactory.h"
#import "CGXCategoryImageCell.h"
#import "CGXCategoryImageCellModel.h"
@implementation CGXCategoryImageView

- (void)dealloc
{
    self.loadImageCallback = nil;
}

- (void)initializeData {
    [super initializeData];

    _imageSize = CGSizeMake(20, 20);
    _imageZoomEnabled = NO;
    _imageZoomScale = 1.2;
    _imageCornerRadius = 0;
}

- (Class)preferredCellClass {
    return [CGXCategoryImageCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    NSUInteger count = (self.imageNames.count > 0) ? self.imageNames.count : (self.imageURLs.count > 0 ? self.imageURLs.count : 0);
    for (int i = 0; i < count; i++) {
        CGXCategoryImageCellModel *cellModel = [[CGXCategoryImageCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    CGXCategoryImageCellModel *myUnselectedCellModel = (CGXCategoryImageCellModel *)unselectedCellModel;
    myUnselectedCellModel.imageZoomScale = 1.0;

    CGXCategoryImageCellModel *myselectedCellModel = (CGXCategoryImageCellModel *)selectedCellModel;
    myselectedCellModel.imageZoomScale = self.imageZoomScale;
}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    CGXCategoryImageCellModel *myCellModel = (CGXCategoryImageCellModel *)cellModel;
    myCellModel.loadImageCallback = self.loadImageCallback;
    myCellModel.imageSize = self.imageSize;
    myCellModel.imageCornerRadius = self.imageCornerRadius;
    if (self.imageNames != nil) {
        myCellModel.imageName = self.imageNames[index];
    }else if (self.imageURLs != nil) {
        myCellModel.imageURL = self.imageURLs[index];
    }
    if (self.selectedImageNames != nil) {
        myCellModel.selectedImageName = self.selectedImageNames[index];
    }else if (self.selectedImageURLs != nil) {
        myCellModel.selectedImageURL = self.selectedImageURLs[index];
    }
    myCellModel.imageZoomEnabled = self.imageZoomEnabled;
    myCellModel.imageZoomScale = 1.0;
    if (index == self.selectedIndex) {
        myCellModel.imageZoomScale = self.imageZoomScale;
    }
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    CGXCategoryImageCellModel *leftModel = (CGXCategoryImageCellModel *)leftCellModel;
    CGXCategoryImageCellModel *rightModel = (CGXCategoryImageCellModel *)rightCellModel;

    if (self.imageZoomEnabled) {
        leftModel.imageZoomScale = [CGXCategoryFactory interpolationFrom:self.imageZoomScale to:1.0 percent:ratio];
        rightModel.imageZoomScale = [CGXCategoryFactory interpolationFrom:1.0 to:self.imageZoomScale percent:ratio];
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    return self.imageSize.width+self.cellWidthIncrement;
}

@end
