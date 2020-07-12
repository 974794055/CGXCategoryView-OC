//
//  CGXCategoryIndicatorView.m
//  DQGuess
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorView.h"
#import "CGXCategoryIndicatorBackgroundView.h"
#import "CGXCategoryFactory.h"
#import "CGXCategoryIndicatorCell.h"
#import "CGXCategoryIndicatorCellModel.h"
@interface CGXCategoryIndicatorView()

@property (nonatomic , strong) UIView *bottomLineView;

@end

@implementation CGXCategoryIndicatorView

- (void)initializeData {
    [super initializeData];

    _separatorLineShowEnabled = NO;
    _separatorLineColor = [UIColor lightGrayColor];
    _separatorLineSize = CGSizeMake(1/[UIScreen mainScreen].scale, 20);
    _cellBackgroundColorGradientEnabled = NO;
    _cellBackgroundUnselectedColor = [UIColor whiteColor];
    _cellBackgroundSelectedColor = [UIColor lightGrayColor];
    
    
    self.cellWidthIncrement = 0;
    self.normalBackgroundColor = [UIColor whiteColor];
    self.normalBorderColor = [UIColor clearColor];
    self.selectedBackgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.selectedBorderColor = [UIColor orangeColor];
    self.borderLineWidth = 1;
    self.backgroundCornerRadius = 8;
    self.backgroundWidth = CGXCategoryViewAutomaticDimension;
    self.backgroundHeight = 0;
    
    self.bottomLineHeight = 1;
    self.bottomLineColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.bottomLineSpace = 0;
    self.isBottomHidden = NO;
}

