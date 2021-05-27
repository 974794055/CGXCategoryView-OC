//
//  CGXCategoryTitleAttributeCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorCellModel.h"

@interface CGXCategoryTitleAttributeCellModel : CGXCategoryIndicatorCellModel

@property (nonatomic, copy) NSAttributedString *attributeTitle;
@property (nonatomic, copy) NSAttributedString *attributeSelectTitle;

@property (nonatomic, strong) UIColor *titleCurrentColor;
@property (nonatomic, assign) BOOL titleColorGradientEnabled;   //默认：NO，title的颜色是否渐变过渡
@end
