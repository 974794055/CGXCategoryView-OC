//
//  CGXCategoryListContainerView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryListContainerView.h"
#import <objc/runtime.h>
#import "CGXCategoryFactory.h"
#import "CGXCategoryListContainerViewController.h"
@interface CGXCategoryListContainerView () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) id<CGXCategoryListContainerViewDataSource> dataSource;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<CGXCategoryListContainerViewDelegate>> *validListDict;
@property (nonatomic, assign) NSInteger willAppearIndex;
@property (nonatomic, assign) NSInteger willDisappearIndex;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) CGXCategoryListContainerViewController *containerVC;
@end

@implementation CGXCategoryListContainerView

- (instancetype)initWithType:(CGXCategoryListContainerType)type DataSource:(id<CGXCategoryListContainerViewDataSource>)dataSource{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _containerType = type;
        _dataSource = dataSource;
        _validListDict = [NSMutableDictionary dictionary];
        _willAppearIndex = -1;
        _willDisappearIndex = -1;
        _initListPercent = 0.01;
        self.isNestEnabled = YES;
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    _containerVC = [[CGXCategoryListContainerViewController alloc] init];
    self.containerVC.view.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containerVC.view];
    __weak typeof(self) weakSelf = self;
    self.containerVC.viewWillAppearBlock = ^{
        [weakSelf listWillAppear:weakSelf.currentIndex];
    };
    self.containerVC.viewDidAppearBlock = ^{
        [weakSelf listDidAppear:weakSelf.currentIndex];
    };
    self.containerVC.viewWillDisappearBlock = ^{
        [weakSelf listWillDisappear:weakSelf.currentIndex];
    };
    self.containerVC.viewDidDisappearBlock = ^{
        [weakSelf listDidDisappear:weakSelf.currentIndex];
    };
    if (self.containerType == CGXCategoryListContainerType_ScrollView) {
        if (self.dataSource &&
            [self.dataSource respondsToSelector:@selector(scrollViewClassInlistContainerView:)] &&
            [[self.dataSource scrollViewClassInlistContainerView:self] isKindOfClass:object_getClass([UIScrollView class])]) {
            _scrollView = (UICollectionView *)[[[self.dataSource scrollViewClassInlistContainerView:self] alloc] init];
        }else {
            _scrollView = [[UIScrollView alloc] init];
        }
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.scrollView.backgroundColor =  [UIColor clearColor];
        [CGXCategoryFactory horizontalFlipViewIfNeeded:self.scrollView];
        [self.containerVC.view addSubview:self.scrollView];
    }else {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        if (self.dataSource &&
            [self.dataSource respondsToSelector:@selector(scrollViewClassInlistContainerView:)] &&
            [[self.dataSource scrollViewClassInlistContainerView:self] isKindOfClass:object_getClass([UICollectionView class])]) {
            _collectionView = (UICollectionView *)[[[self.dataSource scrollViewClassInlistContainerView:self] alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        }else {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        }
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.scrollsToTop = NO;
        self.collectionView.bounces = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        self.collectionView.backgroundColor = [UIColor clearColor];;
        if (@available(iOS 10.0, *)) {
            self.collectionView.prefetchingEnabled = NO;
        }
        if (@available(iOS 11.0, *)) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        if ([CGXCategoryFactory supportRTL]) {
            if (@available(iOS 9.0, *)) {
                self.collectionView.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
                [CGXCategoryFactory horizontalFlipView:self.collectionView];
            }
        }
        [self.containerVC.view addSubview:self.collectionView];
        //让外部统一访问scrollView
        _scrollView = _collectionView;
    }
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

- (void)layoutSubviews {
    [super layoutSubviews];
    self.containerVC.view.frame = self.bounds;
    if (self.containerType == CGXCategoryListContainerType_ScrollView) {
        if (!CGRectEqualToRect(self.scrollView.frame, CGRectZero) &&  !CGSizeEqualToSize(self.scrollView.bounds.size, self.bounds.size)) {
            self.scrollView.frame = self.bounds;
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.dataSource numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
            [_validListDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull index, id<CGXCategoryListContainerViewDelegate>  _Nonnull list, BOOL * _Nonnull stop) {
                [list listView].frame = CGRectMake(index.intValue*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            }];
            self.scrollView.contentOffset = CGPointMake(self.currentIndex*self.scrollView.bounds.size.width, 0);
        }else {
            self.scrollView.frame = self.bounds;
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.dataSource numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
        }
    }else {
        if (!CGRectEqualToRect(self.collectionView.frame, CGRectZero) &&  !CGSizeEqualToSize(self.collectionView.bounds.size, self.bounds.size)) {
            self.collectionView.frame = self.bounds;
            [self.collectionView.collectionViewLayout invalidateLayout];
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.bounds.size.width*self.currentIndex, 0) animated:NO];
        }else {
            self.collectionView.frame = self.bounds;
        }
    }
}


