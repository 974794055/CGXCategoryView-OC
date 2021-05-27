//
//  CGXCategoryTitleSubView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleSubView.h"
@interface CGXCategoryTitleSubView()

@property (nonatomic , assign) CGFloat subAlpha;

@end

@implementation CGXCategoryTitleSubView

- (void)initializeData {
    [super initializeData];
    self.subAlpha = 1;
    self.subTitleFont = [UIFont boldSystemFontOfSize:12];
    self.titleFont = [UIFont systemFontOfSize:14];
    self.subTitleSelectedFont = [UIFont boldSystemFontOfSize:12];
    self.titleSelectedFont = [UIFont systemFontOfSize:14];
    self.subTitleNormalColor = [UIColor lightGrayColor];
    self.titleColor = [UIColor lightGrayColor];
    self.subTitleSelectedColor = [UIColor whiteColor];
    self.titleSelectedColor = [UIColor whiteColor];
    
    self.subTitleSBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];;
    self.subTitleNBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    self.subTitleTitleColorGradientEnabled = NO;
    self.subTitleSpace = 20;
    self.subTitleRadius = CGXCategoryViewAutomaticDimension;
    self.subTitleMargin = 10;
    self.positionStyle = CGXCategorySubTitlePositionStyle_Bottom;
}

//返回自定义的cell class
- (Class)preferredCellClass {
    [super preferredCellClass];
    return [CGXCategoryTitleSubCell class];
}

- (void)refreshDataSource {
    [super refreshDataSource];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.subTitleArray.count; i++) {
        CGXCategoryTitleSubCellModel *cellModel = [[CGXCategoryTitleSubCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}


- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];
    
    CGXCategoryTitleSubCellModel *myUnselectedCellModel = (CGXCategoryTitleSubCellModel *)unselectedCellModel;
    CGXCategoryTitleSubCellModel *myselectedCellModel = (CGXCategoryTitleSubCellModel *)selectedCellModel;
    
    myselectedCellModel.subTitleCurrentColor = myselectedCellModel.subTitleSelectedColor;
    myUnselectedCellModel.subTitleCurrentColor = myUnselectedCellModel.subTitleNormalColor;
    
}

- (void)refreshLeftCellModel:(CGXCategoryBaseCellModel *)leftCellModel rightCellModel:(CGXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];
    CGXCategoryTitleSubCellModel *leftModel = (CGXCategoryTitleSubCellModel *)leftCellModel;
    CGXCategoryTitleSubCellModel *rightModel = (CGXCategoryTitleSubCellModel *)rightCellModel;
    if (self.subTitleTitleColorGradientEnabled) {
        leftModel.subTitleCurrentColor = [CGXCategoryFactory interpolationColorFrom:self.subTitleSelectedColor to:self.subTitleNormalColor percent:ratio];
        rightModel.subTitleCurrentColor = [CGXCategoryFactory interpolationColorFrom:self.subTitleNormalColor to:self.subTitleSelectedColor percent:ratio];
    }
}
- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    CGXCategoryTitleSubCellModel *model = (CGXCategoryTitleSubCellModel *)cellModel;
    model.subTitle = self.subTitleArray[index];
    model.subTitleNormalColor = self.subTitleNormalColor;
    model.subTitleSelectedColor = self.subTitleSelectedColor;
    model.subTitleFont = self.subTitleFont;
    model.subTitleSelectedFont = self.subTitleSelectedFont;
    model.subTitleSpace = self.subTitleSpace;
    model.subTitleNBgColor = self.subTitleNBgColor;
    model.subTitleSBgColor = self.subTitleSBgColor;
    model.subTitleRadius = self.subTitleRadius;
    model.subTitleMargin = self.subTitleMargin;
    model.subAlpha = self.subAlpha;
    model.positionStyle = self.positionStyle;
    if (index == self.selectedIndex) {
        model.subTitleCurrentColor = model.subTitleSelectedColor;
    }else {
        model.subTitleCurrentColor = model.subTitleNormalColor;
    }
}


- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent
{
    CGFloat currentScale = [CGXCategoryFactory interpolationFrom:0 to:1 percent:percent];

    BOOL shouldReloadData = NO;
    if (self.subAlpha != currentScale) {
        //有变化才允许reloadData
        shouldReloadData = YES;
    }
    self.subAlpha = currentScale;
    if (shouldReloadData) {
        //只有参数有变化才reloadData
        [self refreshState];
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
