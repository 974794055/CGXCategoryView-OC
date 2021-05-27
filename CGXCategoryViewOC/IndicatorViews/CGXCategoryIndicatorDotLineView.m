//
//  CGXCategoryIndicatorDotLineView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorDotLineView.h"
#import "CGXCategoryFactory.h"
#import "CGXCategoryViewAnimator.h"
@interface CGXCategoryIndicatorDotLineView ()
@property (nonatomic, strong) CGXCategoryViewAnimator *animator;
@end
@implementation CGXCategoryIndicatorDotLineView

- (void)initializeViews
{
    [super initializeViews];
    _lineWidth = 50;
    self.indicatorWidth = 10;
    self.indicatorHeight = 10;
}

#pragma mark - CGXCategoryIndicatorProtocol

- (void)reloadRefreshState:(CGXCategoryIndicatorParamsModel *)model {
    self.backgroundColor = self.indicatorColor;
    self.layer.cornerRadius = self.indicatorHeight/2;

    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - self.indicatorWidth)/2;
    CGFloat y = self.superview.bounds.size.height - self.indicatorHeight - self.verticalMargin;
    if (self.componentPosition == CGXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, self.indicatorWidth, self.indicatorHeight);
}

- (void)reloadContentScrollViewDidScroll:(CGXCategoryIndicatorParamsModel *)model {
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetX = 0;
    CGFloat targetWidth = self.indicatorWidth;

    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = self.indicatorWidth;

        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;
        CGFloat centerX = leftX + (rightX - leftX - self.lineWidth)/2;

        //前50%，移动x，增加宽度；后50%，移动x并减小width
        if (percent <= 0.5) {
            targetX = [CGXCategoryFactory interpolationFrom:leftX to:centerX percent:percent*2];
            targetWidth = [CGXCategoryFactory interpolationFrom:self.indicatorWidth to:self.lineWidth percent:percent*2];
        }else {
            targetX = [CGXCategoryFactory interpolationFrom:centerX to:rightX percent:(percent - 0.5)*2];
            targetWidth = [CGXCategoryFactory interpolationFrom:self.lineWidth to:self.indicatorWidth percent:(percent - 0.5)*2];
        }
    }

    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        frame.size.width = targetWidth;
        self.frame = frame;
    }
}

- (void)reloadSelectedCell:(CGXCategoryIndicatorParamsModel *)model {
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - self.indicatorWidth)/2;
    CGFloat y = self.superview.bounds.size.height - self.indicatorHeight - self.verticalMargin;
    if (self.componentPosition == CGXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    CGRect toFrame = CGRectMake(x, y, self.indicatorWidth, self.indicatorHeight);

    if (self.scrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {

        }];
    }else {
        self.frame = toFrame;
    }
}

@end
