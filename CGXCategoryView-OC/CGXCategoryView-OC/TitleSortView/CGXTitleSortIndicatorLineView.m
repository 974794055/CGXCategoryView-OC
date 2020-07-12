//
//  CGXTitleSortIndicatorLineView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleSortIndicatorLineView.h"
#import "CGXCategoryFactory.h"

@implementation CGXTitleSortIndicatorLineView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _alignmentStyle = CGXCategoryIndicatorAlignmentStyleNode;
        self.indicatorHeight = 3;
        self.indicatorWidth = 20;   //不支持CGXCategoryViewAutomaticDimension
    }
    return self;
}

#pragma mark - CGXCategoryIndicatorProtocol

- (void)reloadRefreshState:(CGXCategoryIndicatorParamsModel *)model
{
    [super reloadRefreshState:model];
    if (self.alignmentStyle != CGXCategoryIndicatorAlignmentStyleNode) {
        self.backgroundColor = self.indicatorColor;
        self.layer.cornerRadius = [self indicatorCornerRadiusValue:model.selectedCellFrame];
        
        
        
        CGFloat selectedLineWidth = [self indicatorWidthValue:model.selectedCellFrame];
        CGFloat x = model.selectedCellFrame.origin.x;
        if (self.alignmentStyle == CGXCategoryIndicatorAlignmentStyleTrailing) {
            x = model.selectedCellFrame.origin.x + model.selectedCellFrame.size.width - selectedLineWidth;
        }
        CGFloat y = self.superview.bounds.size.height - [self indicatorHeightValue:model.selectedCellFrame] - self.verticalMargin;
        if (self.componentPosition == CGXCategoryComponentPosition_Top) {
            y = self.verticalMargin;
        }
        self.frame = CGRectMake(x, y, selectedLineWidth, [self indicatorHeightValue:model.selectedCellFrame]);
    }
}

- (void)reloadContentScrollViewDidScroll:(CGXCategoryIndicatorParamsModel *)model {
    [super reloadContentScrollViewDidScroll:model];
    if (self.alignmentStyle != CGXCategoryIndicatorAlignmentStyleNode) {
        CGRect rightCellFrame = model.rightCellFrame;
        CGRect leftCellFrame = model.leftCellFrame;
        CGFloat percent = model.percent;
        CGFloat targetWidth = [self indicatorWidthValue:leftCellFrame];
        
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = targetWidth;
        CGFloat leftX = leftCellFrame.origin.x;
        CGFloat rightX = rightCellFrame.origin.x;
        if (self.alignmentStyle == CGXCategoryIndicatorAlignmentStyleTrailing) {
            leftX = leftCellFrame.origin.x + leftCellFrame.size.width - targetWidth;
            rightX = rightCellFrame.origin.x + rightCellFrame.size.width - targetWidth;
        }
        
        CGFloat targetX = [CGXCategoryFactory interpolationFrom:leftX to:rightX percent:percent];
        if (self.indicatorWidth == CGXCategoryViewAutomaticDimension) {
            targetWidth = [CGXCategoryFactory interpolationFrom:leftWidth to:rightWidth percent:percent];
        }
        //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
        if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
            CGRect frame = self.frame;
            frame.origin.x = targetX;
            frame.size.width = targetWidth;
            self.frame = frame;
        }
    }
}

- (void)reloadSelectedCell:(CGXCategoryIndicatorParamsModel *)model {
    [super reloadSelectedCell:model];
    if (self.alignmentStyle != CGXCategoryIndicatorAlignmentStyleNode) {
        CGRect targetIndicatorFrame = self.frame;
        CGFloat targetIndicatorWidth = [self indicatorWidthValue:model.selectedCellFrame];
        targetIndicatorFrame.origin.x = model.selectedCellFrame.origin.x;
        if (self.alignmentStyle == CGXCategoryIndicatorAlignmentStyleTrailing) {
            targetIndicatorFrame.origin.x = model.selectedCellFrame.origin.x + model.selectedCellFrame.size.width - targetIndicatorWidth;
        }
        targetIndicatorFrame.size.width = targetIndicatorWidth;
        if (self.scrollEnabled) {
            [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.frame = targetIndicatorFrame;
            } completion: nil];
        }else {
            self.frame = targetIndicatorFrame;
        }
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
