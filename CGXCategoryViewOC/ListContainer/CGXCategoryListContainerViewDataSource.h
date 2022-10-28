//
//  CGXCategoryListContainerViewDelegate.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@protocol CGXCategoryListContainerViewDataSource <NSObject>

/**
 返回list的数量
 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(CGXCategoryListContainerView *)listContainerView;

/**
 根据index返回一个对应列表实例，需要是遵从`CGXCategoryListContentViewDelegate`协议的对象。
 你可以代理方法调用的时候初始化对应列表，达到懒加载的效果。这也是默认推荐的初始化列表方法。你也可以提前创建好列表，等该代理方法回调的时候再返回也可以，达到预加载的效果。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`CGXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`CGXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。
 
 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从CGXCategoryListContentViewDelegate协议的list实例
 */
- (id<CGXCategoryListContainerViewDelegate>)listContainerView:(CGXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index;

@optional
/**
 返回自定义UIScrollView或UICollectionView的Class
 某些特殊情况需要自己处理UIScrollView内部逻辑。比如项目用了FDFullscreenPopGesture，需要处理手势相关代理。
 
 @param listContainerView CGXCategoryListContainerView
 @return 自定义UIScrollView实例
 */
- (Class)scrollViewClassInlistContainerView:(CGXCategoryListContainerView *)listContainerView;

/**
 控制能否初始化对应index的列表。有些业务需求，需要在某些情况才允许初始化某些列表，通过通过该代理实现控制。
 */
- (BOOL)listContainerView:(CGXCategoryListContainerView *)listContainerView canInitListAtIndex:(NSInteger)index;


/**
 返回自定义UIScrollView或UICollectionView的滚动当前的下标
 @param listContainerView AppListContainerView
 @param index  滚动到的下标
 */
- (void)listContainerView:(CGXCategoryListContainerView *)listContainerView ScrollAtIndex:(NSInteger)index;

- (void)listContainerView:(CGXCategoryListContainerView *)listContainerView DidScroll:(UIScrollView *)scrollView;
- (void)listContainerView:(CGXCategoryListContainerView *)listContainerView WillBeginDragging:(UIScrollView *)scrollView;
- (void)listContainerView:(CGXCategoryListContainerView *)listContainerView DidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)listContainerView:(CGXCategoryListContainerView *)listContainerView WillBeginDecelerating:(UIScrollView *)scrollView;
- (void)listContainerView:(CGXCategoryListContainerView *)listContainerView DidEndDecelerating:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
