//
//  CGXCategoryTitleMenuView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleMenuView.h"

///DEBUG打印日志
#ifdef DEBUG
# define CGXMenuViewDebugLog(FORMAT, ...) printf("[%s 行号:%d]:\n%s\n",__FUNCTION__,__LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
# define CGXMenuViewDebugLog(FORMAT, ...)
#endif


typedef NS_ENUM(NSUInteger, CGXCategoryTitleMenuViewClickType) {
    CGXCategoryTitleMenuViewClickTypeSelected,//点击选中或者滚动选中
    CGXCategoryTitleMenuViewClickTypeClickSelected,//点击选中的情况才会调用该方法
    CGXCategoryTitleMenuViewClickTypeScroll,//滚动选中的情况才会调用该方法
    CGXCategoryTitleMenuViewClickTypeContentScroll //只有点击的选中才会调用
};


@interface CGXCategoryTitleMenuView ()<CGXCategoryViewDelegate>

@property (nonatomic , strong)  NSMutableArray *listVCArray;

@property (nonatomic , strong)  NSMutableArray *titleArray;

//当前选中下表 默认0
@property (nonatomic , assign,readwrite) NSInteger currentInteger;

@end

@implementation CGXCategoryTitleMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializeWiew];
    }
    return self;
}

- (void)initializeWiew
{
    self.currentInteger = 0;
    _categoryViewHeight = 50;
    self.didAppearPercent = 0.5;
    self.listVCArray = [NSMutableArray array];
    self.titleArray = [NSMutableArray array];
    
    self.categoryView = [[CGXCategoryTitleImageView alloc] init];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    [self addSubview:self.categoryView];
    self.categoryView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.categoryViewHeight);
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    self.scrollView.frame =CGRectMake(0, self.categoryViewHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.categoryViewHeight);
    self.categoryView.contentScrollView = self.scrollView;
    
    self.topLineView = [[UIView alloc] init];
    self.topLineView.backgroundColor = self.topLineColor;
    [self addSubview:self.topLineView];
    [self bringSubviewToFront:self.topLineView];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = self.bottomLineColor;
    [self addSubview:self.bottomLineView];
    [self bringSubviewToFront:self.bottomLineView];
    
    self.topLineView.hidden = YES;
    self.bottomLineView.hidden = NO;
    
}
- (void)setCategoryViewHeight:(CGFloat)categoryViewHeight
{
    _categoryViewHeight = categoryViewHeight;
    self.categoryView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.categoryViewHeight);
    self.scrollView.frame =CGRectMake(0, self.categoryViewHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.categoryViewHeight);
}
- (CGFloat)topLineSpace
{
    if (!_topLineSpace) {
        _topLineSpace = 0;
    }
    return _topLineSpace;
}
- (UIColor *)topLineColor
{
    if (!_topLineColor) {
        _topLineColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    }
    return _topLineColor;
}
- (CGFloat)topLineHeight
{
    if (!_topLineHeight) {
        _topLineHeight = 1;
    }
    return _topLineHeight;
}
- (CGFloat)bottomLineSpace
{
    if (!_bottomLineSpace) {
        _bottomLineSpace = 0;
    }
    return _bottomLineSpace;
}
- (UIColor *)bottomLineColor
{
    if (!_bottomLineColor) {
        _bottomLineColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    }
    return _bottomLineColor;
}
- (CGFloat)bottomLineHeight
{
    if (!_bottomLineHeight) {
        _bottomLineHeight = 1;
    }
    return _bottomLineHeight;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.listVCArray.count==0) {
        self.categoryView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        
        self.categoryViewHeight = CGRectGetHeight(self.bounds);
        
        self.scrollView.hidden = YES;
        self.topLineView.frame =CGRectMake(self.topLineSpace, 0, CGRectGetWidth(self.frame)-self.topLineSpace * 2, self.topLineHeight);
        self.bottomLineView.frame = CGRectMake(self.bottomLineSpace, self.categoryViewHeight-self.bottomLineHeight, CGRectGetWidth(self.frame)-self.bottomLineSpace * 2, self.bottomLineHeight);
    } else{
        self.categoryView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.categoryViewHeight);
        self.scrollView.frame = CGRectMake(0, self.categoryViewHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.categoryViewHeight);
        self.topLineView.frame =CGRectMake(self.topLineSpace, 0, CGRectGetWidth(self.bounds)-self.topLineSpace * 2, self.topLineHeight);
        self.bottomLineView.frame = CGRectMake(self.bottomLineSpace, self.categoryViewHeight-self.bottomLineHeight, CGRectGetWidth(self.bounds)-self.bottomLineSpace * 2, self.bottomLineHeight);
    }
}
- (void)position_TopFor_Bottom
{
    CGXCategoryIndicatorView *componentView = (CGXCategoryIndicatorView *)self.categoryView;
    for (CGXCategoryIndicatorComponentView *view in componentView.indicators) {
        if (view.componentPosition == CGXCategoryComponentPosition_Top) {
            view.componentPosition = CGXCategoryComponentPosition_Bottom;
        }else {
            view.componentPosition = CGXCategoryComponentPosition_Top;
        }
    }
    [componentView reloadData];
}

