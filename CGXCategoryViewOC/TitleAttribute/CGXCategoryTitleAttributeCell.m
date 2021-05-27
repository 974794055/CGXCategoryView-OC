//
//  CGXCategoryTitleAttributeCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleAttributeCell.h"
#import "CGXCategoryTitleAttributeCellModel.h"

@interface CGXCategoryTitleAttributeCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterX;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterY;
@end
@implementation CGXCategoryTitleAttributeCell

- (void)initializeViews {
    [super initializeViews];
    
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.numberOfLines = 0;
    
    self.titleLabelCenterX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    self.titleLabelCenterY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [NSLayoutConstraint activateConstraints:@[self.titleLabelCenterX, self.titleLabelCenterY]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}
- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    
    CGXCategoryTitleAttributeCellModel *myCellModel = (CGXCategoryTitleAttributeCellModel *)cellModel;
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] init];
    if (cellModel.isSelected) {
        [attributeStr appendAttributedString:myCellModel.attributeSelectTitle];
    } else{
        [attributeStr appendAttributedString:myCellModel.attributeTitle];
    }
    if (myCellModel.titleColorGradientEnabled) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:myCellModel.titleCurrentColor
                             range:NSMakeRange(0,attributeStr.length)];//设置颜色

    }
    
    self.titleLabel.attributedText = attributeStr;
    [self.titleLabel sizeToFit];
}



@end
