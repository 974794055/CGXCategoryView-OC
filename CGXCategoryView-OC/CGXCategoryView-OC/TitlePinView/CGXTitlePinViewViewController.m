//
//  CGXTitlePinViewViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/24.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXTitlePinViewViewController.h"

@interface CGXTitlePinViewViewController ()<CGXCategoryViewDelegate>

@property (nonatomic , strong) CGXCategoryTitlePinView *categoryView;
@property (nonatomic , strong) NSMutableArray *titleAry;
@property (nonatomic , assign)    NSInteger selectedIndex;
@end

@implementation CGXTitlePinViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.selectedIndex = 0;
    self.titleAry = [NSMutableArray arrayWithObjects:@"精选",@"俱乐部",@"电影",@"电视剧",@"综艺",@"动漫",@"儿童",@"演唱会",@"票务",@"美食",@"生活",@"商城",@"知识",nil];
    NSInteger interH = 60;
    self.categoryView = [[CGXCategoryTitlePinView alloc] init];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, interH);
    self.categoryView.cellSpacing = 5;
    self.categoryView.cellWidthIncrement = 10;
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleSelectedColor = [UIColor redColor];
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
    
    UIScrollView *mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, interH, ScreenWidth, kSafeVCHeight-interH)];
    mainScrollViewH.pagingEnabled = YES;
    mainScrollViewH.bounces = NO;
    mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    mainScrollViewH.showsHorizontalScrollIndicator = NO;
    mainScrollViewH.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollViewH];
    
    self.categoryView.contentScrollView = mainScrollViewH;
    
    mainScrollViewH.frame =CGRectMake(0, interH, ScreenWidth, kSafeVCHeight-interH);
    for (int i = 0; i<self.titleAry.count; i++) {
        CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(mainScrollViewH.frame), 0, CGRectGetWidth(mainScrollViewH.frame), CGRectGetHeight(mainScrollViewH.frame));
        [self addChildViewController:listVC];
        [mainScrollViewH addSubview:listVC.view];
        listVC.titleStr =  [[NSAttributedString alloc] initWithString:self.titleAry[i]];;
    }
    mainScrollViewH.contentSize = CGSizeMake(ScreenWidth * self.titleAry.count,CGRectGetHeight(mainScrollViewH.frame));
    
    self.categoryView.pinImage = [UIImage imageNamed:@"LocationBottom"];
    self.categoryView.titleArray = self.titleAry;
    [self.categoryView selectItemAtIndex:self.selectedIndex];
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didSelectedItemAtIndex:%ld---%ld",(long)categoryView.selectedIndex,(long)index);;
    
    [self.categoryView reloadData];
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didClickSelectedItemAtIndex:---%ld",(long)index);

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
