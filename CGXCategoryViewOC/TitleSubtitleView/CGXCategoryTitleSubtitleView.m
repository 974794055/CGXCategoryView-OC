//
//  CGXCategoryTitleSubtitleView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleSubtitleView.h"


@implementation CGXCategoryTitleSubtitleView

- (void)initializeData {
    [super initializeData];

    self.subTitleFont = [UIFont boldSystemFontOfSize:13];
    self.titleFont = [UIFont systemFontOfSize:10];
    self.subTitleSelectedFont = [UIFont boldSystemFontOfSize:15];
    self.titleSelectedFont = [UIFont systemFontOfSize:10];
    self.subTitleNormalColor = [UIColor lightGrayColor];
    self.titleColor = [UIColor lightGrayColor];
    self.subTitleSelectedColor = [UIColor whiteColor];
    self.titleSelectedColor = [UIColor whiteColor];
    
    self.subTitleSBgColor = [UIColor redColor];
    self.subTitleNBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    
    self.subTitleTitleColorGradientEnabled = NO;
    
    self.subTitleSpace = CGXCategoryViewAutomaticDimension;
    self.titleSpace = CGXCategoryViewAutomaticDimension;
    self.isHiddenSubTitle = NO;
    
    self.subTitleRadius = CGXCategoryViewAutomaticDimension;
    self.subTitleMargin = 0;
    self.issubTitleBg = NO;
}

//返回自定义的cell class
- (Class)preferredCellClass {
    return [CGXCategoryTitleSubtitleCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.subTitleArray.count; i++) {
        CGXCategoryTitleSubtitleCellModel *cellModel = [[CGXCategoryTitleSubtitleCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}


- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    CGXCategoryTitleSubtitleCellModel *myUnselectedCellModel = (CGXCategoryTitleSubtitleCellModel *)unselectedCellModel;
    CGXCategoryTitleSubtitleCellModel *myselectedCellModel = (CGXCategoryTitleSubtitleCellModel *)selectedCellModel;
    
    myUnselectedCellModel.subTitleNormalColor = myUnselectedCellModel.subTitleNormalColor;
    myUnselectedCellModel.subTitleSelectedColor = myUnselectedCellModel.subTitleSelectedColor;
    myUnselectedCellModel.subTitleFont = myUnselectedCellModel.subTitleFont;
    myUnselectedCellModel.subTitleSelectedFont = myUnselectedCellModel.subTitleSelectedFont;
    myUnselectedCellModel.subTitleSpace = myUnselectedCellModel.subTitleSpace;
    myUnselectedCellModel.titleSpace = myUnselectedCellModel.titleSpace;
    
    myselectedCellModel.subTitleNormalColor = myselectedCellModel.subTitleNormalColor;
    myselectedCellModel.subTitleSelectedColor = myselectedCellModel.subTitleSelectedColor;
    myselectedCellModel.subTitleFont = myselectedCellModel.subTitleFont;
    myselectedCellModel.subTitleSelectedFont = myselectedCellModel.subTitleSelectedFont;
    myselectedCellModel.subTitleSpace = myselectedCellModel.subTitleSpace;
    myselectedCellModel.titleSpace = myselectedCellModel.titleSpace;
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    CGXCategoryTitleSubtitleCellModel *leftModel = (CGXCategoryTitleSubtitleCellModel *)leftCellModel;
    CGXCategoryTitleSubtitleCellModel *rightModel = (CGXCategoryTitleSubtitleCellModel *)rightCellModel;
    if (self.subTitleTitleColorGradientEnabled) {
        leftModel.subTitleSelectedColor = [CGXCategoryFactory interpolationColorFrom:self.subTitleSelectedColor to:self.subTitleNormalColor percent:ratio];
        rightModel.subTitleSelectedColor = [CGXCategoryFactory interpolationColorFrom:self.subTitleNormalColor to:self.subTitleSelectedColor percent:ratio];
    }
}
- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    CGXCategoryTitleSubtitleCellModel *model = (CGXCategoryTitleSubtitleCellModel *)cellModel;
    model.subTitle = self.subTitleArray[index];
    model.subTitleNormalColor = self.subTitleNormalColor;
    model.subTitleSelectedColor = self.subTitleSelectedColor;
    model.subTitleFont = self.subTitleFont;
    model.subTitleSelectedFont = self.subTitleSelectedFont;
    model.subTitleSpace = self.subTitleSpace;
    model.titleSpace = self.titleSpace;
    model.isHiddenSubTitle = self.isHiddenSubTitle;
    model.subTitleNBgColor = self.subTitleNBgColor;
    model.subTitleSBgColor = self.subTitleSBgColor;
    model.subTitleRadius = self.subTitleRadius;
    model.subTitleMargin = self.subTitleMargin;
    model.issubTitleBg = self.issubTitleBg;
}


- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent
{
    NSLog(@"percent %f",percent);
    //在滑动过程中获取当前显示的所有cell, 调用偏移量的计算方法
    [[self.collectionView visibleCells] enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj respondsToSelector:@selector(cellOffsetOnCollectionView:)] && [obj conformsToProtocol:@protocol(CGXHotBrandUpdateCellDelegate)]) {
//            [(UICollectionViewCell<CGXHotBrandUpdateCellDelegate> *)obj cellOffsetOnCollectionView:self.collectionView];
//        }
    }];
    
//    [UIView animateWithDuration:3 animations:^{
//        self.isHiddenSubTitle = YES;
//        [self.collectionView reloadData];
//    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
