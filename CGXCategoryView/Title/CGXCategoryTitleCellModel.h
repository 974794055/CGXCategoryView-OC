//
//  CGXCategoryTitleCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorCellModel.h"
#import <UIKit/UIKit.h>
#import "CGXCategoryTitleBadgeModel.h"

@interface CGXCategoryTitleCellModel : CGXCategoryIndicatorCellModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger titleNumberOfLines;

@property (nonatomic, strong) UIColor *titleNormalColor;

@property (nonatomic, strong) UIColor *titleCurrentColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIFont *titleSelectedFont;

@property (nonatomic, assign) BOOL titleLabelMaskEnabled;

@property (nonatomic, assign) BOOL titleLabelZoomEnabled;

@property (nonatomic, assign) CGFloat titleLabelNormalZoomScale;

@property (nonatomic, assign) CGFloat titleLabelCurrentZoomScale;

@property (nonatomic, assign) CGFloat titleLabelSelectedZoomScale;

@property (nonatomic, assign) BOOL titleLabelStrokeWidthEnabled;

@property (nonatomic, assign) CGFloat titleLabelNormalStrokeWidth;

@property (nonatomic, assign) CGFloat titleLabelCurrentStrokeWidth;

@property (nonatomic, assign) CGFloat titleLabelSelectedStrokeWidth;


@property (nonatomic, assign) CGFloat titleLabelVerticalOffset;

@property (nonatomic, assign) CGXCategoryTitleLabelAnchorPointStyle titleLabelAnchorPointStyle;


@end
