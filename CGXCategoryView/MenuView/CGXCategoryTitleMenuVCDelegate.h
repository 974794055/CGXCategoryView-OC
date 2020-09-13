//
//  CGXCategoryTitleMenuDeleGate.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGXCategoryTitleMenuView;

NS_ASSUME_NONNULL_BEGIN

@protocol CGXCategoryTitleMenuVCDelegate <NSObject>

@required

@optional


/**  初始化veiw
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView InitializeViewItemAtIndex:(NSInteger)index;


/**  第一次加载
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView FirstLoadingSelectedItemAtIndex:(NSInteger)index;

//为什么会把选中代理分为三个，因为有时候只关心点击选中的，有时候只关心滚动选中的，有时候只关心选中。所以具体情况，使用对应方法。
/**
 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

/**
 点击选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

/**
 滚动选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;


/**
 只有点击的选中才会调用！！！
 因为用户点击，contentScrollView即将过渡到目标index的位置。内部默认实现`[self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];`。如果实现该代理方法，以自定义实现为准。比如将animated设置为NO，点击切换时无需滚动效果。类似于今日头条APP。
 
 @param categoryView categoryView description
 @param index index description
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index;


/**
 正在滚动中的回调   此处用于处理滑动时 导航条等变化的状况
 
 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 从左往右计算的百分比
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;


/**
 可选实现，列表显示的时候调用
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView ListDidDisappear:(NSInteger)index;
/**
 可选实现，列表消失的时候调用
  */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView ListDidAppearIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
