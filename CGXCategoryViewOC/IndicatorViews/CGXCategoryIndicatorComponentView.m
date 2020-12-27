//
//  CGXCategoryComponentBaseView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorComponentView.h"

@implementation CGXCategoryIndicatorComponentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSAssert(NO, @"Use initWithFrame");
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    _componentPosition = CGXCategoryComponentPosition_Bottom;
    _scrollEnabled = YES;
    _verticalMargin = 0;
    _scrollAnimationDuration = 0.25;
    _indicatorWidth = CGXCategoryViewAutomaticDimension;
    _indicatorHeight = CGXCategoryViewAutomaticDimension;
    _indicatorCornerRadius = CGXCategoryViewAutomaticDimension;
    _indicatorColor = [UIColor redColor];
    _indicatorWidthIncrement = 0;
    _scrollStyle = CGXCategoryIndicatorScrollStyleSimple;
}
- (CGFloat)indicatorWidthValue:(CGRect)cellFrame {
    if (self.indicatorWidth == CGXCategoryViewAutomaticDimension) {
        return cellFrame.size.width + self.indicatorWidthIncrement;
    }
    return self.indicatorWidth + self.indicatorWidthIncrement;
}

- (CGFloat)indicatorHeightValue:(CGRect)cellFrame {
    if (self.indicatorHeight == CGXCategoryViewAutomaticDimension) {
        return cellFrame.size.height;
    }
    return self.indicatorHeight;
}

- (CGFloat)indicatorCornerRadiusValue:(CGRect)cellFrame {
    if (self.indicatorCornerRadius == CGXCategoryViewAutomaticDimension) {
        return [self indicatorHeightValue:cellFrame]/2;
    }
    return self.indicatorCornerRadius;
}

#pragma mark - CGXCategoryIndicatorProtocol

- (void)reloadRefreshState:(CGXCategoryIndicatorParamsModel *)model {

}

- (void)reloadContentScrollViewDidScroll:(CGXCategoryIndicatorParamsModel *)model {

}

- (void)reloadSelectedCell:(CGXCategoryIndicatorParamsModel *)model {
    
}

@end
