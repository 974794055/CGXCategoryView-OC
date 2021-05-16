//
//  CGXCategoryIndicatorRainbowLineView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorRainbowLineView.h"
#import "CGXCategoryFactory.h"

@implementation CGXCategoryIndicatorRainbowLineView

- (void)initializeViews
{
    [super initializeViews];
}
- (void)reloadRefreshState:(CGXCategoryIndicatorParamsModel *)model {
    [super reloadRefreshState:model];

    UIColor *color = self.indicatorColors[model.selectedIndex];
    self.backgroundColor = color;
}
- (void)reloadContentScrollViewDidScroll:(CGXCategoryIndicatorParamsModel *)model {
    [super reloadContentScrollViewDidScroll:model];

    UIColor *leftColor = self.indicatorColors[model.leftIndex];
    UIColor *rightColor = self.indicatorColors[model.rightIndex];
    UIColor *color = [CGXCategoryFactory interpolationColorFrom:leftColor to:rightColor percent:model.percent];
    self.backgroundColor = color;
}
- (void)reloadSelectedCell:(CGXCategoryIndicatorParamsModel *)model {
    [super reloadSelectedCell:model];

    UIColor *color = self.indicatorColors[model.selectedIndex];
    self.backgroundColor = color;
}


@end
