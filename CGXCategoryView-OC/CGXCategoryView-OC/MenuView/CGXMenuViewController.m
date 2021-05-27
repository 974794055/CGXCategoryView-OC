//
//  MyTitleViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXMenuViewController.h"
#import "CGXMenuListViewController.h"
#import "CGXCategoryView.h"
@interface CGXMenuViewController ()<CGXCategoryTitleMenuVCDelegate>
@property (nonatomic , strong) CGXCategoryTitleMenuView *menuView;

@end

@implementation CGXMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"菜单嵌套设置";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.menuView = [[CGXCategoryTitleMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kSafeVCHeight)];
    self.menuView.delegate=self;
    self.menuView.backgroundColor = [UIColor orangeColor];
    self.menuView.categoryViewHeight = 60;
    self.menuView.imageSize = CGSizeMake(20, 20);
    self.menuView.titleImageSpacing = 5;
    self.menuView.imageZoomScale = 1.5;
    self.menuView.contentScrollAnimated = NO;
    self.menuView.cellBackgroundNormalColor = [UIColor clearColor];
    self.menuView.cellBackgroundSelectedColor = [UIColor clearColor];
    self.menuView.titleNormalColor = [UIColor blackColor];
    self.menuView.titleSelectedColor = [UIColor redColor];
    self.menuView.titleFont = [UIFont systemFontOfSize:14];
    self.menuView.titleSelectedFont = [UIFont systemFontOfSize:14];
    self.menuView.titleLabelZoomScale = 1.0;
//    self.menuView.topLineHeight = 1;
//    self.menuView.topLineColor = [UIColor grayColor];
    self.menuView.bottomLineHeight = 2;
    self.menuView.bottomLineColor = [UIColor grayColor];
    CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
    self.menuView.indicators = @[lineView];
    [self.view addSubview:self.menuView];
    
    NSMutableArray *titleArr= [NSMutableArray arrayWithObjects:@"全部",@"推荐",@"美食",@"新闻",
                               @"视频",@"美食",@"新闻",@"搜索",@"热门",
                               nil];
    NSMutableArray *dataArr= [NSMutableArray array];
    for (int i = 0; i<titleArr.count; i++) {
        CGXCategoryTitleMenuModel *model = [[CGXCategoryTitleMenuModel alloc] init];
        CGXMenuListViewController *listVC = [[CGXMenuListViewController alloc] init];
        listVC.tagStr = titleArr[i];
        model.vcName = listVC;
        model.title = titleArr[i];
        model.imageName = @"apple_Noselect";
        model.selectedImageName = @"apple_select";
        model.imageURL = [NSURL URLWithString:@""];
        model.selectedImageURL = [NSURL URLWithString:@""];
        model.imageType = CGXCategoryTitleImageType_TopImage;
        model.loadImageCallback = ^(UIImageView * _Nonnull imageView, NSURL * _Nonnull imageURL) {
            
        };
        [dataArr addObject:model];
    }
    [self.menuView updateWithDataArray:dataArr];
}

- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{

}
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
   
}
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    
}
/**
 正在滚动中的回调   此处用于处理滑动时 导航条等变化的状况
 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 从左往右计算的百分比
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex
            toRightIndex:(NSInteger)rightIndex
                   ratio:(CGFloat)ratio
{
    
}
/**
 可选实现，列表消失的时候调用
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView
        ListDidDisappear:(NSInteger)index
{
    
}
/**

 可选实现，列表显示的时候调用
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView
      ListDidAppearIndex:(NSInteger)index
{
    
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
