//
//  CGXCategoryIndicatorArcView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorArcView.h"

@interface CGXCategoryIndicatorArcView ()
@property (nonatomic, strong) CAShapeLayer *triangleLayer;
@end
@implementation CGXCategoryIndicatorArcView

- (void)initializeViews
{
    [super initializeViews];
    self.indicatorWidth = CGXCategoryViewAutomaticDimension;
    self.indicatorHeight = CGXCategoryViewAutomaticDimension;
    self.indicatorCornerRadius = CGXCategoryViewAutomaticDimension;
    self.indicatorWidthIncrement = 20;
    self.indicatorCornerRadius = CGXCategoryViewAutomaticDimension;
    self.indicatorHeight = CGXCategoryViewAutomaticDimension;
    self.verticalSpace = 20;
    self.racRound = 15;
    self.racSpace = 10;
    self.racStartAngle = M_PI_2 / 3.0;
    _triangleLayer = [CAShapeLayer layer];
    [self.layer addSublayer:self.triangleLayer];
    
    self.specialStyle = CGXCategoryIndicatorArcStyle_IQIYI;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.indicatorHeight >  CGRectGetHeight(self.bounds)) {
        self.indicatorHeight =  CGRectGetHeight(self.bounds);
    }
}
#pragma mark - CGXCategoryIndicatorProtocol

- (void)reloadRefreshState:(CGXCategoryIndicatorParamsModel *)model
{
    [super reloadRefreshState:model];
    [self updateA];
}

- (void)reloadContentScrollViewDidScroll:(CGXCategoryIndicatorParamsModel *)model {
    [super reloadContentScrollViewDidScroll:model];
    [self updateA];
}

- (void)reloadSelectedCell:(CGXCategoryIndicatorParamsModel *)model {
    [super reloadSelectedCell:model];
    [self updateA];
}

- (void)updateA
{
    self.backgroundColor = [UIColor clearColor];
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    self.triangleLayer.fillColor = self.indicatorColor.CGColor;
    self.triangleLayer.frame = self.bounds;
    CGFloat round =  CGRectGetHeight(self.bounds)/2.0;
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    UIBezierPath *path = [UIBezierPath bezierPath];
    switch (self.specialStyle) {

        case CGXCategoryIndicatorArcStyle_Round:
        {
            round = (self.indicatorCornerRadius == CGXCategoryViewAutomaticDimension ? CGRectGetHeight(self.bounds)/2.0:self.indicatorCornerRadius);
            CGFloat space = 0;
            if (self.indicatorHeight != CGXCategoryViewAutomaticDimension) {
                space = (height - self.indicatorHeight)/2.0;
                if (self.indicatorHeight > height) {
                    space = 0;
                }
            }
            [path moveToPoint:CGPointMake(0, space)];
            [path addArcWithCenter:CGPointMake(0, height/2.0) radius:round startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
            [path addLineToPoint:CGPointMake(0, height-space)];
            [path addLineToPoint:CGPointMake(width, height-space)];
            [path addArcWithCenter:CGPointMake(width, height/2.0) radius:round startAngle:M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
            [path addLineToPoint:CGPointMake(width, space)];
        }
            break;
        case CGXCategoryIndicatorArcStyle_IQIYI:
        {
            CGFloat verticalSpace = self.verticalSpace;
            [path moveToPoint:CGPointMake(verticalSpace, 0)];
            [path addCurveToPoint:CGPointMake(0, height)
                    controlPoint1:CGPointMake(verticalSpace/3.0, verticalSpace/3.0)
                    controlPoint2:CGPointMake(verticalSpace/3.0 * 2, height-verticalSpace/3.0)];
            [path addLineToPoint:CGPointMake(0, height)];
            [path addLineToPoint:CGPointMake(width, height)];
            [path addCurveToPoint:CGPointMake(width-verticalSpace, 0)
                    controlPoint1:CGPointMake(width-verticalSpace/3.0 * 2, height-verticalSpace/3.0)
                    controlPoint2:CGPointMake(width-verticalSpace/3.0, verticalSpace/3.0)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width-verticalSpace, 0)];
        }
        default:
            break;
    }
    [path closePath];
    self.triangleLayer.path = path.CGPath;
    [CATransaction commit];
}

#define kMargin 10

// 重写 drawRect 方法
- (void)drawRect:(CGRect)rect{
    
    if (self.specialStyle == CGXCategoryIndicatorArcStyle_Arc) {
        // 绘制一段圆弧
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame)- self.racSpace - self.racRound) radius:self.racRound startAngle:self.racStartAngle endAngle:M_PI - self.racStartAngle clockwise:YES];
        path.lineWidth = 3;
        [self.indicatorColor set];
        [path stroke];
        [path closePath];
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
