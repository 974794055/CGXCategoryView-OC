//
//  CGXCategoryTitleMenuView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryTitleMenuView.h"
#import "CGXCategoryTitleImageView.h"

typedef NS_ENUM(NSUInteger, CGXCategoryTitleMenuViewClickType) {
    CGXCategoryTitleMenuViewClickTypeSelected,//点击选中或者滚动选中
    CGXCategoryTitleMenuViewClickTypeClickSelected,//点击选中的情况才会调用该方法
    CGXCategoryTitleMenuViewClickTypeScroll,//滚动选中的情况才会调用该方法
};


@interface CGXCategoryTitleMenuViewController : UIViewController<CGXCategoryListContainerViewDelegate>
@property (copy) void(^viewWillAppearBlock)(void);
@property (copy) void(^viewDidAppearBlock)(void);
@property (copy) void(^viewWillDisappearBlock)(void);
@property (copy) void(^viewDidDisappearBlock)(void);
@end

@implementation CGXCategoryTitleMenuViewController
- (void)dealloc
{
    if (self.viewWillAppearBlock) {
        self.viewWillAppearBlock = nil;
    }
    if (self.viewDidAppearBlock) {
        self.viewDidAppearBlock = nil;
    }
    if (self.viewWillDisappearBlock) {
        self.viewWillDisappearBlock = nil;
    }
    if (self.viewDidDisappearBlock) {
        self.viewDidDisappearBlock = nil;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.viewWillAppearBlock) {
        self.viewWillAppearBlock();
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.viewDidAppearBlock) {
        self.viewDidAppearBlock();
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.viewWillDisappearBlock) {
        self.viewWillDisappearBlock();
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.viewDidDisappearBlock) {
        self.viewDidDisappearBlock();
    }
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}
- (UIView *)listView
{
    return self.view;
}
@end

@interface CGXCategoryTitleMenuView ()<CGXCategoryViewDelegate,CGXCategoryListContainerViewDataSource>

@property (nonatomic , strong) CGXCategoryTitleImageView *categoryView;

@property (nonatomic , strong)  NSMutableArray<UIViewController *> *listVCArray;

//当前选中下表 默认0
@property (nonatomic , assign,readwrite) NSInteger currentInteger;

@property (nonatomic , strong) CGXCategoryListContainerView *containerView;

@property (nonatomic , strong,readwrite) NSMutableArray<CGXCategoryTitleMenuModel *> *dataArray;

@property (nonatomic, strong) CGXCategoryTitleMenuViewController *containerVC;

@end

