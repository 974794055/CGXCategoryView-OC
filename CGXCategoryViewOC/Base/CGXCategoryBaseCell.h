//
//  CGXCategoryBaseCell.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryBaseCellModel.h"
#import "CGXCategoryViewAnimator.h"
#import "CGXCategoryViewDefines.h"

@interface CGXCategoryBaseCell : UICollectionViewCell

@property (nonatomic, strong, readonly) CGXCategoryBaseCellModel *cellModel;
@property (nonatomic, strong, readonly) CGXCategoryViewAnimator *animator;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadData:(CGXCategoryBaseCellModel *)cellModel NS_REQUIRES_SUPER;

- (BOOL)checkCanStartSelectedAnimation:(CGXCategoryBaseCellModel *)cellModel;

- (void)addSelectedAnimationBlock:(CGXCategoryCellSelectedAnimationBlock)block;

- (void)startSelectedAnimationIfNeeded:(CGXCategoryBaseCellModel *)cellModel;
@end
