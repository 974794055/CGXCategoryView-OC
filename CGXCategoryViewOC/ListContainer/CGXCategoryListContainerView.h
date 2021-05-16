//
//  CGXCategoryListScrollView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGXCategoryListContainerViewDelegate.h"
#import "CGXCategoryListContainerViewDataSource.h"
#import "CGXCategoryListContainerViewScrollDelegate.h"

@class CGXCategoryListContainerView;

/**
 列表容器视图的类型

ScrollView:
     UIScrollView。
     优势：没有其他副作用。
     劣势：视图内存占用相对大一点。
CollectionView:
     UICollectionView。
     优势：因为列表被添加到cell上，视图的内存占用更少，适合内存要求特别高的场景。
     劣势：因为cell重用机制的问题，导致列表下拉刷新视图，会因为被removeFromSuperview而被隐藏。
     需要在`- (void)listDidAppear   或者- (void)viewDidAppear:(BOOL)animated`类做特殊处理。
 
 例如：内部通过`UICollectionView`的cell加载列表。当切换的时候，之前的列表所在的cell就被回收到缓存池，就会从视图层级树里面被剔除掉，即没有显示出来且不在视图层级里面。这个时候MJRefreshHeader所持有的UIActivityIndicatorView就会被设置hidden。所以需要在列表显示的时候，且isRefreshing==YES的时候，再让UIActivityIndicatorView重新开启动画。
 //    if (scrollView.mj_header.isRefreshing) {
 //        UIActivityIndicatorView *activity = [scrollView.mj_header valueForKey:@"loadingView"];
 //        [activity startAnimating];
 //    }
 */
typedef NS_ENUM(NSUInteger, CGXCategoryListContainerType) {
    CGXCategoryListContainerType_ScrollView,
    CGXCategoryListContainerType_CollectionView,
};

@interface CGXCategoryListContainerView : UIView <CGXCategoryListContainerViewScrollDelegate>

@property (nonatomic, assign, readonly) CGXCategoryListContainerType containerType;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<CGXCategoryListContainerViewDelegate>> *validListDict;   //已经加载过的列表字典。key是index，value是对应的列表
/**
 滚动切换的时候，滚动距离超过一页的多少百分比，就触发列表的初始化。默认0.01（即列表显示了一点就触发加载）。范围0~1，开区间不包括0和1
 */
@property (nonatomic, assign) CGFloat initListPercent;

/**
   初始化方式
*/
- (instancetype)initWithType:(CGXCategoryListContainerType)type DataSource:(id<CGXCategoryListContainerViewDataSource>)dataSource NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

