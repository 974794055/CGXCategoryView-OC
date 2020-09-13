//
//  CGXCategoryTitleSubtitleCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleSubtitleCell.h"

@interface CGXCategoryTitleSubtitleCell ()

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) CGXCategoryTitleSubtitleCellModel *subModel;

@end

@implementation CGXCategoryTitleSubtitleCell

- (void)initializeViews
{
    [super initializeViews];
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.clipsToBounds = YES;
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.subTitleLabel];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    NSLayoutConstraint *titleLabelCenterX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *titleLabelCenterY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    NSLayoutConstraint *timeLabelCenterX = [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *timeLabelCenterY = [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    if (self.subModel.titleSpace != CGXCategoryViewAutomaticDimension) {
        titleLabelCenterY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:self.subModel.titleSpace];
    }
    if (self.subModel.subTitleSpace != CGXCategoryViewAutomaticDimension) {
        timeLabelCenterY = [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:self.subModel.subTitleSpace];
    }
    [NSLayoutConstraint activateConstraints:@[titleLabelCenterX,titleLabelCenterY,timeLabelCenterX, timeLabelCenterY]];
    
}
- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    CGXCategoryTitleSubtitleCellModel *myCellModel = (CGXCategoryTitleSubtitleCellModel *)cellModel;
    
    self.subModel = myCellModel;
    
    self.subTitleLabel.text = myCellModel.subTitle;
    if (myCellModel.isSelected) {
        self.subTitleLabel.textColor = myCellModel.subTitleSelectedColor;
        self.subTitleLabel.font = myCellModel.subTitleSelectedFont;
    }else {
        self.subTitleLabel.textColor = myCellModel.subTitleNormalColor;
        self.subTitleLabel.font = myCellModel.subTitleFont;
    }
    self.subTitleLabel.hidden = myCellModel.isHiddenSubTitle;
    [self setNeedsLayout];
}

@end
