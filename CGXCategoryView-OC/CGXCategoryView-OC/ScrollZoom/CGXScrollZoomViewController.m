//
//  CGXScrollZoomViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXScrollZoomViewController.h"

#import "CGXScrollZoomListViewController.h"

@interface CGXScrollZoomViewController () <CGXCategoryViewDelegate, UIGestureRecognizerDelegate,CGXCategoryListContainerViewDataSource>
@property (nonatomic, strong) CGXCategoryTitleVerticalZoomView *categoryView;
@property (nonatomic, strong) CGXCategoryListContainerView *listContainerView;
@property (nonatomic, assign) CGFloat minCategoryViewHeight;
@property (nonatomic, assign) CGFloat maxCategoryViewHeight;
@property (nonatomic, strong) id interactivePopGestureRecognizerDelegate;
@end

@implementation CGXScrollZoomViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    CGFloat topStatusBarHeight = kStatusBarHeight>20 ? kStatusBarHeight :20;
    self.minCategoryViewHeight = 40;
    self.maxCategoryViewHeight = 60;

    self.categoryView = [[CGXCategoryTitleVerticalZoomView alloc] init];
    self.categoryView.frame = CGRectMake(0, topStatusBarHeight, self.view.bounds.size.width, self.maxCategoryViewHeight);
    self.categoryView.averageCellSpacingEnabled = NO;
    self.categoryView.titleArray = [NSMutableArray arrayWithArray:@[@"推荐", @"关注"]];
    self.categoryView.delegate = self;
    self.categoryView.titleLabelAnchorPointStyle = CGXCategoryTitleLabelAnchorPointStyleBottom;
    self.categoryView.titleLabelVerticalOffset = -5;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.contentEdgeInsetLeft = 20;
    self.categoryView.cellSpacing = 20;
    self.categoryView.maxVerticalCellSpacing = 20;
    self.categoryView.minVerticalCellSpacing = 10;
    self.categoryView.maxVerticalFontScale = 1.5;
    self.categoryView.minVerticalFontScale = 1.2;
    self.categoryView.maxVerticalContentEdgeInsetLeft = 20;
    self.categoryView.minVerticalContentEdgeInsetLeft = 10;
    [self.view addSubview:self.categoryView];
    
    CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
    lineView.lineStyle = CGXCategoryIndicatorLineStyle_IQIYI;
    self.categoryView.indicators = @[lineView];

    
    self.categoryView.isBottomHidden = NO;
    
    self.listContainerView = [[CGXCategoryListContainerView alloc] initWithType:CGXCategoryListContainerType_ScrollView DataSource:self];
    self.listContainerView.frame = CGRectMake(0, topStatusBarHeight + self.maxCategoryViewHeight, self.view.bounds.size.width, self.view.bounds.size.height - topStatusBarHeight - self.maxCategoryViewHeight);
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)listScrollViewDidScroll:(UIScrollView *)scrollView {
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //用户交互引起的滚动才处理
        return;
    }
    if (self.categoryView.isHorizontalZoomTransitionAnimating) {
        //当前cell正在进行动画过渡
        return;
    }
    //用于垂直方向滚动时，视图的frame调整
    if ((self.categoryView.bounds.size.height < self.maxCategoryViewHeight) && scrollView.contentOffset.y < 0) {
        //当前属于缩小状态且往下滑动
        //列表往下移动、categoryView高度增加
        CGRect categoryViewFrame = self.categoryView.frame;
        categoryViewFrame.size.height -= scrollView.contentOffset.y;
        categoryViewFrame.size.height = MIN(self.maxCategoryViewHeight, categoryViewFrame.size.height);
        self.categoryView.frame = categoryViewFrame;

        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame));
        if (self.categoryView.bounds.size.height == self.maxCategoryViewHeight) {
            //从小缩放到最大，将其他列表的contentOffset重置
            for (id<CGXCategoryListContainerViewDelegate>list in self.listContainerView.validListDict.allValues) {
                
                CGXScrollZoomListViewController *listVC = (CGXScrollZoomListViewController *)list;
                
                UIScrollView *listScrollView = listVC.tableView;
                if (listScrollView != scrollView) {
                    [listScrollView setContentOffset:CGPointZero animated:NO];
                }
            }
        }

        scrollView.contentOffset = CGPointZero;
    }else if (((self.categoryView.bounds.size.height < self.maxCategoryViewHeight) && scrollView.contentOffset.y >= 0 && self.categoryView.bounds.size.height > self.minCategoryViewHeight) ||
              (self.categoryView.bounds.size.height >= self.maxCategoryViewHeight && scrollView.contentOffset.y >= 0)) {
        //当前属于缩小状态且往上滑动且categoryView的高度大于minCategoryViewHeight 或者 当前最大高度状态且往上滑动
        //列表往上移动、categoryView高度减小
        CGRect categoryViewFrame = self.categoryView.frame;
        categoryViewFrame.size.height -= scrollView.contentOffset.y;
        categoryViewFrame.size.height = MAX(self.minCategoryViewHeight, categoryViewFrame.size.height);
        self.categoryView.frame = categoryViewFrame;

        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame));

        scrollView.contentOffset = CGPointZero;
    }

    //必须调用
    CGFloat percent = (self.categoryView.bounds.size.height - self.minCategoryViewHeight)/(self.maxCategoryViewHeight - self.minCategoryViewHeight);
    [self.categoryView listDidScrollWithVerticalHeightPercent:percent];
}

- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(CGXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}
- (id<CGXCategoryListContainerViewDelegate>)listContainerView:(CGXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    CGXScrollZoomListViewController *list = [[CGXScrollZoomListViewController alloc] init];
    list.tagStr = self.categoryView.titleArray[index];
    __weak typeof(self) weakSelf = self;
    list.didScrollCallback = ^(UIScrollView *scrollView) {
        [weakSelf listScrollViewDidScroll:scrollView];
    };
    return list;
}
- (NSInteger)numberOfListsInlistContainerView:(CGXCategoryListContainerView *)listContainerView {
    return self.categoryView.titleArray.count;
}

@end
