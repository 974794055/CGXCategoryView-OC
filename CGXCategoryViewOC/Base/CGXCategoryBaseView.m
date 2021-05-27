//
//  CGXCategoryBaseView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategoryBaseView.h"
#import "CGXCategoryFactory.h"
#import "CGXCategoryViewAnimator.h"
#import "CGXCategoryBaseCell.h"

@interface CGXCategoryBaseView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong,readwrite) CGXCategoryCollectionView *collectionView;
@property (nonatomic, assign,readwrite) NSInteger selectedIndex;
@property (nonatomic, assign) CGPoint lastContentViewContentOffset;
@property (nonatomic, strong) CGXCategoryViewAnimator *animator;
// 正在滚动中的目标index。用于处理正在滚动列表的时候，立即点击item，会导致界面显示异常。
@property (nonatomic, assign) NSInteger scrollingTargetIndex;

@property (nonatomic, assign, getter=isNeedReloadByBecomeActive) BOOL needReloadByBecomeActive;

@property (nonatomic , strong,readwrite) UIImageView *bgImageView;

@end

@implementation CGXCategoryBaseView

- (void)dealloc
{
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    [self.animator stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)next;
            if (@available(iOS 11.0, *)) {
                vc.automaticallyAdjustsScrollViewInsets = NO;
            }
            break;
        }
        next = next.nextResponder;
    }
}
- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;
    
    self.selectedIndex = defaultSelectedIndex;
    [self.listContainer setDefaultSelectedIndex:defaultSelectedIndex];
}
- (void)reloadData {
    [self refreshDataSource];
    [self refreshState];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    [self.listContainer setDefaultSelectedIndex:self.selectedIndex];
    [self.listContainer reloadData];
}

- (void)reloadCellAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.dataSource.count) {
        return;
    }
    CGXCategoryBaseCellModel *cellModel = self.dataSource[index];
    cellModel.selectedType = CGXCategoryCellSelectedTypeUnknown;
    [self refreshCellModel:cellModel index:index];
    CGXCategoryBaseCell *cell = (CGXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [cell reloadData:cellModel];
}

- (void)selectItemAtIndex:(NSInteger)index {
    [self selectCellAtIndex:index selectedType:CGXCategoryCellSelectedTypeNode];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.bounds.size.width == 0 || self.bounds.size.height == 0) {
        return;
    }
    [self.collectionView setNeedsLayout];
    [self.collectionView layoutSubviews];
    CGRect targetFrame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.collectionView.frame = targetFrame;
    self.bgImageView.frame = targetFrame;
    if (!CGRectEqualToRect(self.collectionView.frame, targetFrame)) {
        self.collectionView.frame = targetFrame;
        self.bgImageView.frame = targetFrame;
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
    
    [self reloadData];
}

- (void)setBgImage:(UIImage *)bgImage
{
    _bgImage = bgImage;
    self.bgImageView.image = bgImage;
}
#pragma mark - Setter

