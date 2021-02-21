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

@property (nonatomic, strong) NSLayoutConstraint *timeLabelCenterW;
@property (nonatomic, strong) NSLayoutConstraint *timeLabelCenterH;
@property (nonatomic, strong) NSLayoutConstraint *timeLabelCenterX;
@property (nonatomic, strong) NSLayoutConstraint *timeLabelCenterY;


@end

@implementation CGXCategoryTitleSubtitleCell

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
    
    self.timeLabelCenterY = [NSLayoutConstraint constraintWithItem:self.subTitleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[self.timeLabelCenterX, self.timeLabelCenterY]];
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
    
    CGXCategoryTitleSubtitleCellModel *myCellModel = (CGXCategoryTitleSubtitleCellModel *)cellModel;
    
    self.subModel = myCellModel;
    
    self.titleLabelCenterX.constant = 0;
    self.titleLabelCenterY.constant = 0;
    
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
    self.subTitleLabel.hidden = myCellModel.isHiddenSubTitle;
    
    self.subTitleLabel.backgroundColor = myCellModel.issubTitleBg ? self.subTitleLabel.backgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0];

    CGSize subSize = [myCellModel.subTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.subTitleLabel.font} context:nil].size;
    
    self.timeLabelCenterW.constant = subSize.width+subSize.height+myCellModel.subTitleMargin;
    self.timeLabelCenterH.constant = subSize.height+2;
    
    if (self.subModel.subTitleRadius == CGXCategoryViewAutomaticDimension) {
        self.subTitleLabel.layer.cornerRadius = (subSize.height+2)/2.0;
    } else{
        self.subTitleLabel.layer.cornerRadius = self.subModel.subTitleRadius;
    }

    self.timeLabelCenterX.constant = 0;
    self.timeLabelCenterY.constant = 0;
    
    if (self.subModel.titleSpace != CGXCategoryViewAutomaticDimension) {
        self.titleLabelCenterY.constant = self.subModel.titleSpace;
    }
    if (self.subModel.subTitleSpace != CGXCategoryViewAutomaticDimension) {
        self.timeLabelCenterY.constant = self.subModel.subTitleSpace;
    }

}

@end