- (void)setinitListPercent:(CGFloat)initListPercent {
    _initListPercent = initListPercent;
    if (initListPercent <= 0 || initListPercent >= 1) {
        NSAssert(NO, @"initListPercent值范围为开区间(0,1)，即不包括0和1");
    }
}
- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    self.scrollView.bounces = bounces;
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfListsInlistContainerView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    [CGXCategoryFactory horizontalFlipViewIfNeeded:cell];
    [CGXCategoryFactory horizontalFlipViewIfNeeded:cell.contentView];
    id<CGXCategoryListContainerViewDelegate> list = _validListDict[@(indexPath.item)];
    [list listView].frame = cell.contentView.bounds;
    [cell.contentView addSubview:[list listView]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:DidScroll:)]) {
        [self.dataSource listContainerView:self DidScroll:scrollView];
    }
    CGFloat currentIndexPercent = scrollView.contentOffset.x/scrollView.bounds.size.width;
    if (self.willAppearIndex != -1 || self.willDisappearIndex != -1) {
        NSInteger disappearIndex = self.willDisappearIndex;
        NSInteger appearIndex = self.willAppearIndex;
        if (self.willAppearIndex > self.willDisappearIndex) {
            //将要出现的列表在右边
            if (currentIndexPercent >= self.willAppearIndex) {
                self.willDisappearIndex = -1;
                self.willAppearIndex = -1;
                [self listDidDisappear:disappearIndex];
                [self listDidAppear:appearIndex];
            }
        }else {
            //将要出现的列表在左边
            if (currentIndexPercent <= self.willAppearIndex) {
                self.willDisappearIndex = -1;
                self.willAppearIndex = -1;
                [self listDidDisappear:disappearIndex];
                [self listDidAppear:appearIndex];
            }
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.willDisappearIndex != -1) {
        [self listWillAppear:self.willDisappearIndex];
        [self listWillDisappear:self.willAppearIndex];
        [self listDidAppear:self.willDisappearIndex];
        [self listDidDisappear:self.willAppearIndex];
        self.willDisappearIndex = -1;
        self.willAppearIndex = -1;
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:DidEndDecelerating:)]) {
        [self.dataSource listContainerView:self DidEndDecelerating:scrollView];
    }
    NSInteger currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:ScrollAtIndex:)]) {
        [self.dataSource listContainerView:self ScrollAtIndex:currentIndex];
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:ScrollAtIndex:)]) {
        [self.dataSource listContainerView:self ScrollAtIndex:currentIndex];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:DidEndDragging:willDecelerate:)]) {
        [self.dataSource listContainerView:self DidEndDragging:scrollView willDecelerate:decelerate];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:WillBeginDragging:)]) {
        [self.dataSource listContainerView:self WillBeginDragging:scrollView];
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:WillBeginDecelerating:)]) {
        [self.dataSource listContainerView:self WillBeginDecelerating:scrollView];
    }
}

#pragma mark - CGXCategoryListContainerViewScrollDelegate

- (UIScrollView *)contentScrollView {
    return self.scrollView;
}
- (void)setDefaultSelectedIndex:(NSInteger)index {
    self.currentIndex = index;
}

- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex {
    if (rightIndex == selectedIndex) {
        //当前选中的在右边，用户正在从右边往左边滑动
        if (ratio < (1 - self.initListPercent)) {
            [self initListIfNeededAtIndex:leftIndex];
        }
        if (self.willAppearIndex == -1) {
            self.willAppearIndex = leftIndex;
            if (self.validListDict[@(leftIndex)] != nil) {
                [self listWillAppear:self.willAppearIndex];
            }
        }
        if (self.willDisappearIndex == -1) {
            self.willDisappearIndex = rightIndex;
            [self listWillDisappear:self.willDisappearIndex];
        }
    }else {
        //当前选中的在左边，用户正在从左边往右边滑动
        if (ratio > self.initListPercent) {
            [self initListIfNeededAtIndex:rightIndex];
        }
        if (self.willAppearIndex == -1) {
            self.willAppearIndex = rightIndex;
            if (_validListDict[@(rightIndex)] != nil) {
                [self listWillAppear:self.willAppearIndex];
            }
        }
        if (self.willDisappearIndex == -1) {
            self.willDisappearIndex = leftIndex;
            [self listWillDisappear:self.willDisappearIndex];
        }
    }
}

- (void)didClickSelectedItemAtIndex:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    self.willAppearIndex = -1;
    self.willDisappearIndex = -1;
    if (self.currentIndex != index) {
        [self listWillDisappear:self.currentIndex];
        [self listDidDisappear:self.currentIndex];
        [self listWillAppear:index];
        [self listDidAppear:index];
    }
}

