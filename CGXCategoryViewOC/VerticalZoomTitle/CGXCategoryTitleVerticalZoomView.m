//
//  CGXCategoryTitleVerticalZoomView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleVerticalZoomView.h"
#import "CGXCategoryTitleVerticalZoomCellModel.h"
#import "CGXCategoryTitleVerticalZoomCell.h"
#import "CGXCategoryFactory.h"
#import "CGXCategoryViewAnimator.h"

@interface CGXCategoryTitleVerticalZoomView()
@property (nonatomic, strong) CGXCategoryViewAnimator *edgeLeftAnimator;
@property (nonatomic, assign) BOOL horizontalZoomTransitionAnimating;
@end

@implementation CGXCategoryTitleVerticalZoomView

- (void)initializeData {
    [super initializeData];

    _currentVerticalScale = 1.5;
    _maxVerticalFontScale = 1.5;
    _minVerticalFontScale = 1.3;
    _maxVerticalContentEdgeInsetLeft = 30;
    self.cellSpacing = 30;
    self.contentEdgeInsetLeft = 30;
    _minVerticalContentEdgeInsetLeft = 15;
    self.titleLabelZoomScale = _currentVerticalScale;
    self.titleLabelZoomEnabled = YES;
    self.selectedAnimationEnabled = YES;
    _maxVerticalCellSpacing = 30;
    _minVerticalCellSpacing = 20;
}

- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent {
    CGFloat currentScale = [CGXCategoryFactory interpolationFrom:self.minVerticalFontScale to:self.maxVerticalFontScale percent:percent];
    BOOL shouldReloadData = NO;
    if (self.currentVerticalScale != currentScale) {
        //有变化才允许reloadData
        shouldReloadData = YES;
    }
    self.currentVerticalScale = currentScale;
    CGFloat contentEdgeInsetScale = self.currentVerticalScale/self.maxVerticalFontScale;
    if (self.selectedIndex == 0) {
        self.contentEdgeInsetLeft = self.maxVerticalContentEdgeInsetLeft*contentEdgeInsetScale;
    }else {
        self.contentEdgeInsetLeft = self.minVerticalContentEdgeInsetLeft*contentEdgeInsetScale;
    }
    self.cellSpacing = [CGXCategoryFactory interpolationFrom:self.minVerticalCellSpacing to:self.maxVerticalCellSpacing percent:percent];
    if (shouldReloadData) {
        //只有参数有变化才reloadData
        [self reloadData];
    }
}

- (void)setCurrentVerticalScale:(CGFloat)currentVerticalScale {
    _currentVerticalScale = currentVerticalScale;

    self.titleLabelZoomScale = currentVerticalScale;
}

- (Class)preferredCellClass {
    [super preferredCellClass];
    return [CGXCategoryTitleVerticalZoomCell class];
}

- (void)refreshDataSource {
    [super refreshDataSource];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
        CGXCategoryTitleVerticalZoomCellModel *cellModel = [[CGXCategoryTitleVerticalZoomCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    CGXCategoryTitleVerticalZoomCellModel *model = (CGXCategoryTitleVerticalZoomCellModel *)cellModel;
    model.maxVerticalFontScale = self.maxVerticalFontScale;
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    if (leftCellModel.index == 0) {
        //第一个cell正在左右交互
        CGFloat scale = self.currentVerticalScale/self.maxVerticalFontScale;
        self.contentEdgeInsetLeft = [CGXCategoryFactory interpolationFrom:self.maxVerticalContentEdgeInsetLeft*scale to:self.minVerticalContentEdgeInsetLeft*scale percent:ratio];
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
}

- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    if (self.selectedAnimationEnabled) {
        if (selectedCellModel.selectedType == CGXCategoryCellSelectedTypeUnknown ||
            selectedCellModel.selectedType == CGXCategoryCellSelectedTypeClick) {
            self.edgeLeftAnimator = [[CGXCategoryViewAnimator alloc] init];
            self.edgeLeftAnimator.duration = self.selectedAnimationDuration;
            __weak typeof(self) weakSelf = self;
            self.edgeLeftAnimator.progressCallback = ^(CGFloat percent) {
                selectedCellModel.transitionAnimating = YES;
                unselectedCellModel.transitionAnimating = YES;
                weakSelf.horizontalZoomTransitionAnimating = YES;
                CGFloat scale = weakSelf.currentVerticalScale/weakSelf.maxVerticalFontScale;
                if (selectedCellModel.index == 0) {
                    weakSelf.contentEdgeInsetLeft = [CGXCategoryFactory interpolationFrom:weakSelf.minVerticalContentEdgeInsetLeft*scale to:weakSelf.maxVerticalContentEdgeInsetLeft*scale percent:percent];
                    [weakSelf.collectionView.collectionViewLayout invalidateLayout];
                }else if (unselectedCellModel.index == 0) {
                    weakSelf.contentEdgeInsetLeft = [CGXCategoryFactory interpolationFrom:weakSelf.maxVerticalContentEdgeInsetLeft*scale to:weakSelf.minVerticalContentEdgeInsetLeft*scale percent:percent];
                    [weakSelf.collectionView.collectionViewLayout invalidateLayout];
                }
            };
            self.edgeLeftAnimator.completeCallback = ^{
                selectedCellModel.transitionAnimating = NO;
                unselectedCellModel.transitionAnimating = NO;
                weakSelf.horizontalZoomTransitionAnimating = NO;
            };
            [self.edgeLeftAnimator start];
        }else {
            CGFloat scale = self.currentVerticalScale/self.maxVerticalFontScale;
            if (selectedCellModel.index == 0) {
                self.contentEdgeInsetLeft = self.maxVerticalContentEdgeInsetLeft*scale;
                [self.collectionView.collectionViewLayout invalidateLayout];
            }else if (unselectedCellModel.index == 0) {
                self.contentEdgeInsetLeft = self.minVerticalContentEdgeInsetLeft*scale;
                [self.collectionView.collectionViewLayout invalidateLayout];
            }
        }
    }
}

@end
