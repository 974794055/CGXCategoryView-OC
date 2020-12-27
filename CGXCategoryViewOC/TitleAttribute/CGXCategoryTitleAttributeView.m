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

@interface CGXCategoryTitleAttributeView()

@property (nonatomic, strong,readwrite) NSMutableArray <NSAttributedString *> *attributeTitles;

@property (nonatomic, strong,readwrite) NSMutableArray <NSAttributedString *> *attributeSelectTitles;


@end

@implementation CGXCategoryTitleAttributeView

#pragma mark - Override

- (void)initializeData
{
    [super initializeData];
}
//返回自定义的cell class
- (Class)preferredCellClass {
    return [CGXCategoryTitleAttributeCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.attributeTitles.count; i++) {
        CGXCategoryTitleAttributeCellModel *cellModel = [[CGXCategoryTitleAttributeCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
    
    NSAssert((self.attributeTitles.count ==self.attributeSelectTitles.count), @"attributeTitles和attributeSelectTitles数据数量要一致");
}

- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    if (self.cellWidth == CGXCategoryViewAutomaticDimension) {
        return ceilf([self.attributeTitles[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.width);
    }else {
        return self.cellWidth;
    }
}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];
    
    CGXCategoryTitleAttributeCellModel *model = (CGXCategoryTitleAttributeCellModel *)cellModel;
    model.attributeTitle = self.attributeTitles[index];
    model.attributeSelectTitle = self.attributeSelectTitles[index];
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