- (void)initializeViews {
    [super initializeViews];
    

    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = self.bottomLineColor;
    [self addSubview:self.bottomLineView];
    [self bringSubviewToFront:self.bottomLineView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bottomLineView.frame = CGRectMake(self.bottomLineSpace, CGRectGetHeight(self.frame)-self.bottomLineHeight, CGRectGetWidth(self.bounds)-self.bottomLineSpace * 2, self.bottomLineHeight);
    self.bottomLineView.backgroundColor = self.bottomLineColor;
    if (self.dataSource.count==0) {
        self.bottomLineView.hidden = YES;
    } else{
      self.bottomLineView.hidden = self.isBottomHidden;
    }
}

- (void)setIndicators:(NSArray<UIView<CGXCategoryIndicatorProtocol> *> *)indicators {
    _indicators = indicators;
    self.collectionView.indicators = indicators;
}
- (void)refreshState {
    [super refreshState];
    
    CGRect selectedCellFrame = CGRectZero;
    CGXCategoryIndicatorCellModel *selectedCellModel = nil;
    for (int i = 0; i < self.dataSource.count; i++) {
        CGXCategoryIndicatorCellModel *cellModel = (CGXCategoryIndicatorCellModel *)self.dataSource[i];
        cellModel.sepratorLineShowEnabled = self.separatorLineShowEnabled;
        cellModel.separatorLineColor = self.separatorLineColor;
        cellModel.separatorLineSize = self.separatorLineSize;
        cellModel.backgroundViewMaskFrame = CGRectZero;
        cellModel.cellBackgroundColorGradientEnabled = self.cellBackgroundColorGradientEnabled;
        cellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        cellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        if (i == self.dataSource.count - 1) {
            cellModel.sepratorLineShowEnabled = NO;
        }
        if (i == self.selectedIndex) {
            selectedCellModel = cellModel;
            selectedCellFrame = [self getTargetCellFrame:i];
        }
    }
    for (UIView<CGXCategoryIndicatorProtocol> *indicator in self.indicators) {
        if (self.dataSource.count <= 0) {
            indicator.hidden = YES;
        }else {
            indicator.hidden = NO;
            CGXCategoryIndicatorParamsModel *indicatorParamsModel = [[CGXCategoryIndicatorParamsModel alloc] init];
            indicatorParamsModel.selectedIndex = self.selectedIndex;
            indicatorParamsModel.selectedCellFrame = selectedCellFrame;
            [indicator reloadRefreshState:indicatorParamsModel];
            if ([indicator isKindOfClass:[CGXCategoryIndicatorBackgroundView class]]) {
                CGRect maskFrame = indicator.frame;
                maskFrame.origin.x = maskFrame.origin.x - selectedCellFrame.origin.x;
                selectedCellModel.backgroundViewMaskFrame = maskFrame;
            }
        }
    }
}

- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    CGXCategoryIndicatorCellModel *myUnselectedCellModel = (CGXCategoryIndicatorCellModel *)unselectedCellModel;
    myUnselectedCellModel.backgroundViewMaskFrame = CGRectZero;
    myUnselectedCellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
    myUnselectedCellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;

    CGXCategoryIndicatorCellModel *myselectedCellModel = (CGXCategoryIndicatorCellModel *)selectedCellModel;
    myselectedCellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
    myselectedCellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    [super contentOffsetOfContentScrollViewDidChanged:contentOffset];
    
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    if (baseIndex + 1 >= self.dataSource.count) {
        //右边越界了，不需要处理
        return;
    }
    CGFloat remainderRatio = ratio - baseIndex;
    CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
    CGRect rightCellFrame = [self getTargetCellFrame:baseIndex + 1];

    CGXCategoryIndicatorParamsModel *indicatorParamsModel = [[CGXCategoryIndicatorParamsModel alloc] init];
    indicatorParamsModel.selectedIndex = self.selectedIndex;
    indicatorParamsModel.leftIndex = baseIndex;
    indicatorParamsModel.leftCellFrame = leftCellFrame;
    indicatorParamsModel.rightIndex = baseIndex + 1;
    indicatorParamsModel.rightCellFrame = rightCellFrame;
    indicatorParamsModel.percent = remainderRatio;
    
    CGXCategoryCellClickedPosition position = CGXCategoryCellClickedPosition_Left;
    if (self.selectedIndex == baseIndex + 1) {
        position = CGXCategoryCellClickedPosition_Right;
    }
    
    if (remainderRatio == 0) {
        for (UIView<CGXCategoryIndicatorProtocol> *indicator in self.indicators) {
            [indicator reloadContentScrollViewDidScroll:indicatorParamsModel];
        }
    }else {
        CGXCategoryIndicatorCellModel *leftCellModel = (CGXCategoryIndicatorCellModel *)self.dataSource[baseIndex];
        leftCellModel.selectedType = CGXCategoryCellSelectedTypeUnknown;
        CGXCategoryIndicatorCellModel *rightCellModel = (CGXCategoryIndicatorCellModel *)self.dataSource[baseIndex + 1];
        rightCellModel.selectedType = CGXCategoryCellSelectedTypeUnknown;
        [self refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:remainderRatio];

        for (UIView<CGXCategoryIndicatorProtocol> *indicator in self.indicators) {
            [indicator reloadContentScrollViewDidScroll:indicatorParamsModel];
            if ([indicator isKindOfClass:[CGXCategoryIndicatorBackgroundView class]]) {
                CGRect leftMaskFrame = indicator.frame;
                leftMaskFrame.origin.x = leftMaskFrame.origin.x - leftCellFrame.origin.x;
                leftCellModel.backgroundViewMaskFrame = leftMaskFrame;

                CGRect rightMaskFrame = indicator.frame;
                rightMaskFrame.origin.x = rightMaskFrame.origin.x - rightCellFrame.origin.x;
                rightCellModel.backgroundViewMaskFrame = rightMaskFrame;
            }
        }

        CGXCategoryBaseCell *leftCell = (CGXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex inSection:0]];
        [leftCell reloadData:leftCellModel];
        CGXCategoryBaseCell *rightCell = (CGXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex + 1 inSection:0]];
        [rightCell reloadData:rightCellModel];
    }
}

