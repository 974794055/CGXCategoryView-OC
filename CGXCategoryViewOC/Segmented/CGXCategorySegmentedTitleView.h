//
//  CGXCategorySegmentedTitleView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CGXCategorySegmentedTitleViewSelectBlock)(NSMutableArray<NSString *> *titleArr,NSInteger inter);
@interface CGXCategorySegmentedTitleView : UIView

@property (nonatomic , copy) CGXCategorySegmentedTitleViewSelectBlock selectBlock;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic , strong,readonly) NSMutableArray<NSString *> *titleArr;

@property (nonatomic , strong) UIColor *tintColor;

// 默认0
@property (nonatomic , assign) NSInteger selectedIndex;

@property (nonatomic , strong) UIColor *titleNormalColor;
@property (nonatomic , strong) UIColor *titleSelectColor;
@property (nonatomic , strong) UIFont *titleNormalFont;
@property (nonatomic , strong) UIFont *titleSelectFont;
@property (nonatomic , strong) UIImage *backImage;//背景图
@property (nonatomic , strong) UIImage*dividerImage;//分割线

// 初始化数据
- (void)updateWithTitleArray:(NSMutableArray<NSString *> *)titleArr;

//选中一个分段 默认0
- (void)selectSegmentAtIndex:(NSInteger)inder;

//移除一个分段(根据下标)
- (void)removeSegmentAtIndex:(NSInteger)inder;
//根据下标修改分段标题
- (void)editSegmentAtIndex:(NSInteger)inder Title:(NSString *)title;
//插入文字
- (void)insertSegmentAtIndex:(NSInteger)inder Title:(NSString *)title;

// 设置指定索引选项的宽度
- (void)editWidthSegmentAtIndex:(NSInteger)inder Width:(CGFloat)width;
//设置segment是否可用
- (void)setEnabledSegmentAtIndex:(NSInteger)inder;
//移出所有segment
- (void)removeAllSegments;
@end

NS_ASSUME_NONNULL_END
