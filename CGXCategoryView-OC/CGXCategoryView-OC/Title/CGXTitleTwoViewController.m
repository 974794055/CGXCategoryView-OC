//
//  CGXTitleTwoViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXTitleTwoViewController.h"

@interface CGXTitleTwoViewController ()<CGXCategoryViewDelegate>

@property (nonatomic , strong) CGXCategoryTitleView *categoryView;
@property (nonatomic , strong) NSMutableArray *titleAry;


@end

@implementation CGXTitleTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.categorytitle;;
    self.titleAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.titleAry = arc4random() % 2 == 0 ? [NSMutableArray arrayWithObjects:@"精选",@"俱乐部",@"电影",@"电视剧",@"综艺",@"动漫",@"儿童",@"演唱会",@"票务",@"美食",@"生活",@"商城",@"知识",nil]:[NSMutableArray arrayWithObjects:@"全部",@"推荐",nil];;
    NSInteger interH = 60;
    self.categoryView = [[CGXCategoryTitleView alloc] init];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, interH);
    self.categoryView.cellSpacing = 20;
    self.categoryView.cellWidthIncrement = 20;
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleSelectedColor = [UIColor redColor];
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
    self.categoryView.cellWidthZenter = self.titleAry.count == 2 ? YES:NO;
    
    NSString *title = self.categorytitle;
    if ([title isEqualToString:@"颜色渐变"]){
        CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
        self.categoryView.indicators = @[lineView];
        self.categoryView.titleColorGradientEnabled = YES;
    }  else if ([title isEqualToString:@"Cell背景色渐变"]){
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.cellBackgroundColorGradientEnabled = YES;
        self.categoryView.cellSpacing = 0;
        self.categoryView.cellWidthIncrement = 20;
    } else if ([title isEqualToString:@"分割线"]){
        CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
        self.categoryView.indicators = @[lineView];
        self.categoryView.separatorLineShowEnabled = YES;
    } else if ([title isEqualToString:@"多行文本"]){
        self.categoryView.titleNumberOfLines = 2;
        self.titleAry = [@[@"全部\n猜你喜欢", @"推荐\n热销产品",@"直播\n网红推荐", @"热门商品\n低价抢购", @"精品课\n进口好货", @"生活\n享受生活", @"母婴\n母婴大赏", @"时尚\n时尚好货"] mutableCopy];
        self.categoryView.titleArray = self.titleAry;
        CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
        self.categoryView.indicators = @[lineView];
    } else if ([title isEqualToString:@"背景边框"]){
        self.categoryView.backgroundHeight = 30;
        self.categoryView.cellWidthIncrement = 30;
        self.categoryView.normalBackgroundColor = [UIColor whiteColor];
        self.categoryView.normalBorderColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.categoryView.selectedBackgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.categoryView.selectedBorderColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.categoryView.backgroundCornerRadius = 15;
        self.categoryView.cellSpacing = 10;
    } else if ([title isEqualToString:@"大小缩放"]){
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        self.categoryView.cellWidthIncrement = 10;
        self.categoryView.titleLabelZoomScale = 1.5;
    }  else if ([title isEqualToString:@"大小缩放+底部锚点"]){
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        self.categoryView.cellWidthIncrement = 10;
        self.categoryView.titleLabelZoomScale = 1.5;
        self.categoryView.cellWidthIncrement = 10;
        self.categoryView.titleLabelAnchorPointStyle = CGXCategoryTitleLabelAnchorPointStyleBottom;
        self.categoryView.titleLabelVerticalOffset = 5;
    } else if ([title isEqualToString:@"大小缩放+顶部锚点"]){
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        self.categoryView.cellWidthIncrement = 10;
        self.categoryView.titleLabelZoomScale = 1.5;
        self.categoryView.cellWidthIncrement = 10;
        self.categoryView.titleLabelAnchorPointStyle = CGXCategoryTitleLabelAnchorPointStyleTop;
        self.categoryView.titleLabelVerticalOffset = 5;
    }else if ([title isEqualToString:@"大小缩放+字体粗细"]){
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        self.categoryView.cellWidthIncrement = 10;
        self.categoryView.titleLabelZoomScale = 1.5;
        self.categoryView.titleLabelStrokeWidthEnabled = YES;
    } else if ([title isEqualToString:@"大小缩放+点击动画"]){
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        self.categoryView.cellWidthIncrement = 10;
        self.categoryView.titleLabelZoomScale = 1.5;
        self.categoryView.titleLabelStrokeWidthEnabled = YES;
        self.categoryView.selectedAnimationEnabled = YES;
    } else if ([title isEqualToString:@"大小缩放+Cell宽度缩放"]){
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        self.categoryView.cellWidthIncrement = 10;
        self.categoryView.titleLabelZoomScale = 1.5;
        self.categoryView.titleLabelStrokeWidthEnabled = YES;
        self.categoryView.selectedAnimationEnabled = YES;
        self.categoryView.cellWidthZoomEnabled = YES;
        self.categoryView.cellWidthZoomScale = 1.3;
    }
    UIScrollView *mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, interH, ScreenWidth, kSafeVCHeight-interH)];
    mainScrollViewH.pagingEnabled = YES;
    mainScrollViewH.bounces = NO;
    mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    mainScrollViewH.showsHorizontalScrollIndicator = NO;
    mainScrollViewH.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollViewH];
    mainScrollViewH.frame =CGRectMake(0, interH, ScreenWidth, kSafeVCHeight-interH);
    for (int i = 0; i<self.titleAry.count; i++) {
        CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(mainScrollViewH.frame), 0, CGRectGetWidth(mainScrollViewH.frame), CGRectGetHeight(mainScrollViewH.frame));
        [self addChildViewController:listVC];
        [mainScrollViewH addSubview:listVC.view];
        listVC.titleStr = [[NSAttributedString alloc] initWithString:self.titleAry[i]];;;
    }
    mainScrollViewH.contentSize = CGSizeMake(ScreenWidth * self.titleAry.count,CGRectGetHeight(mainScrollViewH.frame));
    self.categoryView.contentScrollView = mainScrollViewH;
    self.categoryView.titleArray = self.titleAry;
    [self.categoryView selectItemAtIndex:0];
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didSelectedItemAtIndex:%ld---%ld",(long)categoryView.selectedIndex,(long)index);;
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didClickSelectedItemAtIndex:%ld---%ld",(long)categoryView.selectedIndex,(long)index);;
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
