//
//  CGXCategoryBadgeView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2020/05/20.
//

#import "CGXCategoryTitleImageView.h"
#import "CGXCategoryBadgeCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryBadgeView : CGXCategoryTitleImageView
/**
 更新某个文字
 */
- (void)updateWithTitle:(NSString *)title AtInter:(NSInteger)inter;
/**
 更新角标
 */
- (void)updateWithBadgeInter:(NSInteger)badgeInter AtInter:(NSInteger)inter NS_REQUIRES_SUPER;
/**
 更新角标 自定义
 */
- (void)updateWithBadge:(CGXCategoryTitleBadgeModel *)badgeModel AtInter:(NSInteger)inter NS_REQUIRES_SUPER;
@end

NS_ASSUME_NONNULL_END
