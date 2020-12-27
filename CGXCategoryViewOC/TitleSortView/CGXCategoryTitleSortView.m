//
//  CGXCategoryTitleSortView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleSortView.h"
@interface CGXCategoryTitleSortView ()



@end

@implementation CGXCategoryTitleSortView

- (void)initializeData {
    [super initializeData];
    self.cellSpacing  = 0;
    self.averageCellSpacingEnabled = NO;
    self.collectionView.bounces = NO;
    self.collectionView.scrollEnabled = NO;
    
}

//返回自定义的cell class
- (Class)preferredCellClass {
    return [CGXCategoryTitleSortCell class];
}
- (void)refreshState
{
    [super refreshState];
    self.separatorLineShowEnabled = YES;
    for (int i = 0; i < self.dataSource.count; i++) {
        CGXCategoryIndicatorCellModel *cellModel = (CGXCategoryIndicatorCellModel *)self.dataSource[i];
        cellModel.sepratorLineShowEnabled = self.separatorLineShowEnabled;
        if ([[self.separatorLineDic allKeys] containsObject:[NSNumber numberWithInteger:i]]) {
            cellModel.sepratorLineShowEnabled = self.separatorLineDic[@(i)].boolValue;
        }else{
             cellModel.sepratorLineShowEnabled = NO;
        }
        if (i == self.dataSource.count - 1) {
            cellModel.sepratorLineShowEnabled = NO;
        }
    }
}
- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
        CGXCategoryTitleSortCellModel *cellModel = [[CGXCategoryTitleSortCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio
{
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
}
- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];
    
    CGXCategoryTitleSortCellModel *myModel = (CGXCategoryTitleSortCellModel *)cellModel;
    if ([[self.sortUITypeDic allKeys] containsObject:[NSNumber numberWithInteger:index]]) {
        myModel.sortUIType = (CGXCategoryTitleSortUIType)(self.sortUITypeDic[@(index)].integerValue);
    }
    if ([[self.arrowDirections allKeys] containsObject:[NSNumber numberWithInteger:index]]) {
        
        myModel.arrowDirection = (CGXCategoryTitleSortArrowDirection)(self.arrowDirections[@(index)].integerValue);
    }
    if ([[self.separatorLineDic allKeys] containsObject:[NSNumber numberWithInteger:index]]) {
        myModel.sepratorLineShowEnabled = self.separatorLineDic[@(index)].boolValue;
        if (index == self.dataSource.count - 1) {
               myModel.sepratorLineShowEnabled = NO;
           }
    }else{
         myModel.sepratorLineShowEnabled = NO;
    }
      
    if ([[self.singleImages allKeys] containsObject:[NSNumber numberWithInteger:index]]) {
        myModel.singleImage = self.singleImages[@(index)];
    }
    myModel.arrowTopImage = self.arrowTopImage;
    myModel.arrowBottomImage = self.arrowBottomImage;
}
- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    CGFloat cellWidth = [super preferredCellWidthAtIndex:index];
    if (self.titleArray.count == 0) {
        return 0;
    }
    cellWidth = CGRectGetWidth(self.frame) / self.titleArray.count;
    
    if (self.titleDataSource && [self.titleDataSource respondsToSelector:@selector(categoryTitleView:AtIndex:)]) {
        cellWidth = [self.titleDataSource categoryTitleView:self AtIndex:index];
    }
    return ceil(cellWidth)-0.5;
}
@end
