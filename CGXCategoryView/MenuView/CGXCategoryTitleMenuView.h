//
//  CGXCategoryTitleMenuView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXCategoryTitleImageView.h"
#import "CGXCategoryTitleMenuVCDelegate.h"
#import "CGXCategoryIndicatorLineView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXCategoryTitleMenuView : UIView

// 默认只有文字 要是有其他属性  可设置
@property (nonatomic , strong) CGXCategoryTitleImageView *categoryView;

// 外界绑定滚回的视图  设置属性用
@property (nonatomic , strong) UIScrollView *scrollView;

//当前选中下表 默认0
@property (nonatomic , assign,readonly) NSInteger currentInteger;
// 嵌套在view时使用
@property(nonatomic,weak) id <CGXCategoryTitleMenuVCDelegate>delegate;

// 标签的高度 默认View高度
@property (nonatomic , assign) CGFloat categoryViewHeight;

// 上划线  默认隐藏
@property (nonatomic , strong) UIView *topLineView;
@property (nonatomic , assign) CGFloat topLineHeight;//上划线高度
@property (nonatomic , strong) UIColor *topLineColor;//上划线颜色
@property (nonatomic , assign) CGFloat topLineSpace;//上划线左右距离
// 下划线  默认不隐藏
@property (nonatomic , strong) UIView *bottomLineView;
@property (nonatomic , assign) CGFloat bottomLineHeight;//下划线高度
@property (nonatomic , strong) UIColor *bottomLineColor;//下划线颜色
@property (nonatomic , assign) CGFloat bottomLineSpace;//下划线左右距离

/**
 滚动切换的时候，滚动距离超过一页的多少百分比，就认为切换了页面。默认0.5（即滚动超过了半屏，就认为翻页了）。范围0~1，开区间不包括0和1
 */
@property (nonatomic, assign) CGFloat didAppearPercent;

// 只有文字
- (void)updateWithTitleArray:(NSMutableArray<NSString *> *)titleArray VCArray:(NSMutableArray<UIViewController *> *)vcArray;

//当前选中下表 默认0
- (void)selectItemAtIndex:(NSInteger)index;
//指示器在顶部 底部
- (void)position_TopFor_Bottom;
@end

NS_ASSUME_NONNULL_END
