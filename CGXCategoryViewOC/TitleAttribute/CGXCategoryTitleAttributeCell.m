//
//  CGXCategoryTitleAttributeCell.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleAttributeCell.h"
#import "CGXCategoryTitleAttributeCellModel.h"

@implementation CGXCategoryTitleAttributeCell

- (void)initializeViews {
    [super initializeViews];

    self.titleLabel.numberOfLines = 2;
    self.maskTitleLabel.numberOfLines = 2;
}

- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    CGXCategoryTitleAttributeCellModel *myCellModel = (CGXCategoryTitleAttributeCellModel *)cellModel;

    if (cellModel.isSelected) {
        self.maskTitleLabel.attributedText = myCellModel.attributeSelectTitle;
        [self.maskTitleLabel sizeToFit];
        self.titleLabel.attributedText = myCellModel.attributeSelectTitle;
        [self.titleLabel sizeToFit];
    } else{
        self.maskTitleLabel.attributedText = myCellModel.attributeTitle;
        [self.maskTitleLabel sizeToFit];
        self.titleLabel.attributedText = myCellModel.attributeTitle;
        [self.titleLabel sizeToFit];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}



@end
