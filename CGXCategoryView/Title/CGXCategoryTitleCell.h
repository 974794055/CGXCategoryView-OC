//
//  CGXCategoryTitleCell.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorCell.h"
#import "CGXCategoryViewDefines.h"
@class CGXCategoryTitleCellModel;

@interface CGXCategoryTitleCell : CGXCategoryIndicatorCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *maskTitleLabel;

@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterX;
@property (nonatomic, strong) NSLayoutConstraint *titleLabelCenterY;
@property (nonatomic, strong) NSLayoutConstraint *maskTitleLabelCenterX;
@property (nonatomic, strong) NSLayoutConstraint *maskTitleLabelCenterY;


- (CGXCategoryCellSelectedAnimationBlock)preferredTitleZoomAnimationBlock:(CGXCategoryTitleCellModel *)cellModel baseScale:(CGFloat)baseScale;

- (CGXCategoryCellSelectedAnimationBlock)preferredTitleStrokeWidthAnimationBlock:(CGXCategoryTitleCellModel *)cellModel attributedString:(NSMutableAttributedString *)attributedString;

- (CGXCategoryCellSelectedAnimationBlock)preferredTitleColorAnimationBlock:(CGXCategoryTitleCellModel *)cellModel;

@end
