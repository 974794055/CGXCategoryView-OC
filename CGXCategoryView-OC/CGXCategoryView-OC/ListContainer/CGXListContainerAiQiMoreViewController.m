//
//  CGXListContainerAiQiMoreViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXListContainerAiQiMoreViewController.h"

#import "CGXListContainerAiQiListViewController.h"

@interface CGXListContainerAiQiMoreViewController ()<CGXCategoryViewDelegate, CGXCategoryListContainerViewDataSource>
@property (nonatomic, strong) CGXCategoryTitleView *categoryView;
@property (nonatomic, strong) CGXCategoryListContainerView *listContainerView;

@property (nonatomic , assign) NSInteger currentInter;//当前选择的下标。 默认0

@property (nonatomic, strong) NSMutableDictionary <NSString *, id<CGXCategoryListContainerViewDelegate>> *listCache;

@end

@implementation CGXListContainerAiQiMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.currentInter = 0;
    self.titlesArr = [NSMutableArray array];
    self.categoryView = [[CGXCategoryTitleView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor redColor];
    self.categoryView.titleColor = [UIColor whiteColor];
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    
    self.listContainerView = [[CGXCategoryListContainerView alloc] initWithType:CGXCategoryListContainerType_CollectionView DataSource:self];
    [self.view addSubview:self.listContainerView];
    self.listContainerView.frame = CGRectMake(0, 50, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight-50);
    self.categoryView.listContainer = self.listContainerView;
}
- (void)setTitlesArr:(NSMutableArray<NSString *> *)titlesArr
{
    _titlesArr = titlesArr;
    //重载之后默认回到0，你也可以指定一个index
    self.categoryView.titleArray = self.titlesArr;
    [self.categoryView reloadData];

}
#pragma mark - CGXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}
/**
 可选实现，列表将要显示的时候调用
 */
- (void)listWillAppearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.tagStr,(long)index);
}
/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.tagStr,(long)index);
}
/**
 可选实现，列表将要消失的时候调用
 */
- (void)listWillDisappearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.tagStr,(long)index);
}
/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.tagStr,(long)index);
}

#pragma mark - CGXCategoryViewDelegate

- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    self.currentInter = index;
    NSLog(@"点击：%ld" ,(long)self.categoryView.selectedIndex);
}
#pragma mark - CGXCategoryListContainerViewDelegate

-(id<CGXCategoryListContainerViewDelegate>)listContainerView:(CGXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NSString *targetTitle = self.titlesArr[index];
    id<CGXCategoryListContainerViewDelegate> list = _listCache[targetTitle];
    if (list) {
        //②之前已经初始化了对应的list，就直接返回缓存的list，无需再次初始化
        return list;
    }else {
        CGXListContainerAiQiListViewController *listVC = [[CGXListContainerAiQiListViewController alloc] init];
        listVC.view.backgroundColor = randomColor;
        listVC.naviController = self.navigationController;
        listVC.tagStr = [NSString stringWithFormat:@"%@\n%@",self.tagStr,self.titlesArr[index]];
        [self addChildViewController:listVC];
        _listCache[targetTitle] = listVC;
        return listVC;
    }
}
- (NSInteger)numberOfListsInlistContainerView:(CGXCategoryListContainerView *)listContainerView {
    return self.titlesArr.count;
}
@end
