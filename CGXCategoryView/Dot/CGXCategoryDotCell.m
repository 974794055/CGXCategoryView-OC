//
//  CGXCategoryDotCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryDotCell.h"
#import "CGXCategoryDotCellModel.h"

@interface CGXCategoryDotCell ()
@property (nonatomic, strong) CALayer *dotLayer;
@end

@implementation CGXCategoryDotCell

- (void)initializeViews {
    [super initializeViews];

    _dotLayer = [CALayer layer];
    [self.contentView.layer addSublayer:self.dotLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [CATransaction begin];
    [CATransaction setDisableActions:YES];

    CGXCategoryDotCellModel *myCellModel = (CGXCategoryDotCellModel *)self.cellModel;
    self.dotLayer.bounds = CGRectMake(0, 0, myCellModel.dotSize.width, myCellModel.dotSize.height);
    switch (myCellModel.relativePosition) {
        case CGXCategoryDotRelativePosition_TopLeft:
        {
            self.dotLayer.position = CGPointMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame));
        }
            break;
        case CGXCategoryDotRelativePosition_TopRight:
        {
            self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame));
        }
            break;
        case CGXCategoryDotRelativePosition_BottomLeft:
        {
            self.dotLayer.position = CGPointMake(CGRectGetMinX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame));
        }
            break;
        case CGXCategoryDotRelativePosition_BottomRight:
        {
            self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMaxY(self.titleLabel.frame));
        }
            break;

        default:
            break;
    }
    self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame));

    [CATransaction commit];
}

- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    CGXCategoryDotCellModel *myCellModel = (CGXCategoryDotCellModel *)cellModel;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.dotLayer.hidden = !myCellModel.dotHidden;
    self.dotLayer.backgroundColor = myCellModel.dotColor.CGColor;
    self.dotLayer.cornerRadius = myCellModel.dotCornerRadius;
    [CATransaction commit];

    [self setNeedsLayout];
}

@end