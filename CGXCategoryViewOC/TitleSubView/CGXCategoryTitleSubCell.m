//
//  CGXCategoryTitleSubCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleSubCell.h"

@interface CGXCategoryTitleSubCell ()

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) NSLayoutConstraint *timeLabelCenterW;
@property (nonatomic, strong) NSLayoutConstraint *timeLabelCenterH;
@property (nonatomic, strong) NSLayoutConstraint *timeLabelCenterX;
@property (nonatomic, strong) NSLayoutConstraint *timeLabelCenterY;


@end

@implementation CGXCategoryTitleSubCell

- (void)initializeViews
{
    [super initializeViews];
    
    self.subTitleLabel = [[UILabel alloc] init];
    self.subTitleLabel.layer.masksToBounds = YES;
    self.subTitleLabel.clipsToBounds = YES;
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.subTitleLabel];
   
    self.timeLabelCenterX = [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    self.timeLabelCenterY = [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    
    [NSLayoutConstraint activateConstraints:@[self.timeLabelCenterX,self.timeLabelCenterY]];
    
    self.timeLabelCenterW = [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:0];
    [self.subTitleLabel addConstraint:self.timeLabelCenterW];
    self.timeLabelCenterH = [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:0];
    [self.subTitleLabel addConstraint:self.timeLabelCenterH];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}
- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    CGXCategoryTitleSubCellModel *myCellModel = (CGXCategoryTitleSubCellModel *)cellModel;
    
    self.subTitleLabel.text = myCellModel.subTitle;
    if (myCellModel.isSelected) {
        self.subTitleLabel.textColor = myCellModel.subTitleSelectedColor;
        self.subTitleLabel.font = myCellModel.subTitleSelectedFont;
        self.subTitleLabel.backgroundColor = myCellModel.subTitleSBgColor;
    }else {
        self.subTitleLabel.textColor = myCellModel.subTitleNormalColor;
        self.subTitleLabel.font = myCellModel.subTitleFont;
        self.subTitleLabel.backgroundColor = myCellModel.subTitleNBgColor;;
    }
    CGSize subSize = [myCellModel.subTitle boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.contentView.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.subTitleLabel.font} context:nil].size;

    CGFloat cornerRadius = 0;
  
    if (myCellModel.subTitleRadius == CGXCategoryViewAutomaticDimension) {
        cornerRadius = (subSize.height+2)/2.0;
    } else{
        cornerRadius = myCellModel.subTitleRadius;
    }
    self.subTitleLabel.layer.cornerRadius = cornerRadius;
    self.timeLabelCenterW.constant = subSize.width+cornerRadius+myCellModel.subTitleMargin;
    CGFloat subHeight = subSize.height+1;
    self.timeLabelCenterH.constant = subSize.height+1;
    if (myCellModel.positionStyle == CGXCategorySubTitlePositionStyle_Bottom) {
        self.timeLabelCenterY.constant = (CGRectGetHeight(self.contentView.frame)/2.0-subHeight/2.0-myCellModel.subTitleSpace);
        
        self.timeLabelCenterY.constant = CGRectGetHeight(self.contentView.frame)/2.0-myCellModel.subTitleSpace;
    } else{
        self.timeLabelCenterY.constant = -(CGRectGetHeight(self.contentView.frame)/2.0-myCellModel.subTitleSpace);
    }
    self.subTitleLabel.alpha = myCellModel.subAlpha;
}

@end
