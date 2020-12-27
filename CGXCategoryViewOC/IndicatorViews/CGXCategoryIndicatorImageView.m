//
//  CGXCategoryIndicatorImageView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorImageView.h"
#import "CGXCategoryFactory.h"

@implementation CGXCategoryIndicatorImageView

- (void)initializeViews
{
    [super initializeViews];
    _indicatorImageViewSize = CGSizeMake(30, 20);
    _indicatorImageViewRollEnabled = NO;
    
    _indicatorImageView = [[UIImageView alloc] init];
    self.indicatorImageView.frame = CGRectMake(0, 0, self.indicatorImageViewSize.width, self.indicatorImageViewSize.height);
    self.indicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.indicatorImageView];
    
}

- (void)setIndicatorImageViewSize:(CGSize)indicatorImageViewSize {
    _indicatorImageViewSize = indicatorImageViewSize;
    
    self.indicatorImageView.frame = CGRectMake(0, 0, self.indicatorImageViewSize.width, self.indicatorImageViewSize.height);
}

#pragma mark - CGXCategoryIndicatorProtocol

- (void)reloadRefreshState:(CGXCategoryIndicatorParamsModel *)model {
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - self.indicatorImageViewSize.width)/2;
    CGFloat y = self.superview.bounds.size.height - self.indicatorImageViewSize.height - self.verticalMargin;
    if (self.componentPosition == CGXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, self.indicatorImageViewSize.width, self.indicatorImageViewSize.height);
}

- (void)reloadContentScrollViewDidScroll:(CGXCategoryIndicatorParamsModel *)model {
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetWidth = self.indicatorImageViewSize.width;
    CGFloat targetX = 0;
    
    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - targetWidth)/2;
        targetX = [CGXCategoryFactory interpolationFrom:leftX to:rightX percent:percent];
    }
    
    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        self.frame = frame;
        
        if (self.indicatorImageViewRollEnabled) {
            self.indicatorImageView.transform = CGAffineTransformMakeRotation(M_PI*2*percent);
        }
    }
}

- (void)reloadSelectedCell:(CGXCategoryIndicatorParamsModel *)model {
    CGRect toFrame = self.frame;
    toFrame.origin.x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - self.indicatorImageViewSize.width)/2;
    if (self.scrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
        }];
        if (self.indicatorImageViewRollEnabled &&  model.selectedType == CGXCategoryCellSelectedTypeClick) {
            [self.indicatorImageView.layer removeAnimationForKey:@"rotate"];
            CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            if (model.selectedIndex > model.lastSelectedIndex) {
                rotateAnimation.fromValue = @(0);
                rotateAnimation.toValue = @(M_PI*2*((model.clickedPosition == CGXCategoryCellClickedPosition_Left) ? -1 : 1));
                //                rotateAnimation.toValue = @(M_PI*2);
            }else {
                rotateAnimation.fromValue = @(M_PI*2);
                //                rotateAnimation.toValue = @(0);
                rotateAnimation.toValue = @(M_PI*2*((model.clickedPosition == CGXCategoryCellClickedPosition_Left) ? -1 : 1));
            }
            rotateAnimation.fillMode = kCAFillModeBackwards;
            rotateAnimation.removedOnCompletion = YES;
            rotateAnimation.duration = 0.25;
            [self.indicatorImageView.layer addAnimation:rotateAnimation forKey:@"rotate"];
        }
    }else {
        self.frame = toFrame;
    }
}


@end
