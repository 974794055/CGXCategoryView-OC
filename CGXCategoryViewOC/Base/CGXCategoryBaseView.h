//
//  CGXCategoryBaseView.h
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGXCategoryBaseCellModel.h"
#import "CGXCategoryCollectionView.h"
#import "CGXCategoryViewDefines.h"
#import "CGXCategoryListContainerViewScrollDelegate.h"

@class CGXCategoryBaseView;
@protocol CGXCategoryViewDelegate <NSObject>

@optional
/**
 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;
/**
 点击选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

/**
 滚动选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;
/**
 控制能否点击Item
 @param categoryView categoryView对象
 @param index 准备点击的index
 @return 能否点击
 */
- (BOOL)categoryView:(CGXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index;
/**
 正在滚动中的回调
 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 从左往右计算的百分比
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;

@end


@interface CGXCategoryBaseView : UIView

@property (nonatomic, strong, readonly) CGXCategoryCollectionView *collectionView;

@property (nonatomic, strong) NSArray <CGXCategoryBaseCellModel *> *dataSource;

@property (nonatomic, weak) id<CGXCategoryViewDelegate> delegate;
/**
 高封装度的列表容器，使用该类可以让列表拥有完成的生命周期、自动同步defaultSelectedIndex、自动调用reloadData。
 */
@property (nonatomic, weak) id<CGXCategoryListContainerViewScrollDelegate> listContainer;

@property (nonatomic, strong) UIScrollView *contentScrollView;    //需要关联的contentScrollView

@property (nonatomic, assign) BOOL contentScrollAnimated; // //手势滚动中，是否有滚动动画。默认为YES
@property (nonatomic, assign) NSInteger defaultSelectedIndex;   //修改初始化的时候默认选择的index

@property (nonatomic, assign, readonly) NSInteger selectedIndex;//当前选择的index

@property (nonatomic, assign) CGFloat contentEdgeInsetLeft;     //整体内容的左边距，默认CGXCategoryViewAutomaticDimension（等于cellSpacing）

@property (nonatomic, assign) CGFloat contentEdgeInsetRight;    //整体内容的右边距，默认CGXCategoryViewAutomaticDimension（等于cellSpacing）

@property (nonatomic, assign) CGFloat cellWidth;    //默认CGXCategoryViewAutomaticDimension

@property (nonatomic, assign) CGFloat cellWidthIncrement;    //cell宽度补偿。默认：0

@property (nonatomic, assign) CGFloat cellSpacing;    //cell之间的间距，默认20

@property (nonatomic, assign) BOOL averageCellSpacingEnabled;     //当collectionView.contentSize.width小于CGXCategoryBaseView的宽度，是否将cellWidth均分。默认为YES。

//cell较少时是否剧中显示状态  averageCellSpacingEnabled     为YES有效
@property (nonatomic, assign) BOOL cellWidthZenter;     //默认剧左

//----------------------cellWidthZoomEnabled-----------------------//
//cell宽度是否缩放
@property (nonatomic, assign) BOOL cellWidthZoomEnabled;     //默认为NO

@property (nonatomic, assign) BOOL cellWidthZoomScrollGradientEnabled;     //手势滚动过程中，是否需要更新cell的宽度。默认为YES

@property (nonatomic, assign) CGFloat cellWidthZoomScale;    //默认1.2，cellWidthZoomEnabled为YES才生效

@property (nonatomic, assign) BOOL selectedAnimationEnabled;    //是否开启选中动画。默认为NO。自定义的cell选中动画需要自己实现。

@property (nonatomic, assign) NSTimeInterval selectedAnimationDuration;     //cell选中动画的时间。默认0.25
@property (nonatomic, strong) UIImage *bgImage;
// 用于设置网络背景图
@property (nonatomic , strong,readonly) UIImageView *bgImageView;
/**
 选中目标index的item
 @param index 目标index
 */
- (void)selectItemAtIndex:(NSInteger)index;
/**
 初始化的时候无需调用。比如页面初始化之后，根据网络接口异步回调回来数据，重新配置categoryView，需要调用该方法进行刷新。
 */
- (void)reloadData;
/**
 刷新指定的index的cell
 内部会触发`- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index`方法进行cellModel刷新
 @param index 指定cell的index
 */
- (void)reloadCellAtIndex:(NSInteger)index;

@end

#pragma mark - Subclass Override
@interface CGXCategoryBaseView (BaseHooks)

/**
 reloadData方法调用，重新生成数据源赋值到self.dataSource
 */
- (void)refreshDataSource NS_REQUIRES_SUPER;
/**
 reloadData时，返回每个cell的宽度
 @param index 目标index
 @return cellWidth
 */
- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index NS_REQUIRES_SUPER;
/**
 返回自定义cell的class
 @return cell class
 */
- (Class)preferredCellClass NS_REQUIRES_SUPER;

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex;

- (void)initializeData NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;
/**
 reloadData方法调用，根据数据源重新刷新状态；
 */
- (void)refreshState NS_REQUIRES_SUPER;
/**
 选中某个item时，刷新将要选中与取消选中的cellModel

 @param selectedCellModel 将要选中的cellModel
 @param unselectedCellModel 取消选中的cellModel
 */
- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel NS_REQUIRES_SUPER;
/**
 关联的contentScrollView的contentOffset发生了改变

 @param contentOffset 偏移量
 */
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset NS_REQUIRES_SUPER;
/**
 选中某一个item的时候调用，该方法用于子类重载。
 如果外部要选中某个index，请使用`- (void)selectItemAtIndex:(NSUInteger)index;`

 @param index 选中的index
 @param selectedType CGXCategoryCellSelectedType
 @return 返回值为NO，表示触发内部某些判断（点击了同一个cell），子类无需后续操作。
 */
- (BOOL)selectCellAtIndex:(NSInteger)index selectedType:(CGXCategoryCellSelectedType)selectedType NS_REQUIRES_SUPER;

/**
 refreshState时调用，重置cellModel的状态
 @param cellModel 待重置的cellModel
 @param index cellModel在数组中的index
 */
- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index NS_REQUIRES_SUPER;


@end
