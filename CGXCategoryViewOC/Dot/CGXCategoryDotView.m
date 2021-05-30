//
//  CGXCategoryDotView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryDotView.h"
#import "CGXCategoryDotCell.h"
#import "CGXCategoryDotCellModel.h"
@implementation CGXCategoryDotView

- (void)initializeData {
    [super initializeData];

    _relativePosition = CGXCategoryDotRelativePosition_TopRight;
    _dotSize = CGSizeMake(5, 5);
    _dotCornerRadius = CGXCategoryViewAutomaticDimension;
    _dotColor = [UIColor redColor];
    _dotStyle = CGXCategoryDotStyle_Solid;
    _dotOffset =  CGPointMake(0, 0);
    _dotborderColor = [UIColor redColor];
    _dotborderWidth = 2;
}

- (Class)preferredCellClass {
    [super preferredCellClass];
    return [CGXCategoryDotCell class];
}

- (void)refreshDataSource {
    [super refreshDataSource];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titleArray.count; i++) {
        CGXCategoryDotCellModel *cellModel = [[CGXCategoryDotCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    CGXCategoryDotCellModel *myCellModel = (CGXCategoryDotCellModel *)cellModel;
    myCellModel.relativePosition = self.relativePosition;
    myCellModel.dotSize = self.dotSize;
    myCellModel.dotColor = self.dotColor;
    myCellModel.dotOffset = self.dotOffset;
    myCellModel.dotStyle = self.dotStyle;
    myCellModel.dotborderWidth = self.dotborderWidth;
    myCellModel.dotborderColor = self.dotborderColor;
    if (self.dotCornerRadius == CGXCategoryViewAutomaticDimension) {
        myCellModel.dotCornerRadius = self.dotSize.height/2;
    }else {
        myCellModel.dotCornerRadius = self.dotCornerRadius;
    }
}
/**
 更新红点的显示隐藏
 */
- (void)updateWithDotHidden:(BOOL)hidden AtInter:(NSInteger)inter
{
    if (inter>self.dataSource.count) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGXCategoryDotCellModel *model = (CGXCategoryDotCellModel *)self.dataSource[inter];
        model.dotHidden = !hidden;
        [self reloadCellAtIndex:inter];
    });
}

@end
