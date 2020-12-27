//
//  CGXCategoryIndicatorRainbowLineView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorLineView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 会无视CGXCategoryIndicatorLineView的indicatorLineViewColor属性，以indicatorColors为准
 */
@interface CGXCategoryIndicatorRainbowLineView : CGXCategoryIndicatorLineView

//数量需要与cell的数量相等。没有提供默认值，必须要赋值该属性。categoryView在reloadData的时候，也要一并更新该属性，不然会出现数组越界。
@property (nonatomic, strong) NSArray <UIColor *> *indicatorColors;

@end

NS_ASSUME_NONNULL_END
