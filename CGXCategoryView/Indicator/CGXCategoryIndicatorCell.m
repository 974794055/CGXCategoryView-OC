//
//  CGXCategoryComponetCell.m
//  DQGuess
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorCell.h"
#import "CGXCategoryIndicatorCellModel.h"

@interface CGXCategoryIndicatorCell ()
@property (nonatomic, strong) UIView *separatorLine;

@property (nonatomic, strong) CALayer *bgLayer;

@end

@implementation CGXCategoryIndicatorCell

- (void)initializeViews
{
    [super initializeViews];

    self.separatorLine = [[UIView alloc] init];
    self.separatorLine.hidden = YES;
    [self.contentView addSubview:self.separatorLine];
    
    self.bgLayer = [CALayer layer];
    [self.contentView.layer insertSublayer:self.bgLayer atIndex:0];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGXCategoryIndicatorCellModel *model = (CGXCategoryIndicatorCellModel *)self.cellModel;
    CGFloat lineWidth = model.separatorLineSize.width;
    CGFloat lineHeight = model.separatorLineSize.height;

    self.separatorLine.frame = CGRectMake(self.bounds.size.width - lineWidth + self.cellModel.cellSpacing/2, (self.bounds.size.height - lineHeight)/2.0, lineWidth, lineHeight);

   
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat bgWidth = self.contentView.bounds.size.width;
    CGFloat bgHeight = self.contentView.bounds.size.height;

    if (model.backgroundWidth != CGXCategoryViewAutomaticDimension) {
        bgWidth = model.backgroundWidth;
    }
    
    if (model.backgroundHeight != CGXCategoryViewAutomaticDimension) {
        bgHeight = model.backgroundHeight;
    }
    self.bgLayer.bounds = CGRectMake(0, 0, bgWidth, bgHeight);
    self.bgLayer.position = self.contentView.center;
    

    [CATransaction commit];
}

- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CGXCategoryIndicatorCellModel *model = (CGXCategoryIndicatorCellModel *)cellModel;
    if (model.cellBackgroundColorGradientEnabled) {
        if (model.isSelected) {
            self.contentView.backgroundColor = model.cellBackgroundSelectedColor;
        }else {
            self.contentView.backgroundColor = model.cellBackgroundUnselectedColor;
        }
    }
    self.separatorLine.backgroundColor = model.separatorLineColor;
    self.separatorLine.hidden = !model.sepratorLineShowEnabled;
    
    

    self.bgLayer.borderWidth = model.borderLineWidth;
    self.bgLayer.cornerRadius = model.backgroundCornerRadius;
    if (model.isSelected) {
        self.bgLayer.backgroundColor = model.selectedBackgroundColor.CGColor;
        self.bgLayer.borderColor = model.selectedBorderColor.CGColor;
    }else {
        self.bgLayer.backgroundColor = model.normalBackgroundColor.CGColor;
        self.bgLayer.borderColor = model.normalBorderColor.CGColor;
    }
    [CATransaction commit];
}

@end
