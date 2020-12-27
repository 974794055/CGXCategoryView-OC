//
//  CGXCategoryIndicatorImageView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorComponentView.h"

@interface CGXCategoryIndicatorImageView : CGXCategoryIndicatorComponentView
//显示指示器图片的UIImageView
@property (nonatomic, strong, readonly) UIImageView *indicatorImageView;
//图片是否开启滚动。默认NO
@property (nonatomic, assign) BOOL indicatorImageViewRollEnabled;
//图片的尺寸。默认：CGSizeMake(30, 20)
@property (nonatomic, assign) CGSize indicatorImageViewSize;

@end
