//
//  CGXCategorySegmentedTitleView.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXCategorySegmentedTitleView.h"


@interface CGXCategorySegmentedTitleView()<UIScrollViewDelegate>


// 外界绑定滚回的视图  设置属性用
@property (nonatomic , strong) UISegmentedControl *segmented;

@property (nonatomic , strong,readwrite) NSMutableArray<NSString *> *titleArr;
@property (nonatomic, assign) CGPoint lastContentViewContentOffset;
// 正在滚动中的目标index。用于处理正在滚动列表的时候，立即点击item，会导致界面显示异常。
@property (nonatomic, assign) NSInteger scrollingTargetIndex;

@end

@implementation CGXCategorySegmentedTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializeView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.segmented.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) ,CGRectGetHeight(self.bounds));
    self.segmented.selectedSegmentIndex = self.selectedIndex;
    self.segmented.tintColor = self.tintColor;
    if (@available(iOS 13.0, *)) {
        self.segmented.selectedSegmentTintColor = self.tintColor;
    } else {
        // Fallback on earlier versions
    }
    // 设置背景图
    if (self.bgNormalImage) {
        [self.segmented setBackgroundImage:self.bgNormalImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    if (self.bgSelectImage) {
        [self.segmented setBackgroundImage:self.bgSelectImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self.segmented setBackgroundImage:self.bgSelectImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    } else{
        [self.segmented setBackgroundImage:self.bgNormalImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self.segmented setBackgroundImage:self.bgNormalImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
    // 设置分割线图
    if (self.dividerNormalImage) {
        [self.segmented setDividerImage:self.dividerNormalImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    if (self.dividerSelectImage) {
        [self.segmented setDividerImage:self.dividerSelectImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self.segmented setDividerImage:self.dividerSelectImage forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    } else{
        
        if (self.dividerNormalImage) {
            [self.segmented setDividerImage:self.dividerNormalImage forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
            [self.segmented setDividerImage:self.dividerNormalImage forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        }
    }
    
    if (@available(iOS 13, *)) {
        UIColor *tintColor = [self tintColor];
        UIImage *tintColorImage = [self imageWithColor:tintColor];
        // Must set the background image for normal to something (even clear) else the rest won't work
        [self.segmented setBackgroundImage:[self imageWithColor:self.backgroundColor ? self.backgroundColor : [UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.segmented setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self.segmented setBackgroundImage:[self imageWithColor:[tintColor colorWithAlphaComponent:0.2]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [self.segmented setBackgroundImage:tintColorImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor, NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
        [self.segmented setDividerImage:tintColorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        self.segmented.layer.borderWidth = 1;
        self.segmented.layer.borderColor = [tintColor CGColor];

    }
    
//    // 设置文字样式
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleNormalColor} forState:UIControlStateNormal]; //正常
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleSelectColor} forState:UIControlStateHighlighted]; //按下
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleSelectColor} forState:UIControlStateSelected]; //选中
}
- (void)initializeView
{
    self.selectedIndex = 0;
    self.titleArr = [NSMutableArray array];
    self.titleNormalColor = [UIColor blackColor];
       self.titleSelectColor = [UIColor whiteColor];
       self.tintColor = [UIColor orangeColor];
    
    self.segmented = [[UISegmentedControl alloc] initWithItems:@[]];
    self.segmented.momentary = NO;
   
    self.segmented.apportionsSegmentWidthsByContent = YES;
    self.segmented.backgroundColor = self.backgroundColor;
    self.segmented.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) ,CGRectGetHeight(self.bounds));
    [self.segmented addTarget:self action:@selector(actionValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmented.selectedSegmentIndex = self.selectedIndex;
    self.segmented.tintColor = self.tintColor;
    // 设置文字样式
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleNormalColor} forState:UIControlStateNormal]; //正常
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleSelectColor} forState:UIControlStateHighlighted]; //按下
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:self.titleSelectColor} forState:UIControlStateSelected]; //选中
    [self addSubview:self.segmented];
    
}
- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    self.segmented.tintColor = tintColor;
    if (@available(iOS 13.0, *)) {
        self.segmented.selectedSegmentTintColor = tintColor;
    } else {
        // Fallback on earlier versions
    }
}
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    self.segmented.selectedSegmentIndex = selectedIndex;
}
- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:titleNormalColor} forState:UIControlStateNormal]; //正常
}
- (void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    _titleSelectColor = titleSelectColor;
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:titleSelectColor} forState:UIControlStateHighlighted]; //按下
    [self.segmented setTitleTextAttributes:@{NSForegroundColorAttributeName:titleSelectColor} forState:UIControlStateSelected]; //选中
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
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > [self.segmented numberOfSegments] - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    if (contentOffset.x == 0 && self.selectedIndex == 0 && self.lastContentViewContentOffset.x == 0) {
        //滚动到了最左边，且已经选中了第一个，且之前的contentOffset.x为0
        return;
    }
    CGFloat maxContentOffsetX = self.contentScrollView.contentSize.width - self.contentScrollView.bounds.size.width;
    if (contentOffset.x == maxContentOffsetX && self.selectedIndex == [self.segmented numberOfSegments]-1 && self.lastContentViewContentOffset.x == maxContentOffsetX) {
        //滚动到了最右边，且已经选中了最后一个，且之前的contentOffset.x为maxContentOffsetX
        return;
    }
    ratio = MAX(0, MIN([self.segmented numberOfSegments] - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;
    
    if (remainderRatio == 0) {
        if (!(self.lastContentViewContentOffset.x == contentOffset.x && self.selectedIndex == baseIndex)) {
            if (self.selectedIndex != baseIndex) {
                [self selectSegmentAtIndex:baseIndex];
            }
        }
    }else {
        if (fabs(ratio - self.selectedIndex) > 1) {
            NSInteger targetIndex = baseIndex;
            if (ratio < self.selectedIndex) {
                targetIndex = baseIndex + 1;
            }
            [self selectSegmentAtIndex:baseIndex];
        }
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

- (void)updateWithTitleArray:(NSMutableArray<NSString *> *)titleArr
{
    [self.titleArr removeAllObjects];
    [self.titleArr addObjectsFromArray:titleArr];
    for (int i = 0; i<titleArr.count; i++) {
        NSString *str = titleArr[i];
        [self.segmented insertSegmentWithTitle:str atIndex:i animated:NO];
    }
    [self selectSegmentAtIndex:self.selectedIndex];
}
//选中一个分段 默认0
- (void)selectSegmentAtIndex:(NSInteger)inder
{
    if (inder>[self.segmented numberOfSegments]-1) {
        return;
    }
    self.selectedIndex = inder;
    self.segmented.selectedSegmentIndex = self.selectedIndex;
//    if (self.selectedIndex != inder) {
        if (self.selectBlock) {
            self.selectBlock(self.titleArr,self.segmented.selectedSegmentIndex);
        }
        if (self.contentScrollView) {
            self.selectedIndex = self.segmented.selectedSegmentIndex;
            [self.contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.contentScrollView.frame)*self.segmented.selectedSegmentIndex, 0) animated:NO];
        }
//    }

}
//移除一个分段(根据下标)
- (void)removeSegmentAtIndex:(NSInteger)inder
{
    if (inder>[self.segmented numberOfSegments]-1) {
        return;
    }
    NSString *str = self.titleArr[inder];
    [self.titleArr removeObject:str];
    [self.segmented removeSegmentAtIndex:inder animated:YES];
}
//根据下标修改分段标题
- (void)editSegmentAtIndex:(NSInteger)inder Title:(NSString *)title
{
    if (inder>[self.segmented numberOfSegments]-1) {
        return;
    }
    if ([self isEmpty:title]) {
        return;
    }
    [self.titleArr replaceObjectAtIndex:inder withObject:title];
    [self.segmented setTitle:title forSegmentAtIndex:inder];
}
//插入文字
- (void)insertSegmentAtIndex:(NSInteger)inder Title:(NSString *)title
{
   
    if (inder>[self.segmented numberOfSegments]-1) {
        return;
    }
    [self.titleArr insertObject:title atIndex:inder];
    [self.segmented insertSegmentWithTitle:title atIndex:inder animated:YES];
}

// 设置指定索引选项的宽度
- (void)editWidthSegmentAtIndex:(NSInteger)inder Width:(CGFloat)width
{
    if (inder> [self.segmented numberOfSegments]-1) {
        return;
    }
    [self.segmented setWidth:width forSegmentAtIndex:inder];
}
//设置segment是否可用
- (void)setEnabledSegmentAtIndex:(NSInteger)inder
{
    if (inder> [self.segmented numberOfSegments]-1) {
        return;
    }
    [self.segmented setEnabled:NO forSegmentAtIndex:inder];
}
//移出所有segment
- (void)removeAllSegments
{
    [self.titleArr removeAllObjects];
    [self.segmented removeAllSegments];
}
- (BOOL)isEmpty:(NSString *)title
{
    if (title == nil || title == NULL){
        return YES;
    }
    if ([title isKindOfClass:[NSNull class]]){
        return YES;
    }
    if ([title isEqual:[NSNull class]]){
        return YES;
    }
    if ([title isEqual:@""]){
        return YES;
    }
    if ([title isEqual:@"(null)"]){
        return YES;
    }
    
    if ([[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}

- (void)actionValueChanged:(UISegmentedControl *)seg
{
    if (self.selectBlock) {
        self.selectBlock(self.titleArr,seg.selectedSegmentIndex);
    }
    if (self.contentScrollView) {
        self.selectedIndex = seg.selectedSegmentIndex;
        [self.contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.contentScrollView.frame)*seg.selectedSegmentIndex, 0) animated:NO];
    }
}

- (void)dealloc
{
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (UIImage *)imageWithColor: (UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
