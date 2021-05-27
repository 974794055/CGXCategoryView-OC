//
//  CGXCategoryTitleAttributeView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleAttributeView.h"
#import "CGXCategoryTitleAttributeCell.h"
#import "CGXCategoryTitleAttributeCellModel.h"
#import "CGXCategoryFactory.h"
@interface CGXCategoryTitleAttributeView()

@property (nonatomic, strong,readwrite) NSMutableArray <NSAttributedString *> *attributeTitles;

@property (nonatomic, strong,readwrite) NSMutableArray <NSAttributedString *> *attributeSelectTitles;


@end

@implementation CGXCategoryTitleAttributeView

#pragma mark - Override

- (void)initializeData
{
    [super initializeData];
    self.attributeTitles = [NSMutableArray array];
    self.attributeSelectTitles = [NSMutableArray array];
    self.titleColor = [UIColor blackColor];
    self.titleSelectedColor = [UIColor redColor];
    self.titleColorGradientEnabled = NO;
    
}
//返回自定义的cell class
- (Class)preferredCellClass {
    [super preferredCellClass];
    return [CGXCategoryTitleAttributeCell class];
}

- (void)refreshDataSource {
    [super refreshDataSource];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.attributeTitles.count; i++) {
        CGXCategoryTitleAttributeCellModel *cellModel = [[CGXCategoryTitleAttributeCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
    
    NSAssert((self.attributeTitles.count ==self.attributeSelectTitles.count), @"attributeTitles和attributeSelectTitles数据数量要一致");
}
- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    [super preferredCellWidthAtIndex:index];
    if (self.cellWidth == CGXCategoryViewAutomaticDimension) {
            return ceilf([self.attributeTitles[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.width)+self.cellWidthIncrement;
    }else {
        return self.cellWidth;
    }
}

- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    CGXCategoryTitleAttributeCellModel *myUnselectedCellModel = (CGXCategoryTitleAttributeCellModel *)unselectedCellModel;
    myUnselectedCellModel.titleCurrentColor = self.titleColor;
    
    CGXCategoryTitleAttributeCellModel *myselectedCellModel = (CGXCategoryTitleAttributeCellModel *)selectedCellModel;
    myselectedCellModel.titleCurrentColor = self.titleSelectedColor;
}
- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    CGXCategoryTitleAttributeCellModel *leftModel = (CGXCategoryTitleAttributeCellModel *)leftCellModel;
    CGXCategoryTitleAttributeCellModel *rightModel = (CGXCategoryTitleAttributeCellModel *)rightCellModel;
    leftModel.titleCurrentColor = [CGXCategoryFactory interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
    rightModel.titleCurrentColor = [CGXCategoryFactory interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];
    
    CGXCategoryTitleAttributeCellModel *model = (CGXCategoryTitleAttributeCellModel *)cellModel;
    model.attributeTitle = self.attributeTitles[index];
    model.attributeSelectTitle = self.attributeSelectTitles[index];
    model.titleColorGradientEnabled = self.titleColorGradientEnabled;
    if (index == self.selectedIndex) {
        model.titleCurrentColor = self.titleSelectedColor;
    }else {
        model.titleCurrentColor = self.titleColor;
    }
}
/**
 更新富文本
 normalAttary：默认状态
 selectAttary：选中状态
 */
- (void)updateWithAttribute:(NSMutableArray <NSAttributedString *> *)normalAttary SelectAttribute:(NSMutableArray <NSAttributedString *> *)selectAttary
{
    [self.attributeTitles removeAllObjects];
    [self.attributeSelectTitles removeAllObjects];
    self.attributeTitles = normalAttary;
    self.attributeSelectTitles = selectAttary;
    [self reloadData];
}

/**
 更新某个富文本
 */
- (void)updateWithAttributeString:(NSAttributedString *)normalAtttibutrd SelectAttributeString:(NSAttributedString *)selectAtttibutrd AtInter:(NSInteger)inter
{
    if (inter<0) {
        return;
    }
    if (inter>self.attributeTitles.count-1) {
        return;
    }
    [self.attributeTitles replaceObjectAtIndex:inter withObject:normalAtttibutrd];
    [self.attributeSelectTitles replaceObjectAtIndex:inter withObject:selectAtttibutrd];
    [self reloadCellAtIndex:inter];
}
@end
