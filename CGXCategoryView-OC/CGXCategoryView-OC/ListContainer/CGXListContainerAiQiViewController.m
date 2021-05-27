//
//  CGXListContainerAiQiViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXListContainerAiQiViewController.h"

#import "CGXListContainerAiQiMoreViewController.h"

@interface CGXListContainerAiQiViewController () <CGXCategoryViewDelegate, CGXCategoryListContainerViewDataSource>
@property (nonatomic, strong) CGXCategoryTitleView *categoryView;
@property (nonatomic, strong) CGXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSMutableArray <NSString *> *titlesArr;
@property (nonatomic , assign) NSInteger currentInter;//当前选择的下标。 默认0

@property (nonatomic, strong) NSMutableDictionary <NSString *, id<CGXCategoryListContainerViewDelegate>> *listCache;

@end

@implementation CGXListContainerAiQiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.navigationController.navigationBar navBarMyLayerHeight:kTopHeight isOpaque:YES];//背景高度
    [self.navigationController.navigationBar navBarBackGroundColor:RGB(64, 75, 94, 1) image:nil isOpaque:YES];//颜色
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.currentInter = 0;
    self.titlesArr = [[NSMutableArray alloc] initWithObjects:@"VIP会员",@"体育会员",@"FUN会员", nil];

    self.categoryView = [[CGXCategoryTitleView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.isBottomHidden = YES;
    self.categoryView.titleSelectedColor = [UIColor redColor];
    self.categoryView.titleColor = [UIColor whiteColor];
    CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = 20;
    self.categoryView.indicators = @[lineView];
     self.categoryView.cellWidth = 70;
     self.categoryView.cellSpacing = 0;
    self.categoryView.frame = CGRectMake(0, 0, 210, 44);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.categoryView];
    
    self.listContainerView = [[CGXCategoryListContainerView alloc] initWithType:CGXCategoryListContainerType_CollectionView DataSource:self];
    [self.view addSubview:self.listContainerView];
    self.listContainerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight);
    self.listContainerView.backgroundColor =RGB(64, 75, 94, 1);
    self.categoryView.listContainer = self.listContainerView;
    
    //重载之后默认回到0，你也可以指定一个index
    self.categoryView.titleArray = self.titlesArr;
//    [self.categoryView selectItemAtIndex:self.currentInter];
    
}


- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    self.currentInter = index;
    NSLog(@"点击：%ld" ,(long)self.categoryView.selectedIndex);
    if (index == 0) {
        [self.navigationController.navigationBar navBarBackGroundColor:RGB(64, 75, 94, 1) image:nil isOpaque:YES];//颜色
    }
    if (index == 1) {
        [self.navigationController.navigationBar navBarBackGroundColor:RGB(40, 109, 113, 1) image:nil isOpaque:YES];//颜色
    }
    if (index == 2) {
        [self.navigationController.navigationBar navBarBackGroundColor:RGB(24, 175, 242, 1) image:nil isOpaque:YES];//颜色
    }
    //[self.navigationController.navigationBar navBarAlpha:0 isOpaque:YES];//透明度
    //[self.navigationController.navigationBar navBarBottomLineHidden:YES];//隐藏底线
}
#pragma mark - CGXCategoryListContainerViewDelegate

-(id<CGXCategoryListContainerViewDelegate>)listContainerView:(CGXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NSString *targetTitle = self.titlesArr[index];
    id<CGXCategoryListContainerViewDelegate> list = _listCache[targetTitle];
    if (list) {
        return list;
    }else {
        CGXListContainerAiQiMoreViewController *listVC = [[CGXListContainerAiQiMoreViewController alloc] init];
        if (index == 0) {
                 listVC.view.backgroundColor = RGB(64, 75, 94, 1);
             listVC.titlesArr = [[NSMutableArray alloc] initWithObjects:@"精选",@"俱乐部",@"电影",@"电视剧",@"综艺",@"动漫",@"儿童",@"演唱会",@"票务",@"美食",@"生活",@"商城",@"知识", nil];
        }
        if (index == 1) {
                   listVC.view.backgroundColor = RGB(40, 109, 113, 1);
             listVC.titlesArr = [[NSMutableArray alloc] initWithObjects:@"推荐",@"要闻",@"河北",@"财经", nil];;
            
        }
        if (index == 2) {
                    listVC.view.backgroundColor = RGB(24, 175, 242, 1);
             listVC.titlesArr = [[NSMutableArray alloc] initWithObjects:@"科技",@"军事",@"时尚",@"文化",@"教育", nil];;
        }
        listVC.naviController = self.navigationController;
        listVC.tagStr = self.titlesArr[index];
        [self addChildViewController:listVC];
        _listCache[targetTitle] = listVC;
        
        self.listContainerView.backgroundColor =listVC.view.backgroundColor;
        
        return listVC;
    }
}
- (NSInteger)numberOfListsInlistContainerView:(CGXCategoryListContainerView *)listContainerView {
    return self.titlesArr.count;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
