//
//  CGXCategoryBadgeView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2020/05/20.
//

#import "CGXCategoryBadgeView.h"
#import "CGXCategoryBadgeCell.h"
@implementation CGXCategoryBadgeView

- (void)dealloc
{
    
}
- (void)initializeData
{
    [super initializeData];
   
}

#pragma mark - Override

- (Class)preferredCellClass
{
    return [CGXCategoryBadgeCell class];
}
- (void)refreshState
{
    [super refreshState];
}
- (void)refreshDataSource
{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
        CGXCategoryBadgeCellModel *cellModel = [[CGXCategoryBadgeCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}
- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel
{
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
//    CGXCategoryBadgeCellModel *myUnselectedCellModel = (CGXCategoryBadgeCellModel *)unselectedCellModel;
//    CGXCategoryBadgeCellModel *myselectedCellModel = (CGXCategoryBadgeCellModel *)selectedCellModel;
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio
{
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    
//    CGXCategoryBadgeCellModel *leftModel = (CGXCategoryBadgeCellModel *)leftCellModel;
//    CGXCategoryBadgeCellModel *rightModel = (CGXCategoryBadgeCellModel *)rightCellModel;
}


- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index
{
    [super refreshCellModel:cellModel index:index];
    
    CGXCategoryBadgeCellModel *model = (CGXCategoryBadgeCellModel *)cellModel;
    model.badgeModel.numberString = [NSString stringWithFormat:@"%ld", (long)model.badgeModel.count];
}

/**
 更新某个文字
 */
- (void)updateWithTitle:(NSString *)title AtInter:(NSInteger)inter
{
    if (inter<0) {
        return;
    }
    if (inter>self.titleArray.count-1) {
        return;
    }
    [self.titleArray replaceObjectAtIndex:inter withObject:title];
    [self reloadCellAtIndex:inter];
    [self reloadData];
}
/**
 更新角标
 */
- (void)updateWithBadgeInter:(NSInteger)badgeInter AtInter:(NSInteger)inter NS_REQUIRES_SUPER
{
    if (inter>self.dataSource.count) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGXCategoryBadgeCellModel *model = (CGXCategoryBadgeCellModel *)self.dataSource[inter];
        CGXCategoryTitleBadgeModel *badge = model.badgeModel;
        badge.count = badgeInter;
        model.badgeModel = badge;
        [self reloadCellAtIndex:inter];
    });
}
/**
 更新角标
 */
- (void)updateWithBadge:(CGXCategoryTitleBadgeModel *)badgeModel AtInter:(NSInteger)inter
{
    if (inter>self.dataSource.count) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGXCategoryBadgeCellModel *model = (CGXCategoryBadgeCellModel *)self.dataSource[inter];
        model.badgeModel = badgeModel;
        [self reloadCellAtIndex:inter];
    });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