- (void)setDelegate:(id<CGXCategoryViewDelegate>)delegate {
    _delegate = delegate;
}
- (void)setContentScrollView:(UIScrollView *)contentScrollView
{
    if (_contentScrollView != nil) {
        [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _contentScrollView = contentScrollView;
    
    self.contentScrollView.scrollsToTop = NO;
    [self.contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)setListContainer:(id<CGXCategoryListContainerViewScrollDelegate>)listContainer {
    _listContainer = listContainer;
    self.contentScrollView = [listContainer contentScrollView];
}

#pragma mark - Subclass Override

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGXCategoryBaseCell *cell = (CGXCategoryBaseCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
    CGXCategoryBaseCellModel *cellModel = self.dataSource[indexPath.item];
    cellModel.selectedType = CGXCategoryCellSelectedTypeUnknown;
    [cell reloadData:cellModel];
    return  cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isTransitionAnimating = NO;
    for (CGXCategoryBaseCellModel *cellModel in self.dataSource) {
        if (cellModel.isTransitionAnimating) {
            isTransitionAnimating = YES;
            break;
        }
    }
    if (!isTransitionAnimating) {
        //当前没有正在过渡的item，才允许点击选中
        [self clickSelectItemAtIndex:indexPath.row];
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, [self getContentEdgeInsetLeft], 0, [self getContentEdgeInsetRight]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.dataSource[indexPath.item].cellWidth, self.collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.cellSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.cellSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(0, 0);
}
#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if ((self.contentScrollView.isTracking || self.contentScrollView.isDecelerating)) {
            //只处理用户滚动的情况
            [self contentOffsetOfContentScrollViewDidChanged:contentOffset];
        }
        self.lastContentViewContentOffset = contentOffset;
    }
}



#pragma mark - Private

- (CGFloat)getContentEdgeInsetLeft {
    if (self.contentEdgeInsetLeft == CGXCategoryViewAutomaticDimension) {
        return self.cellSpacing;
    }
    return self.contentEdgeInsetLeft;
}

- (CGFloat)getContentEdgeInsetRight {
    if (self.contentEdgeInsetRight == CGXCategoryViewAutomaticDimension) {
        return self.cellSpacing;
    }
    return self.contentEdgeInsetRight;
}

- (CGFloat)getCellWidthAtIndex:(NSInteger)index {
    return [self preferredCellWidthAtIndex:index] + self.cellWidthIncrement;
}

- (void)clickSelectItemAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:canClickItemAtIndex:)]) {
        BOOL isCanClick =  [self.delegate categoryView:self canClickItemAtIndex:index];
        if (!isCanClick) {
            return;
        }
    }
    [self selectCellAtIndex:index selectedType:CGXCategoryCellSelectedTypeClick];
}

- (void)scrollSelectItemAtIndex:(NSInteger)index {
    [self selectCellAtIndex:index selectedType:CGXCategoryCellSelectedTypeScroll];
}
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    if (self.isNeedReloadByBecomeActive) {
        self.needReloadByBecomeActive = NO;
        [self reloadData];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    CGFloat absIndex = fabs(index - self.selectedIndex);
    if (absIndex >= 1) { //”快速滑动的时候，只响应最外层VC持有的scrollView“，说实话，完全可以不用处理这种情况。如果你们的产品经理坚持认为这是个问题，就把这块代码加上吧。 //嵌套使用的时候，最外层的VC持有的scrollView在翻页之后，就断掉一次手势。解决快速滑动的时候，只响应最外层VC持有的scrollView。子VC持有的scrollView却没有响应
        self.contentScrollView.panGestureRecognizer.enabled = NO;
        self.contentScrollView.panGestureRecognizer.enabled = YES;
    }
}

@end



@implementation CGXCategoryBaseView (BaseHooks)

- (void)refreshDataSource {
    [self.collectionView reloadData];
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    return 0;
}
- (Class)preferredCellClass {
    return CGXCategoryBaseCell.class;
}
- (CGRect)getTargetCellFrame:(NSInteger)targetIndex
{
    //    //总的内容宽度（cell总宽度+总cellSpacing）
    CGFloat x = [self getContentEdgeInsetLeft];
    for (int i = 0; i < targetIndex; i ++) {
        CGXCategoryBaseCellModel *cellModel = self.dataSource[i];
        CGFloat cellWidth;
        if (cellModel.isTransitionAnimating && cellModel.isCellWidthZoomEnabled) {
            //正在进行动画的时候，cellWidthCurrentZoomScale是随着动画渐变的，而没有立即更新到目标值
            if (cellModel.isSelected) {
                cellWidth = [self getCellWidthAtIndex:cellModel.index]*cellModel.cellWidthSelectedZoomScale;
            }else {
                cellWidth = [self getCellWidthAtIndex:cellModel.index]*cellModel.cellWidthNormalZoomScale;
            }
        }else {
            cellWidth = cellModel.cellWidth;
        }
        x += cellWidth + self.cellSpacing;
    }
    CGFloat width;
    CGXCategoryBaseCellModel *selectedCellModel = self.dataSource[targetIndex];
    if (selectedCellModel.isTransitionAnimating && selectedCellModel.isCellWidthZoomEnabled) {
        width = [self getCellWidthAtIndex:selectedCellModel.index]*selectedCellModel.cellWidthSelectedZoomScale;
    }else {
        width = selectedCellModel.cellWidth;
    }
    x += (selectedCellModel.cellWidth-width)/2.0;
    return CGRectMake(x, 0, width, self.bounds.size.height);
}

