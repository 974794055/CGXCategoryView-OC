//
//  CGXCategoryBaseCellModel.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CGXCategoryViewDefines.h"

@interface CGXCategoryBaseCellModel : NSObject

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, assign) CGFloat cellSpacing;

@property (nonatomic, assign, getter=isCellWidthZoomEnabled) BOOL cellWidthZoomEnabled;

@property (nonatomic, assign) CGFloat cellWidthNormalZoomScale;

@property (nonatomic, assign) CGFloat cellWidthCurrentZoomScale;

@property (nonatomic, assign) CGFloat cellWidthSelectedZoomScale;

@property (nonatomic, assign, getter=isSelectedAnimationEnabled) BOOL selectedAnimationEnabled;

@property (nonatomic, assign) NSTimeInterval selectedAnimationDuration;

@property (nonatomic, assign) CGXCategoryCellSelectedType selectedType;

@property (nonatomic, assign, getter=isTransitionAnimating) BOOL transitionAnimating;

@end
