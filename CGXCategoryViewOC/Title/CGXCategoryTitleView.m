//
//  CGXCategoryView-OC.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleView.h"

@interface CGXCategoryTitleView ()

@end

@implementation CGXCategoryTitleView

- (void)initializeData
{
    [super initializeData];
    _titleNumberOfLines = 1;
    _titleLabelZoomEnabled = NO;
    _titleLabelZoomScale = 1.2;
    _titleColor = [UIColor blackColor];
    _titleSelectedColor = [UIColor redColor];
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColorGradientEnabled = NO;
    _titleLabelMaskEnabled = NO;
    _titleLabelZoomScrollGradientEnabled = YES;
    _titleLabelStrokeWidthEnabled = NO;
    _titleLabelSelectedStrokeWidth = -3;
    _titleArray = [NSMutableArray array];
    _titleLabelAnchorPointStyle =  CGXCategoryTitleLabelAnchorPointStyleCenter;
    
}

- (UIFont *)titleSelectedFont
{
    if (_titleSelectedFont != nil) {
        return _titleSelectedFont;
    }
    return self.titleFont;
}

#pragma mark - Override

- (Class)preferredCellClass
{
    [super preferredCellClass];
    return [CGXCategoryTitleCell class];
}
- (void)refreshState
{
    [super refreshState];
}
- (void)refreshDataSource
{
    [super refreshDataSource];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
        CGXCategoryTitleCellModel *cellModel = [[CGXCategoryTitleCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}
- (void)setTitleArray:(NSMutableArray<NSString *> *)titleArray
{
    _titleArray = titleArray;
    [self reloadData];
}
- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel
{
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    CGXCategoryTitleCellModel *myUnselectedCellModel = (CGXCategoryTitleCellModel *)unselectedCellModel;
    myUnselectedCellModel.titleCurrentColor = myUnselectedCellModel.titleNormalColor;
    myUnselectedCellModel.titleLabelCurrentZoomScale = myUnselectedCellModel.titleLabelNormalZoomScale;
    myUnselectedCellModel.titleLabelCurrentStrokeWidth = myUnselectedCellModel.titleLabelNormalStrokeWidth;
    
    CGXCategoryTitleCellModel *myselectedCellModel = (CGXCategoryTitleCellModel *)selectedCellModel;
    myselectedCellModel.titleCurrentColor = myUnselectedCellModel.titleSelectedColor;
    myselectedCellModel.titleLabelCurrentZoomScale = myUnselectedCellModel.titleLabelSelectedZoomScale;
    myselectedCellModel.titleLabelCurrentStrokeWidth = myUnselectedCellModel.titleLabelSelectedStrokeWidth;
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio
{
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    
    CGXCategoryTitleCellModel *leftModel = (CGXCategoryTitleCellModel *)leftCellModel;
    CGXCategoryTitleCellModel *rightModel = (CGXCategoryTitleCellModel *)rightCellModel;
    
    if (self.titleLabelZoomEnabled && self.titleLabelZoomScrollGradientEnabled) {
        leftModel.titleLabelCurrentZoomScale = [CGXCategoryFactory interpolationFrom:self.titleLabelZoomScale to:1.0 percent:ratio];
        rightModel.titleLabelCurrentZoomScale = [CGXCategoryFactory interpolationFrom:1.0 to:self.titleLabelZoomScale percent:ratio];
    }
    
    if (self.titleLabelStrokeWidthEnabled) {
        leftModel.titleLabelCurrentStrokeWidth = [CGXCategoryFactory interpolationFrom:leftModel.titleLabelSelectedStrokeWidth to:leftModel.titleLabelNormalStrokeWidth percent:ratio];
        rightModel.titleLabelCurrentStrokeWidth = [CGXCategoryFactory interpolationFrom:rightModel.titleLabelNormalStrokeWidth to:rightModel.titleLabelSelectedStrokeWidth percent:ratio];
    }
    
    if (self.titleColorGradientEnabled) {
        leftModel.titleCurrentColor = [CGXCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
        rightModel.titleCurrentColor = [CGXCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index
{
    [super preferredCellWidthAtIndex:index];
    if (self.cellWidth == CGXCategoryViewAutomaticDimension) {
        if (self.titleDataSource && [self.titleDataSource respondsToSelector:@selector(categoryTitleView:AtIndex:)]) {
            return [self.titleDataSource categoryTitleView:self AtIndex:index];
        }else {
            return ceilf([self.titleArray[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.width);
        }
    }else {
        return self.cellWidth;
    }
}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index
{
    [super refreshCellModel:cellModel index:index];
    
    CGXCategoryTitleCellModel *model = (CGXCategoryTitleCellModel *)cellModel;
    if (!(self.titleArray.count == 0 || index<0 || index>self.titleArray.count-1)) {
        model.title = self.titleArray[index];
    }
    model.titleFont = self.titleFont;
    model.titleSelectedFont = self.titleSelectedFont;
    model.titleNormalColor = self.titleColor;
    model.titleSelectedColor = self.titleSelectedColor;
    model.titleLabelMaskEnabled = self.titleLabelMaskEnabled;
    model.titleLabelZoomEnabled = self.titleLabelZoomEnabled;
    model.titleLabelNormalZoomScale = 1;
    model.titleLabelSelectedZoomScale = self.titleLabelZoomScale;
    model.titleLabelStrokeWidthEnabled = self.titleLabelStrokeWidthEnabled;
    model.titleLabelNormalStrokeWidth = 0;
    model.titleLabelSelectedStrokeWidth = self.titleLabelSelectedStrokeWidth;
    model.titleLabelVerticalOffset = self.titleLabelVerticalOffset;
    model.titleLabelAnchorPointStyle = self.titleLabelAnchorPointStyle;
    if (index == self.selectedIndex) {
        model.titleCurrentColor = self.titleSelectedColor;
        model.titleLabelCurrentZoomScale = model.titleLabelSelectedZoomScale;
        model.titleLabelCurrentStrokeWidth= model.titleLabelSelectedStrokeWidth;
    }else {
        model.titleCurrentColor = model.titleNormalColor;
        model.titleLabelCurrentZoomScale = model.titleLabelNormalZoomScale;
        model.titleLabelCurrentStrokeWidth = model.titleLabelNormalStrokeWidth;
    }
}

@end
