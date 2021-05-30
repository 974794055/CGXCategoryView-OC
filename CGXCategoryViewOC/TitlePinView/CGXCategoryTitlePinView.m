//
//  CGXCategoryTitlePinView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitlePinView.h"
#import "CGXCategoryTitlePinCell.h"
#import "CGXCategoryTitlePinCellModel.h"
@implementation CGXCategoryTitlePinView

- (void)initializeData
{
    [super initializeData];
    self.titleImageSpacing = 0;
    self.pinImageSize = CGSizeMake(20, 20);
    self.imagePosition = CGXCategoryCellClickedPosition_Right;
    self.cellWidthZoomEnabled = NO;
    self.cellWidthZoomScale = 1;
}

- (Class)preferredCellClass {
    [super preferredCellClass];
    return [CGXCategoryTitlePinCell class];
}

- (void)refreshDataSource {
    [super refreshDataSource];
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.titleArray.count];
    for (int i = 0; i < self.titleArray.count; i++) {
        CGXCategoryTitlePinCellModel *cellModel = [[CGXCategoryTitlePinCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = [NSArray arrayWithArray:tempArray];
}
- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index
{
    CGFloat titleWidth = [super preferredCellWidthAtIndex:index];
    if (self.cellWidth == CGXCategoryViewAutomaticDimension) {
        CGFloat imageHeight = 0;
        if (self.selectedIndex == index) {
            imageHeight = self.pinImageSize.width;
        }
        if (self.titleDataSource && [self.titleDataSource respondsToSelector:@selector(categoryTitleView:AtIndex:)]) {
            titleWidth = [self.titleDataSource categoryTitleView:self AtIndex:index]+imageHeight;
        }else {
            titleWidth = ceilf([self.titleArray[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.width)+imageHeight;
        }
    }else {
        titleWidth = self.cellWidth;
    }
    return titleWidth+self.titleImageSpacing;
}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];
    
    CGXCategoryTitlePinCellModel *myCellModel = (CGXCategoryTitlePinCellModel *)cellModel;
    myCellModel.pinImage = self.pinImage;
    myCellModel.imageSize = self.pinImageSize;
    myCellModel.imageURL = self.pinImageURL;
    myCellModel.imagePosition = self.imagePosition;
    
    myCellModel.titleImageSpacing = self.titleImageSpacing;
    if (self.loadImageCallback) {
        myCellModel.loadImageCallback = self.loadImageCallback;
    }
}
- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel
{
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    CGXCategoryTitlePinCellModel *myUnselectedCellModel = (CGXCategoryTitlePinCellModel *)unselectedCellModel;

    CGXCategoryTitlePinCellModel *myselectedCellModel = (CGXCategoryTitlePinCellModel *)selectedCellModel;

    myselectedCellModel.cellWidth +=self.pinImageSize.width+self.titleImageSpacing;

    myUnselectedCellModel.cellWidth -= self.pinImageSize.width+self.titleImageSpacing;
    [self.collectionView.collectionViewLayout invalidateLayout];

}
@end