- (void)reloadData {
    for (id<CGXCategoryListContainerViewDelegate> list in _validListDict.allValues) {
        [[list listView] removeFromSuperview];
    }
    [_validListDict removeAllObjects];
    
    if (self.containerType == CGXCategoryListContainerType_ScrollView) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.dataSource numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
    }else {
        [self.collectionView reloadData];
    }
    [self listWillAppear:self.currentIndex];
    [self listDidAppear:self.currentIndex];
}

#pragma mark - Private

- (void)initListIfNeededAtIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
        BOOL canInitList = [self.dataSource listContainerView:self canInitListAtIndex:index];
        if (!canInitList) {
            return;
        }
    }
    id<CGXCategoryListContainerViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        //列表已经创建好了
        return;
    }
    list = [self.dataSource listContainerView:self initListForIndex:index];
    if ([list isKindOfClass:[UIViewController class]]) {
        [self.containerVC addChildViewController:(UIViewController *)list];
    }
    _validListDict[@(index)] = list;
    
    if (self.containerType == CGXCategoryListContainerType_ScrollView) {
        [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.scrollView addSubview:[list listView]];
        [CGXCategoryFactory horizontalFlipViewIfNeeded:[list listView]];
    }else {
        UICollectionViewCell *cell = (UICollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        for (UIView *subview in cell.contentView.subviews) {
            [subview removeFromSuperview];
        }
        [list listView].frame = cell.contentView.bounds;
        [cell.contentView addSubview:[list listView]];
    }
    [self listWillAppear:index];
}

- (void)listWillAppear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<CGXCategoryListContainerViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        if (list && [list respondsToSelector:@selector(listWillAppearAtIndex:)]) {
            [list listWillAppearAtIndex:index];
        }
        if ([list isKindOfClass:[UIViewController class]]) {
            UIViewController *listVC = (UIViewController *)list;
            [listVC beginAppearanceTransition:YES animated:NO];
        }
    }else {
        //当前列表未被创建（页面初始化或通过点击触发的listWillAppear）
        BOOL canInitList = YES;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
            canInitList = [self.dataSource listContainerView:self canInitListAtIndex:index];
        }
        if (canInitList) {
            id<CGXCategoryListContainerViewDelegate> list = _validListDict[@(index)];
            if (list == nil) {
                list = [self.dataSource listContainerView:self initListForIndex:index];
                if ([list isKindOfClass:[UIViewController class]]) {
                    [self.containerVC addChildViewController:(UIViewController *)list];
                }
                _validListDict[@(index)] = list;
            }
            if (self.containerType == CGXCategoryListContainerType_ScrollView) {
                if ([list listView].superview == nil) {
                    [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
                    [self.scrollView addSubview:[list listView]];
                    [CGXCategoryFactory horizontalFlipViewIfNeeded:[list listView]];
                    if (list && [list respondsToSelector:@selector(listWillAppearAtIndex:)]) {
                        [list listWillAppearAtIndex:index];
                    }
                    if ([list isKindOfClass:[UIViewController class]]) {
                        UIViewController *listVC = (UIViewController *)list;
                        [listVC beginAppearanceTransition:YES animated:NO];
                    }
                }
            }else {

                UICollectionViewCell *cell = (UICollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
                for (UIView *subview in cell.contentView.subviews) {
                    [subview removeFromSuperview];
                }
                [list listView].frame = cell.contentView.bounds;
                [cell.contentView addSubview:[list listView]];
                
                if (list && [list respondsToSelector:@selector(listWillAppearAtIndex:)]) {
                    [list listWillAppearAtIndex:index];
                }
                if ([list isKindOfClass:[UIViewController class]]) {
                    UIViewController *listVC = (UIViewController *)list;
                    [listVC beginAppearanceTransition:YES animated:NO];
                }
            }
        }
    }
}


- (void)listDidAppear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    self.currentIndex = index;
    id<CGXCategoryListContainerViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidAppearAtIndex:)]) {
        [list listDidAppearAtIndex:index];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC endAppearanceTransition];
    }
}

- (void)listWillDisappear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<CGXCategoryListContainerViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listWillDisappearAtIndex:)]) {
        [list listWillDisappearAtIndex:index];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC beginAppearanceTransition:NO animated:NO];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<CGXCategoryListContainerViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappearAtIndex:)]) {
        [list listDidDisappearAtIndex:index];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC endAppearanceTransition];
    }
}

- (BOOL)checkIndexValid:(NSInteger)index {
    NSUInteger count = [self.dataSource numberOfListsInlistContainerView:self];
    if (count <= 0 || index >= count) {
        return NO;
    }
    return YES;
}

@end