- (BOOL)selectCellAtIndex:(NSInteger)index selectedType:(CGXCategoryCellSelectedType)selectedType {
    
    //是否点击了相对于选中cell左边的cell
    CGXCategoryCellClickedPosition clickedPosition = CGXCategoryCellClickedPosition_Left;
    if (index > self.selectedIndex) {
        clickedPosition = CGXCategoryCellClickedPosition_Right;
    }
    
    NSInteger lastSelectedIndex = self.selectedIndex;
    BOOL result = [super selectCellAtIndex:index selectedType:selectedType];
    if (!result) {
        return NO;
    }

    CGRect clickedCellFrame = [self getTargetCellFrame:index];
    
    CGXCategoryIndicatorCellModel *selectedCellModel = (CGXCategoryIndicatorCellModel *)self.dataSource[index];
    selectedCellModel.selectedType = selectedType;
    for (UIView<CGXCategoryIndicatorProtocol> *indicator in self.indicators) {
        CGXCategoryIndicatorParamsModel *indicatorParamsModel = [[CGXCategoryIndicatorParamsModel alloc] init];
        indicatorParamsModel.lastSelectedIndex = lastSelectedIndex;
        indicatorParamsModel.selectedIndex = index;
        indicatorParamsModel.selectedCellFrame = clickedCellFrame;
        indicatorParamsModel.selectedType = selectedType;
        [indicator reloadSelectedCell:indicatorParamsModel];
        if ([indicator isKindOfClass:[CGXCategoryIndicatorBackgroundView class]]) {
            CGRect maskFrame = indicator.frame;
            maskFrame.origin.x = maskFrame.origin.x - clickedCellFrame.origin.x;
            selectedCellModel.backgroundViewMaskFrame = maskFrame;
        }
    }

    CGXCategoryIndicatorCell *selectedCell = (CGXCategoryIndicatorCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [selectedCell reloadData:selectedCellModel];

    return YES;
}


- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    if (self.cellBackgroundColorGradientEnabled) {
        //处理cell背景色渐变
        CGXCategoryIndicatorCellModel *leftModel = (CGXCategoryIndicatorCellModel *)leftCellModel;
        CGXCategoryIndicatorCellModel *rightModel = (CGXCategoryIndicatorCellModel *)rightCellModel;
        if (leftModel.isSelected) {
            leftModel.cellBackgroundSelectedColor = [CGXCategoryFactory interpolationColorFrom:self.cellBackgroundSelectedColor to:self.cellBackgroundUnselectedColor percent:ratio];
            leftModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        }else {
            leftModel.cellBackgroundUnselectedColor = [CGXCategoryFactory interpolationColorFrom:self.cellBackgroundSelectedColor to:self.cellBackgroundUnselectedColor percent:ratio];
            leftModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        }
        if (rightModel.isSelected) {
            rightModel.cellBackgroundSelectedColor = [CGXCategoryFactory interpolationColorFrom:self.cellBackgroundUnselectedColor to:self.cellBackgroundSelectedColor percent:ratio];
            rightModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        }else {
            rightModel.cellBackgroundUnselectedColor = [CGXCategoryFactory interpolationColorFrom:self.cellBackgroundUnselectedColor to:self.cellBackgroundSelectedColor percent:ratio];
            rightModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        }
    }

}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    CGXCategoryIndicatorCellModel *myModel = (CGXCategoryIndicatorCellModel *)cellModel;
    myModel.normalBackgroundColor = self.normalBackgroundColor;
    myModel.normalBorderColor = self.normalBorderColor;
    myModel.selectedBackgroundColor = self.selectedBackgroundColor;
    myModel.selectedBorderColor = self.selectedBorderColor;
    myModel.borderLineWidth = self.borderLineWidth;
    myModel.backgroundCornerRadius = self.backgroundCornerRadius;
    myModel.backgroundWidth = self.backgroundWidth;
    myModel.backgroundHeight = self.backgroundHeight;
    
}
@end