@implementation CGXCategoryTitleMenuView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializeWiew];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initializeWiew];
    }
    return self;
}
- (NSMutableArray<UIViewController *> *)listVCArray
{
    if (!_listVCArray) {
        _listVCArray = [NSMutableArray array];
    }
    return _listVCArray;
}
- (void)initializeWiew
{
    self.currentInteger = 0;
    self.categoryViewHeight = 50;
    self.didAppearPercent = 0.5;
    self.topLineSpace = 0;
    self.topLineHeight = 1;
    self.topLineColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    self.bottomLineSpace = 1;
    self.bottomLineHeight = 1;
    self.bottomLineColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    
    
    self.cellBackgroundNormalColor = [UIColor clearColor];
    self.cellBackgroundSelectedColor = [UIColor clearColor];
    self.titleNormalColor = [UIColor blackColor];
    self.titleSelectedColor = [UIColor redColor];
    self.titleFont = [UIFont systemFontOfSize:14];;
    self.titleSelectedFont = [UIFont systemFontOfSize:14];
    
    self.dataArray = [NSMutableArray array];
    self.contentScrollAnimated  =YES;
    self.contentEdgeInsetLeft = CGXCategoryViewAutomaticDimension;
    self.contentEdgeInsetRight = CGXCategoryViewAutomaticDimension;
    self.cellWidth = CGXCategoryViewAutomaticDimension;
    self.cellWidthIncrement = 0;
    self.cellSpacing = 20;
    self.averageCellSpacingEnabled = YES;
    self.cellWidthZenter = NO;     //默认剧左
    self.imageSize = CGSizeMake(20, 20);
    self.titleImageSpacing = 5;
    self.imageZoomScale = 1.0;
    self.titleLabelZoomScale = 1.0;
    _containerVC = [[CGXCategoryTitleMenuViewController alloc] init];
    self.containerVC.view.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containerVC.view];
    __weak typeof(self) weakSelf = self;
    self.containerVC.viewWillAppearBlock = ^{
        //        [weakSelf listWillAppear:weakSelf.currentIndex];
    };
    self.containerVC.viewDidAppearBlock = ^{
        if (weakSelf.delegate  && [weakSelf.delegate respondsToSelector:@selector(categoryMenuView:ListDidAppearIndex:)]) {
            [weakSelf.delegate categoryMenuView:weakSelf ListDidAppearIndex:weakSelf.currentInteger];
        }
    };
    self.containerVC.viewWillDisappearBlock = ^{
        //        [weakSelf listWillDisappear:weakSelf.currentIndex];
    };
    self.containerVC.viewDidDisappearBlock = ^{
        if (weakSelf.delegate  && [weakSelf.delegate respondsToSelector:@selector(categoryMenuView:ListDidDisappear:)]) {
            [weakSelf.delegate categoryMenuView:weakSelf ListDidDisappear:weakSelf.currentInteger];
        }
    };
    self.categoryView = [[CGXCategoryTitleImageView alloc] init];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleNumberOfLines = 0;
    self.categoryView.imageZoomEnabled  =YES;
    self.categoryView.titleLabelZoomEnabled  =YES;
    self.categoryView.cellBackgroundColorGradientEnabled  =YES;
    self.categoryView.isBottomHidden  = YES;
    [self.containerVC.view addSubview:self.categoryView];
    
    self.containerView = [[CGXCategoryListContainerView alloc] initWithType:CGXCategoryListContainerType_ScrollView DataSource:self];
    [self.containerVC.view addSubview:self.containerView];
    self.categoryView.listContainer = self.containerView;
    
    [self updateInitView];
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            [((UIViewController *)next) addChildViewController:self.containerVC];
            break;
        }
        next = next.nextResponder;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.containerVC.view.frame = self.bounds;
    self.categoryView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), self.categoryViewHeight);
    self.containerView.frame = CGRectMake(0, self.categoryViewHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-self.categoryViewHeight);
    if (self.topLineHeight>0) {
        [self.categoryView.layer insertSublayer:[self addLineOriginPoint:CGPointMake(self.topLineSpace, 0) toPoint:CGPointMake(CGRectGetWidth(self.categoryView.bounds)-self.topLineSpace*2, 0) color:self.topLineColor borderWidth:self.topLineHeight] atIndex:0];
    }
    if (self.bottomLineHeight>0) {
        [self.categoryView.layer insertSublayer:[self addLineOriginPoint:CGPointMake(self.bottomLineSpace, CGRectGetHeight(self.categoryView.frame)) toPoint:CGPointMake(CGRectGetWidth(self.categoryView.bounds)-self.bottomLineSpace*2, CGRectGetHeight(self.categoryView.frame)) color:self.bottomLineColor borderWidth:self.bottomLineHeight] atIndex:0];
    }
}
- (void)setIndicators:(NSArray<UIView<CGXCategoryIndicatorProtocol> *> *)indicators {
    _indicators = indicators;
    self.categoryView.indicators = indicators;
}
- (void)updateWithDataArray:(NSMutableArray<CGXCategoryTitleMenuModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    if (dataArray.count==0) {
        return;
    }
    NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *imageArr = [NSMutableArray array];
    NSMutableArray *imageSelectArr = [NSMutableArray array];
    NSMutableArray *imageURLArr = [NSMutableArray array];
    NSMutableArray *selectedImageURLArr = [NSMutableArray array];
    NSMutableArray *imageTypeArr = [NSMutableArray array];
    for (CGXCategoryTitleMenuModel *model in dataArray) {
        [self.dataArray addObject:model];
        [titleArr addObject:model.title];
        [imageArr addObject:model.imageName];
        [imageSelectArr addObject:model.selectedImageName];
        [imageURLArr addObject:model.imageURL];
        [selectedImageURLArr addObject:model.selectedImageURL];
        [imageTypeArr addObject:@(model.imageType)];
        if (self.loadImageCallback) {
            model.loadImageCallback = self.loadImageCallback;
        }
    }
    self.categoryView.titleArray = titleArr;
    self.categoryView.imageNames = imageArr;
    self.categoryView.selectedImageNames= imageSelectArr;
    self.categoryView.imageURLs = imageURLArr;
    self.categoryView.selectedImageURLs = selectedImageURLArr;
    self.categoryView.imageTypes = imageTypeArr;
    [self updateInitView];
    
    [self.categoryView reloadData];
    [self selectItemAtIndex:self.currentInteger];
    
}
- (void)updateInitView
{
    self.categoryView.cellBackgroundUnselectedColor  =self.cellBackgroundNormalColor;
    self.categoryView.cellBackgroundSelectedColor  =self.cellBackgroundSelectedColor;
    self.categoryView.titleColor  =self.titleNormalColor;
    self.categoryView.titleSelectedColor  =self.titleSelectedColor;
    self.categoryView.titleFont  =self.titleFont;
    self.categoryView.titleSelectedFont  =self.titleSelectedFont;
    
    self.categoryView.contentScrollAnimated  =self.contentScrollAnimated;
    self.categoryView.contentEdgeInsetLeft  =self.contentEdgeInsetLeft;
    self.categoryView.contentEdgeInsetRight  =self.contentEdgeInsetRight;
    self.categoryView.cellWidth  =self.cellWidth;
    self.categoryView.cellWidthIncrement  =self.cellWidthIncrement;
    self.categoryView.cellSpacing  =self.cellSpacing;
    self.categoryView.averageCellSpacingEnabled  =self.averageCellSpacingEnabled;
    self.categoryView.cellWidthZenter  =self.cellWidthZenter;
    self.categoryView.imageSize  =self.imageSize;
    self.categoryView.titleImageSpacing  =self.titleImageSpacing;
    self.categoryView.imageZoomScale  =self.imageZoomScale;
    
    self.categoryView.titleLabelZoomScale  =self.titleLabelZoomScale;
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
    [self categoryViewChooseItemAtIndex:index Type:CGXCategoryTitleMenuViewClickTypeSelected];
}
/**
 点击选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;
{
    [self categoryViewChooseItemAtIndex:index Type:CGXCategoryTitleMenuViewClickTypeClickSelected];
}
/**
 滚动选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
    [self categoryViewChooseItemAtIndex:index Type:CGXCategoryTitleMenuViewClickTypeScroll];
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
//        CGXCategorViewDebugLog(@"正在滚动--%ld--%ld--%f",(long)leftIndex,leftIndex,ratio);
    }
}
// 将要消失 出现
- (void)viewWillListDidDisappear:(NSInteger)didDisappear DisappearIndex:(NSInteger)disappear
{
    [self viewController:self].navigationController.interactivePopGestureRecognizer.enabled = (disappear == 0);
    self.currentInteger = disappear;
    if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:ListDidDisappear:)]) {
        [self.delegate categoryMenuView:self ListDidDisappear:didDisappear];
        CGXCategorViewDebugLog(@"将要消失--%ld" , (long)didDisappear);
    }
    if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:ListDidAppearIndex:)]) {
        [self.delegate categoryMenuView:self ListDidAppearIndex:disappear];
        CGXCategorViewDebugLog(@"将要显示--%ld" , (long)disappear);
    }
}
- (void)categoryViewChooseItemAtIndex:(NSInteger)index Type:(CGXCategoryTitleMenuViewClickType)type
{
    if (self.currentInteger != index) {
        [self viewWillListDidDisappear:self.currentInteger DisappearIndex:index];
    }
    [self viewController:self].navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    self.currentInteger = index;
    switch (type) {
        case CGXCategoryTitleMenuViewClickTypeSelected:
        {
            if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:didSelectedItemAtIndex:)]) {
                [self.delegate categoryMenuView:self didSelectedItemAtIndex:index];
            }
        }
            break;
        case CGXCategoryTitleMenuViewClickTypeClickSelected:
        {
            if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:didClickSelectedItemAtIndex:)]) {
                [self.delegate categoryMenuView:self didClickSelectedItemAtIndex:index];
            }
        }
            break;
        case CGXCategoryTitleMenuViewClickTypeScroll:
        {
            if (self.delegate  && [self.delegate respondsToSelector:@selector(categoryMenuView:didScrollSelectedItemAtIndex:)]) {
                [self.delegate categoryMenuView:self didScrollSelectedItemAtIndex:index];
            }
        }
            break;
        default:
            break;
    }
}
/**
 返回list的数量
 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(CGXCategoryListContainerView *)listContainerView
{
    return self.dataArray.count;
}
/**
 根据index返回一个对应列表实例，需要是遵从`CGXCategoryListContentViewDelegate`协议的对象。
 你可以代理方法调用的时候初始化对应列表，达到懒加载的效果。这也是默认推荐的初始化列表方法。你也可以提前创建好列表，等该代理方法回调的时候再返回也可以，达到预加载的效果。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`CGXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`CGXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。
 
 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从CGXCategoryListContentViewDelegate协议的list实例
 */
- (id<CGXCategoryListContainerViewDelegate>)listContainerView:(CGXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index
{
    CGXCategoryTitleMenuViewController *listVC= [[CGXCategoryTitleMenuViewController alloc] init];
    CGXCategoryTitleMenuModel *model = self.dataArray[index];
    if (model.vcName) {
        UIViewController *vc = model.vcName;
        [listVC addChildViewController:vc];
        [listVC.view addSubview:vc.view];
    } else{
        UIViewController *vc = [[UIViewController alloc] init];
        [listVC addChildViewController:vc];
        [listVC.view addSubview:vc.view];
    }
    [self.containerVC addChildViewController:listVC];
    return listVC;
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
- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth {
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor  = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