- (void)initializeData
{
    _dataSource = [NSMutableArray array];
    _selectedIndex = 0;
    _cellWidth = CGXCategoryViewAutomaticDimension;
    _cellWidthIncrement = 0;
    _cellSpacing = 10;
    _averageCellSpacingEnabled = YES;
    _cellWidthZoomEnabled = NO;
    _cellWidthZoomScale = 1.2;
    _cellWidthZoomScrollGradientEnabled = YES;
    _contentEdgeInsetLeft = CGXCategoryViewAutomaticDimension;
    _contentEdgeInsetRight = CGXCategoryViewAutomaticDimension;
    _lastContentViewContentOffset = CGPointZero;
    _selectedAnimationEnabled = NO;
    _selectedAnimationDuration = 0.25;
    _scrollingTargetIndex = -1;
    _contentScrollAnimated = NO;
    self.cellWidthZenter = NO;
}
- (void)initializeViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[CGXCategoryCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];
    
    if ([CGXCategoryFactory supportRTL]) {
        if (@available(iOS 9.0, *)) {
            self.collectionView.semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
            [CGXCategoryFactory horizontalFlipView:self.collectionView];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    self.bgImageView = [[UIImageView alloc] init];
    self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.bgImageView];
    [self sendSubviewToBack:self.bgImageView];
}
- (void)refreshState {
    if (self.selectedIndex < 0 || self.selectedIndex >= self.dataSource.count) {
        self.selectedIndex = 0;
    }
    //总的内容宽度（cell总宽度+总cellSpacing）
    __block CGFloat totalItemWidth = [self getContentEdgeInsetLeft];
    CGFloat totalCellWidth = 0;
    for (int i = 0; i < self.dataSource.count; i++) {
        CGXCategoryBaseCellModel *cellModel = self.dataSource[i];
        cellModel.index = i;
        cellModel.cellWidthZoomEnabled = self.cellWidthZoomEnabled;
        cellModel.cellWidthNormalZoomScale = 1;
        cellModel.cellWidthSelectedZoomScale = self.cellWidthZoomScale;
        cellModel.selectedAnimationEnabled = self.selectedAnimationEnabled;
        cellModel.selectedAnimationDuration = self.selectedAnimationDuration;
        cellModel.cellSpacing = self.cellSpacing;
        if (i == self.selectedIndex) {
            cellModel.selected = YES;
            cellModel.cellWidthCurrentZoomScale = cellModel.cellWidthSelectedZoomScale;
        }else {
            cellModel.selected = NO;
            cellModel.cellWidthCurrentZoomScale = cellModel.cellWidthNormalZoomScale;
        }
        if (self.cellWidthZoomEnabled) {
            cellModel.cellWidth = [self getCellWidthAtIndex:i]*cellModel.cellWidthCurrentZoomScale;
        }else {
            cellModel.cellWidth = [self getCellWidthAtIndex:i];
        }
        totalCellWidth += cellModel.cellWidth;
        if (i == self.dataSource.count - 1) {
            totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
        }else {
            totalItemWidth += cellModel.cellWidth + self.cellSpacing;
        }
        [self refreshCellModel:cellModel index:i];
    }
    if (self.averageCellSpacingEnabled && totalItemWidth < CGRectGetWidth(self.collectionView.frame)) {
        //如果总的内容宽度都没有超过视图宽度，就将cellSpacing等分
        NSInteger cellSpacingItemCount = self.dataSource.count - 1;
        CGFloat totalCellSpacingWidth = self.bounds.size.width - totalCellWidth;
        //如果内容左边距是Automatic，就加1
        if (self.contentEdgeInsetLeft == CGXCategoryViewAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else {
            totalCellSpacingWidth -= [self getContentEdgeInsetLeft];;
        }
        //如果内容右边距是Automatic，就加1
        if (self.contentEdgeInsetRight == CGXCategoryViewAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else {
            totalCellSpacingWidth -= [self getContentEdgeInsetRight];;
        }
        CGFloat cellSpacing = 0;
        if (cellSpacingItemCount > 0) {
            cellSpacing = totalCellSpacingWidth/cellSpacingItemCount;
        }
        if (self.cellWidthZenter) {
            CGFloat totalCellSp = self.bounds.size.width - totalCellWidth-cellSpacingItemCount*self.cellSpacing;
            self.collectionView.frame = CGRectMake(totalCellSp/2, 0, CGRectGetWidth(self.bounds)-totalCellSp, CGRectGetHeight(self.bounds));
        }else{
            self.cellSpacing = cellSpacing;
            [self.dataSource enumerateObjectsUsingBlock:^(CGXCategoryBaseCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.cellSpacing = self.cellSpacing;
            }];
            self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
        }
    } else{
        self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    }
    //---------------------定位collectionView到当前选中的位置----------------------
    //因为初始化的时候，collectionView并没有初始化完，cell都没有被加载出来。只有自己手动计算当前选中的index的位置，然后更新到contentOffset
    __block CGFloat frameXOfSelectedCell = self.cellSpacing;
    __block CGFloat selectedCellWidth = 0;
    totalItemWidth = [self getContentEdgeInsetLeft];;
    [self.dataSource enumerateObjectsUsingBlock:^(CGXCategoryBaseCellModel * cellModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            frameXOfSelectedCell += cellModel.cellWidth + self.cellSpacing;
        }else if (idx == self.selectedIndex) {
            selectedCellWidth = cellModel.cellWidth;
        }
        if (idx == self.dataSource.count - 1) {
            totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
        }else {
            totalItemWidth += cellModel.cellWidth + self.cellSpacing;
        }
    }];
    
    CGFloat minX = 0;
    CGFloat maxX = totalItemWidth - self.bounds.size.width;
    CGFloat targetX = frameXOfSelectedCell - self.bounds.size.width/2.0 + selectedCellWidth/2.0;
    [self.collectionView setContentOffset:CGPointMake(MAX(MIN(maxX, targetX), minX), 0) animated:NO];
    //---------------------定位collectionView到当前选中的位置----------------------
    
    if (CGRectEqualToRect(self.contentScrollView.frame, CGRectZero) && self.contentScrollView.superview != nil) {
        //某些情况系统会出现CGXCategoryView先布局，contentScrollView后布局。就会导致下面指定defaultSelectedIndex失效，所以发现contentScrollView的frame为zero时，强行触发其父视图链里面已经有frame的一个父视图的layoutSubviews方法。
        //比如CGXSegmentedListContainerView会将contentScrollView包裹起来使用，该情况需要CGXSegmentedListContainerView.superView触发布局更新
        UIView *parentView = self.contentScrollView.superview;
        while (parentView != nil && CGRectEqualToRect(parentView.frame, CGRectZero)) {
            parentView = parentView.superview;
        }
        [parentView setNeedsLayout];
        [parentView layoutIfNeeded];
    }
    //将contentScrollView的contentOffset定位到当前选中index的位置
    [self.contentScrollView setContentOffset:CGPointMake(self.selectedIndex*self.contentScrollView.bounds.size.width, 0) animated:self.contentScrollAnimated];
}
- (void)refreshSelectedCellModel:(CGXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(CGXCategoryBaseCellModel *)unselectedCellModel {
    selectedCellModel.selected = YES;
    unselectedCellModel.selected = NO;
    
    if (self.cellWidthZoomEnabled) {
        if (selectedCellModel.selectedType == CGXCategoryCellSelectedTypeClick || selectedCellModel.selectedType == CGXCategoryCellSelectedTypeNode) {
            selectedCellModel.transitionAnimating = YES;
            unselectedCellModel.transitionAnimating = YES;
            self.animator = [[CGXCategoryViewAnimator alloc] init];
            self.animator.duration = self.selectedAnimationDuration;
            __weak typeof(self) weakSelf = self;
            self.animator.progressCallback = ^(CGFloat percent) {
                selectedCellModel.transitionAnimating = NO;
                unselectedCellModel.transitionAnimating = NO;
                selectedCellModel.cellWidthCurrentZoomScale = [CGXCategoryFactory interpolationFrom:selectedCellModel.cellWidthNormalZoomScale to:selectedCellModel.cellWidthSelectedZoomScale percent:percent];
                selectedCellModel.cellWidth = [self getCellWidthAtIndex:selectedCellModel.index] * selectedCellModel.cellWidthCurrentZoomScale;
                unselectedCellModel.cellWidthCurrentZoomScale = [CGXCategoryFactory interpolationFrom:unselectedCellModel.cellWidthSelectedZoomScale to:unselectedCellModel.cellWidthNormalZoomScale percent:percent];
                unselectedCellModel.cellWidth = [self getCellWidthAtIndex:unselectedCellModel.index] * unselectedCellModel.cellWidthCurrentZoomScale;
                [weakSelf.collectionView.collectionViewLayout invalidateLayout];
            };
            [self.animator start];
        }else {
            selectedCellModel.cellWidthCurrentZoomScale = selectedCellModel.cellWidthSelectedZoomScale;
            selectedCellModel.cellWidth = [self getCellWidthAtIndex:selectedCellModel.index] * selectedCellModel.cellWidthCurrentZoomScale;
            unselectedCellModel.cellWidthCurrentZoomScale = unselectedCellModel.cellWidthNormalZoomScale;
            unselectedCellModel.cellWidth = [self getCellWidthAtIndex:unselectedCellModel.index] * unselectedCellModel.cellWidthCurrentZoomScale;
        }
    }
}
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    if (contentOffset.x == 0 && self.selectedIndex == 0 && self.lastContentViewContentOffset.x == 0) {
        //滚动到了最左边，且已经选中了第一个，且之前的contentOffset.x为0
        return;
    }
    CGFloat maxContentOffsetX = self.contentScrollView.contentSize.width - self.contentScrollView.bounds.size.width;
    if (contentOffset.x == maxContentOffsetX && self.selectedIndex == self.dataSource.count - 1 && self.lastContentViewContentOffset.x == maxContentOffsetX) {
        //滚动到了最右边，且已经选中了最后一个，且之前的contentOffset.x为maxContentOffsetX
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;
    
    if (remainderRatio == 0) {
        //快速滑动翻页，用户一直在拖拽contentScrollView，需要更新选中状态 //滑动一小段距离，然后放开回到原位，contentOffset同样的值会回调多次。例如在index为1的情况，滑动放开回到原位，contentOffset会多次回调CGPoint(width, 0)
        if (!(self.lastContentViewContentOffset.x == contentOffset.x && self.selectedIndex == baseIndex)) {
            if (self.selectedIndex != baseIndex) {
                [self scrollSelectItemAtIndex:baseIndex];
            }
        }
    }else {
        [self.animator stop];
        //快速滑动翻页，当remainderRatio没有变成0，但是已经翻页了，需要通过下面的判断，触发选中
        if (fabs(ratio - self.selectedIndex) > 1) {
            NSInteger targetIndex = baseIndex;
            if (ratio < self.selectedIndex) {
                targetIndex = baseIndex + 1;
            }
            [self scrollSelectItemAtIndex:targetIndex];
        }
        
        if (self.selectedIndex == baseIndex) {
            self.scrollingTargetIndex = baseIndex + 1;
        }else {
            self.scrollingTargetIndex = baseIndex;
        }
        
        if (self.cellWidthZoomEnabled && self.cellWidthZoomScrollGradientEnabled) {
            CGXCategoryBaseCellModel *leftCellModel = (CGXCategoryBaseCellModel *)self.dataSource[baseIndex];
            CGXCategoryBaseCellModel *rightCellModel = (CGXCategoryBaseCellModel *)self.dataSource[baseIndex + 1];
            leftCellModel.cellWidthCurrentZoomScale = [CGXCategoryFactory interpolationFrom:leftCellModel.cellWidthSelectedZoomScale to:leftCellModel.cellWidthNormalZoomScale percent:remainderRatio];
            leftCellModel.cellWidth = [self getCellWidthAtIndex:leftCellModel.index] * leftCellModel.cellWidthCurrentZoomScale;
            rightCellModel.cellWidthCurrentZoomScale = [CGXCategoryFactory interpolationFrom:rightCellModel.cellWidthNormalZoomScale to:rightCellModel.cellWidthSelectedZoomScale percent:remainderRatio];
            rightCellModel.cellWidth = [self getCellWidthAtIndex:rightCellModel.index] * rightCellModel.cellWidthCurrentZoomScale;
            [self.collectionView.collectionViewLayout invalidateLayout];
        }
        [self.listContainer scrollingFromLeftIndex:baseIndex toRightIndex:baseIndex + 1 ratio:remainderRatio selectedIndex:self.selectedIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:scrollingFromLeftIndex:toRightIndex:ratio:)]) {
            [self.delegate categoryView:self scrollingFromLeftIndex:baseIndex toRightIndex:baseIndex + 1 ratio:remainderRatio];
        }
    }
}
- (BOOL)selectCellAtIndex:(NSInteger)targetIndex selectedType:(CGXCategoryCellSelectedType)selectedType {
    if (targetIndex < 0 || targetIndex >= self.dataSource.count) {
        return NO;
    }
    self.needReloadByBecomeActive = NO;
    
    if (self.selectedIndex == targetIndex) {
        //目标index和当前选中的index相等，就不需要处理后续的选中更新逻辑，只需要回调代理方法即可。
        [self updateSelectCellAtIndex:targetIndex selectedType:selectedType];
        self.scrollingTargetIndex = -1;
        return NO;
    }
    
    //通知子类刷新当前选中的和将要选中的cellModel
    CGXCategoryBaseCellModel *lastCellModel = self.dataSource[self.selectedIndex];
    lastCellModel.selectedType = selectedType;
    CGXCategoryBaseCellModel *selectedCellModel = self.dataSource[targetIndex];
    selectedCellModel.selectedType = selectedType;
    
    [self refreshSelectedCellModel:selectedCellModel unselectedCellModel:lastCellModel];
    
    //刷新当前选中的和将要选中的cell
    CGXCategoryBaseCell *lastCell = (CGXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    [lastCell reloadData:lastCellModel];
    CGXCategoryBaseCell *selectedCell = (CGXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0]];
    [selectedCell reloadData:selectedCellModel];
    
    
    if (self.scrollingTargetIndex != -1 && self.scrollingTargetIndex != targetIndex) {
        CGXCategoryBaseCellModel *scrollingTargetCellModel = self.dataSource[self.scrollingTargetIndex];
        scrollingTargetCellModel.selected = NO;
        scrollingTargetCellModel.selectedType = selectedType;
        [self refreshSelectedCellModel:selectedCellModel unselectedCellModel:scrollingTargetCellModel];
        CGXCategoryBaseCell *scrollingTargetCell = (CGXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.scrollingTargetIndex inSection:0]];
        [scrollingTargetCell reloadData:scrollingTargetCellModel];
    }
    
    if (self.cellWidthZoomEnabled) {
        [self.collectionView.collectionViewLayout invalidateLayout];
        //延时为了解决cellwidth变化，点击最后几个cell，scrollToItem会出现位置偏移bu。需要等cellWidth动画渐变结束后再滚动到index的cell位置。
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.selectedAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        });
    }else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    if (selectedType == CGXCategoryCellSelectedTypeClick || selectedType == CGXCategoryCellSelectedTypeNode) {
        [self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:self.contentScrollAnimated];
    }
    self.selectedIndex = targetIndex;
    //代理事件回掉方法
    [self updateSelectCellAtIndex:targetIndex selectedType:selectedType];

    self.scrollingTargetIndex = -1;
    
    return YES;
}
- (void)updateSelectCellAtIndex:(NSInteger)targetIndex selectedType:(CGXCategoryCellSelectedType)selectedType
{
    if (selectedType == CGXCategoryCellSelectedTypeNode) {
        [self.listContainer didClickSelectedItemAtIndex:targetIndex];
    }else if (selectedType == CGXCategoryCellSelectedTypeClick) {
        [self.listContainer didClickSelectedItemAtIndex:targetIndex];
        if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:didClickSelectedItemAtIndex:)]) {
            [self.delegate categoryView:self didClickSelectedItemAtIndex:targetIndex];
        }
        CGXCategorViewDebugLog(@"点击选中--%ld" , (long)targetIndex);
    }else if(selectedType == CGXCategoryCellSelectedTypeScroll) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:didScrollSelectedItemAtIndex:)]) {
            [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
        }
        CGXCategorViewDebugLog(@"滚动选中--%ld" , (long)targetIndex);
    }else if (selectedType == CGXCategoryCellSelectedTypeUnknown) {
        [self.listContainer didClickSelectedItemAtIndex:targetIndex];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:didSelectedItemAtIndex:)]) {
        [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
        CGXCategorViewDebugLog(@"点击或者滚动选中--%ld" , (long)targetIndex);
    }
}
- (void)refreshCellModel:(CGXCategoryBaseCellModel *)cellModel index:(NSInteger)index
{
    
}
@end
