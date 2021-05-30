//
//  LoadDataListContainerViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXDataListContainerViewController.h"

@interface CGXDataListContainerViewController () <CGXCategoryViewDelegate, CGXCategoryListContainerViewDataSource>
@property (nonatomic, strong) CGXCategoryTitleView *categoryView;
@property (nonatomic, strong) CGXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSMutableArray <NSString *> *titlesArr;
@property (nonatomic , assign) NSInteger currentInter;//当前选择的下标。 默认0

@property (nonatomic, strong) NSMutableDictionary <NSString *, id<CGXCategoryListContainerViewDelegate>> *listCache;

@end

@implementation CGXDataListContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.currentInter = 3;
    NSMutableArray *titleA = [[NSMutableArray alloc] initWithObjects:@"推荐",@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫", nil];
    self.titlesArr = titleA;
    
    self.categoryView = [[CGXCategoryTitleView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.averageCellSpacingEnabled = NO;
    CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[CGXCategoryListContainerView alloc] initWithType:CGXCategoryListContainerType_CollectionView DataSource:self];
    [self.view addSubview:self.listContainerView];
    

    
    self.categoryView.listContainer = self.listContainerView;
    
    self.categoryView.titleArray = self.titlesArr;
    [self.categoryView reloadData];
//    [self.categoryView selectItemAtIndex:0];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"重新排序" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)rightItemClicked
{
    NSString *currentTitle = self.titlesArr[self.categoryView.selectedIndex];
    NSMutableArray *tempTitles = [self getRandomArrFrome:self.titlesArr];
    self.titlesArr = tempTitles;
    self.categoryView.titleArray = self.titlesArr;
    [self.categoryView reloadData];
    
    [self.categoryView selectItemAtIndex:[self.titlesArr indexOfObject:currentTitle]];
}
-(NSMutableArray*)getRandomArrFrome:(NSArray*)arr
{
    NSMutableArray *newArr = [NSMutableArray new];
    while (newArr.count != arr.count) {
        //生成随机数
        int x =arc4random() % arr.count;
        id obj = arr[x];
        if (![newArr containsObject:obj]) {
            [newArr addObject:obj];
        }
    }
    return newArr;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    self.listContainerView.frame = CGRectMake(0, 50, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight-50);
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
        return list;
    }else {
        CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
        listVC.titleStr = [[NSAttributedString alloc] initWithString:self.titlesArr[index]];
        [self addChildViewController:listVC];
        _listCache[targetTitle] = listVC;
        return listVC;
    }
}
- (NSInteger)numberOfListsInlistContainerView:(CGXCategoryListContainerView *)listContainerView {
    return self.titlesArr.count;
}

@end
