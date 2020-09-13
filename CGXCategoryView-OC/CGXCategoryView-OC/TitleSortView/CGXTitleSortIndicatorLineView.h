//
//  CGXTitleSortIndicatorLineView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryIndicatorLineView.h"
typedef NS_ENUM(NSUInteger, CGXCategoryIndicatorAlignmentStyle) {
    CGXCategoryIndicatorAlignmentStyleNode,
    CGXCategoryIndicatorAlignmentStyleLeading,
    CGXCategoryIndicatorAlignmentStyleTrailing,
};
NS_ASSUME_NONNULL_BEGIN

@interface CGXTitleSortIndicatorLineView : CGXCategoryIndicatorLineView
@property (nonatomic, assign) CGXCategoryIndicatorAlignmentStyle alignmentStyle;
@end

NS_ASSUME_NONNULL_END
