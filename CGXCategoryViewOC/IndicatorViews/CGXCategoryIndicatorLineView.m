//
//  CGXCategoryIndicatorLineView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorLineView.h"
#import "CGXCategoryFactory.h"
#import "CGXCategoryViewDefines.h"
#import "CGXCategoryViewAnimator.h"

@interface CGXCategoryIndicatorLineView ()
@property (nonatomic, strong) CGXCategoryViewAnimator *animator;
@end

@implementation CGXCategoryIndicatorLineView

- (void)initializeViews
{
    [super initializeViews];
    _lineStyle = CGXCategoryIndicatorLineStyle_Normal;
    _lineScrollOffsetX = 10;
    self.indicatorHeight = 3;
}

#pragma mark - CGXCategoryIndicatorProtocol

- (void)reloadRefreshState:(CGXCategoryIndicatorParamsModel *)model {
    self.backgroundColor = self.indicatorColor;
    self.layer.cornerRadius = [self getIndicatorLineViewCornerRadius];
    CGFloat selectedLineWidth = [self getIndicatorLineViewWidth:model.selectedCellFrame];
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - selectedLineWidth)/2;
    CGFloat y = self.superview.bounds.size.height - self.indicatorHeight - self.verticalMargin;
    if (self.componentPosition == CGXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, selectedLineWidth, self.indicatorHeight);
}

- (void)reloadContentScrollViewDidScroll:(CGXCategoryIndicatorParamsModel *)model {
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetX = leftCellFrame.origin.x;
    CGFloat targetWidth = [self getIndicatorLineViewWidth:leftCellFrame];
    
    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = [self getIndicatorLineViewWidth:rightCellFrame];
        
        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;
        
        if (self.lineStyle == CGXCategoryIndicatorLineStyle_Normal) {
            targetX = [CGXCategoryFactory interpolationFrom:leftX to:rightX percent:percent];
            
            if (self.indicatorWidth == CGXCategoryViewAutomaticDimension) {
                targetWidth = [CGXCategoryFactory interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:percent];
            }
        }else if (self.lineStyle == CGXCategoryIndicatorLineStyle_JD) {
            CGFloat maxWidth = rightX - leftX + rightWidth;
            //前50%，只增加width；后50%，移动x并减小width
            if (percent <= 0.5) {
                targetX = leftX;
                targetWidth = [CGXCategoryFactory interpolationFrom:leftWidth to:maxWidth percent:percent*2];
            }else {
                targetX = [CGXCategoryFactory interpolationFrom:leftX to:rightX percent:(percent - 0.5)*2];
                targetWidth = [CGXCategoryFactory interpolationFrom:maxWidth to:rightWidth percent:(percent - 0.5)*2];
            }
        }else if (self.lineStyle == CGXCategoryIndicatorLineStyle_IQIYI) {
            //前50%，增加width，并少量移动x；后50%，少量移动x并减小width
            CGFloat offsetX = self.lineScrollOffsetX;//x的少量偏移量
            CGFloat maxWidth = rightX - leftX + rightWidth - offsetX*2;
            if (percent <= 0.5) {
                targetX = [CGXCategoryFactory interpolationFrom:leftX to:leftX + offsetX percent:percent*2];;
                targetWidth = [CGXCategoryFactory interpolationFrom:leftWidth to:maxWidth percent:percent*2];
            }else {
                targetX = [CGXCategoryFactory interpolationFrom:(leftX + offsetX) to:rightX percent:(percent - 0.5)*2];
                targetWidth = [CGXCategoryFactory interpolationFrom:maxWidth to:rightWidth percent:(percent - 0.5)*2];
            }
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
    CGFloat targetWidth = [self getIndicatorLineViewWidth:model.selectedCellFrame];
    CGRect toFrame = self.frame;
    toFrame.origin.x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - targetWidth)/2.0;
    toFrame.size.width = targetWidth;
    
    if (self.scrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
            
        }];
    }else {
        self.frame = toFrame;
    }
}

# pragma mark - Private

- (CGFloat)getIndicatorLineViewCornerRadius
{
    if (self.indicatorCornerRadius == CGXCategoryViewAutomaticDimension) {
        return self.indicatorHeight/2;
    }
    return self.indicatorCornerRadius;
}

- (CGFloat)getIndicatorLineViewWidth:(CGRect)cellFrame
{
    if (self.indicatorWidth == CGXCategoryViewAutomaticDimension) {
        return cellFrame.size.width;
    }
    return self.indicatorWidth;
}

@end