- (void)updateWithTitleArray:(NSMutableArray<NSString *> *)titleArray VCArray:(NSMutableArray<UIViewController *> *)vcArray
{
    //先把之前的listView移除掉
    for (UIViewController *vc in self.listVCArray) {
        [vc.view removeFromSuperview];
    }
    [self.listVCArray removeAllObjects];
    //外部更新标签的时候，先要移除之前添加的控制器和视图
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [[self viewController:self].childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromParentViewController];
    }];
    
    [self.titleArray removeAllObjects];
    for (NSString *title in titleArray) {
        [self.titleArray addObject:title];
    }

    self.categoryView.titleArray = self.titleArray;
    
    for (int i = 0; i < vcArray.count; i ++) {
        UIViewController *listVC = vcArray[i];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
        [[self viewController:self] addChildViewController:listVC];
        [self.scrollView addSubview:listVC.view];

        if (self.currentInteger == i) {
            if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:FirstLoadingSelectedItemAtIndex:)]) {
                [self.delegate categoryMenuView:self FirstLoadingSelectedItemAtIndex:i];
            }
            BOOL isHave = [listVC respondsToSelector:@selector(categoryMenuView:FirstLoadingSelectedItemAtIndex:)];
            if (isHave == YES && [listVC conformsToProtocol:@protocol(CGXCategoryTitleMenuVCDelegate)]) {
                [(UIViewController<CGXCategoryTitleMenuVCDelegate> *)listVC categoryMenuView:self FirstLoadingSelectedItemAtIndex:i];
            }
        }
        
        if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:InitializeViewItemAtIndex:)]) {
            [self.delegate categoryMenuView:self InitializeViewItemAtIndex:i];
        }
        BOOL isHave = [listVC respondsToSelector:@selector(categoryMenuView:InitializeViewItemAtIndex:)];
        if (isHave == YES && [listVC conformsToProtocol:@protocol(CGXCategoryTitleMenuVCDelegate)]) {
            [(UIViewController<CGXCategoryTitleMenuVCDelegate> *)listVC categoryMenuView:self InitializeViewItemAtIndex:i];
        }
        
        [self.listVCArray addObject:listVC];
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds)*titleArray.count, CGRectGetHeight(self.scrollView.bounds));
    
    [self.categoryView reloadData];
    [self selectItemAtIndex:self.currentInteger];
}
//当前选中下表 默认0
- (void)selectItemAtIndex:(NSInteger)index
{
    self.currentInteger = index;
    [self.categoryView selectItemAtIndex:self.currentInteger];
}
//为什么会把选中代理分为三个，因为有时候只关心点击选中的，有时候只关心滚动选中的，有时候只关心选中。所以具体情况，使用对应方法。
/**
 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
        CGXMenuViewDebugLog(@"CGXCategoryTitleMenuView 点击选中或者滚动选中--%ld" , (long)index);
    [self categoryViewChooseItemAtIndex:index Type:CGXCategoryTitleMenuViewClickTypeSelected];
}
/**
 点击选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;
{
        CGXMenuViewDebugLog(@"CGXCategoryTitleMenuView 点击选中--%ld" , (long)index);
    [self categoryViewChooseItemAtIndex:index Type:CGXCategoryTitleMenuViewClickTypeClickSelected];
}
/**
 滚动选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
        CGXMenuViewDebugLog(@"CGXCategoryTitleMenuView 滚动选中--%ld" , (long)index);
    [self categoryViewChooseItemAtIndex:index Type:CGXCategoryTitleMenuViewClickTypeScroll];
}
/**
 只有点击的选中才会调用！！！
 因为用户点击，contentScrollView即将过渡到目标index的位置。内部默认实现`[self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];`。如果实现该代理方法，以自定义实现为准。比如将animated设置为NO，点击切换时无需滚动效果。类似于今日头条APP。
 
 @param categoryView categoryView description
 @param index index description
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index
{
        CGXMenuViewDebugLog(@"CGXCategoryTitleMenuView 只有点击的选中--%ld" , (long)index);
    [self categoryViewChooseItemAtIndex:index Type:CGXCategoryTitleMenuViewClickTypeContentScroll];
}
/**
 正在滚动中的回调
 
 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 从左往右计算的百分比
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio
{
    NSInteger targetIndex = -1;
    NSInteger disappearIndex = -1;
    if (rightIndex == self.currentInteger) {
        //当前选中的在右边，用户正在从右边往左边滑动
        if (ratio < (1 - self.didAppearPercent)) {
            targetIndex = leftIndex;
            disappearIndex = rightIndex;
        }else {
            targetIndex = rightIndex;
            disappearIndex = leftIndex;
        }
    }else {
        //当前选中的在左边，用户正在从左边往右边滑动
        if (ratio > self.didAppearPercent) {
            targetIndex = rightIndex;
            disappearIndex = leftIndex;
        }else {
            targetIndex = leftIndex;
            disappearIndex = rightIndex;
        }
    }
    
    if (targetIndex != -1 && self.currentInteger != targetIndex) {
        [self viewWillListDidDisappear:targetIndex DisappearIndex:disappearIndex];
    }
    
    if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:scrollingFromLeftIndex:toRightIndex:ratio:)]) {
        [self.delegate categoryMenuView:self scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio];
    }
}
// 将要消失 出现
- (void)viewWillListDidDisappear:(NSInteger)didDisappear DisappearIndex:(NSInteger)disappear
{
    [self viewController:self].navigationController.interactivePopGestureRecognizer.enabled = (didDisappear == 0);
    self.currentInteger = didDisappear;
    
    
    if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:ListDidDisappear:)]) {
        [self.delegate categoryMenuView:self ListDidDisappear:disappear];
    }
    if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:ListDidAppearIndex:)]) {
        [self.delegate categoryMenuView:self ListDidAppearIndex:didDisappear];
    }
    
    UIViewController *listVC1 = self.listVCArray[disappear];
    BOOL isHave1 = [listVC1 respondsToSelector:@selector(categoryMenuView:ListDidDisappear:)];
    if (isHave1 == YES && [listVC1 conformsToProtocol:@protocol(CGXCategoryTitleMenuVCDelegate)]) {
        [(UIViewController<CGXCategoryTitleMenuVCDelegate> *)listVC1 categoryMenuView:self ListDidDisappear :disappear];
    }
    UIViewController *listVC2 = self.listVCArray[didDisappear];
    BOOL isHave2 = [listVC2 respondsToSelector:@selector(categoryMenuView:ListDidAppearIndex:)];
    if (isHave2 == YES && [listVC2 conformsToProtocol:@protocol(CGXCategoryTitleMenuVCDelegate)]) {
        [(UIViewController<CGXCategoryTitleMenuVCDelegate> *)listVC2 categoryMenuView:self ListDidAppearIndex:didDisappear];
    }
    
}


- (void)categoryViewChooseItemAtIndex:(NSInteger)index Type:(CGXCategoryTitleMenuViewClickType)type
{
    if (self.currentInteger != index) {
        [self viewWillListDidDisappear:index DisappearIndex:self.currentInteger];
    }
    
    //侧滑手势处理
    [self viewController:self].navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    self.currentInteger = index;
    
    switch (type) {
        case CGXCategoryTitleMenuViewClickTypeSelected:
        {
            
            if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:didSelectedItemAtIndex:)]) {
                [self.delegate categoryMenuView:self didSelectedItemAtIndex:index];
            }
            
            UIViewController *listVC = self.listVCArray[index];
            BOOL isHave = [listVC respondsToSelector:@selector(categoryMenuView:didSelectedItemAtIndex:)];
            if (isHave == YES && [listVC conformsToProtocol:@protocol(CGXCategoryTitleMenuVCDelegate)]) {
                [(UIViewController<CGXCategoryTitleMenuVCDelegate> *)listVC categoryMenuView:self didSelectedItemAtIndex:index];
            }
            
        }
            break;
        case CGXCategoryTitleMenuViewClickTypeClickSelected:
        {
            
            if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:didClickSelectedItemAtIndex:)]) {
                [self.delegate categoryMenuView:self didClickSelectedItemAtIndex:index];
            }
            
            UIViewController *listVC = self.listVCArray[index];
            BOOL isHave = [listVC respondsToSelector:@selector(categoryMenuView:didClickSelectedItemAtIndex:)];
            if (isHave == YES && [listVC conformsToProtocol:@protocol(CGXCategoryTitleMenuVCDelegate)]) {
                [(UIViewController<CGXCategoryTitleMenuVCDelegate> *)listVC categoryMenuView:self didClickSelectedItemAtIndex:index];
            }
        }
            break;
        case CGXCategoryTitleMenuViewClickTypeScroll:
        {
            
            if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:didScrollSelectedItemAtIndex:)]) {
                [self.delegate categoryMenuView:self didScrollSelectedItemAtIndex:index];
            }
            
            UIViewController *listVC = self.listVCArray[index];
            BOOL isHave = [listVC respondsToSelector:@selector(categoryMenuView:didScrollSelectedItemAtIndex:)];
            if (isHave ==YES && [listVC conformsToProtocol:@protocol(CGXCategoryTitleMenuVCDelegate)]) {
                [(UIViewController<CGXCategoryTitleMenuVCDelegate> *)listVC categoryMenuView:self didScrollSelectedItemAtIndex:index];
            }
            
        }
            break;
        case CGXCategoryTitleMenuViewClickTypeContentScroll:
        {
            
            if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:didClickedItemContentScrollViewTransitionToIndex:)]) {
                [self.delegate categoryMenuView:self didClickedItemContentScrollViewTransitionToIndex:index];
            }
            
            UIViewController *listVC = self.listVCArray[index];
            BOOL isHave = [listVC respondsToSelector:@selector(categoryMenuView:didClickedItemContentScrollViewTransitionToIndex:)];
            if (isHave == YES && [listVC conformsToProtocol:@protocol(CGXCategoryTitleMenuVCDelegate)]) {
                [(UIViewController<CGXCategoryTitleMenuVCDelegate> *)listVC categoryMenuView:self didClickedItemContentScrollViewTransitionToIndex:index];
            }
        }
            break;
            
        default:
            break;
    }
}

- (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
