//
//  CGXCategoryTitleSubtitleViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleSubtitleViewController.h"

#import "CGXCategoryTitleSubtitleView.h"

@interface CGXTitleSubtitleViewController ()<CGXCategoryViewDelegate>
@property (nonatomic, strong) CGXCategoryTitleSubtitleView *myCategoryView1;
@property (nonatomic, strong) CGXCategoryTitleSubtitleView *myCategoryView2;
@property (nonatomic , strong) UIScrollView *scrollView;

@end


@implementation CGXTitleSubtitleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray <NSString *> *status = [@[@"已开抢", @"抢购中", @"即将开抢", @"抢购中", @"抢购完毕"] mutableCopy];
    NSMutableArray <NSString *> *times = [@[@"12:00", @"13:00", @"14:00", @"15:00", @"16:00"] mutableCopy];
    
    
    self.myCategoryView1 = [[CGXCategoryTitleSubtitleView alloc] init];
    self.myCategoryView1.delegate = self;
    self.myCategoryView1.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    [self.view addSubview:self.myCategoryView1];
    self.myCategoryView1.backgroundColor = [UIColor blackColor];
    self.myCategoryView1.titleArray = status;
    self.myCategoryView1.subTitleArray = times;
    
    self.myCategoryView1.titleLabelVerticalOffset = 0;
    self.myCategoryView1.subTitleSpace = -5;
    self.myCategoryView1.titleSpace = -5;
    self.myCategoryView1.titleColorGradientEnabled = YES;
    //设置底部状态
    self.myCategoryView1.titleColor = [UIColor lightGrayColor];
    self.myCategoryView1.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView1.titleFont = [UIFont systemFontOfSize:13];
    self.myCategoryView1.titleSelectedFont = [UIFont systemFontOfSize:15];
    //设置顶部时间
    self.myCategoryView1.subTitleFont = [UIFont boldSystemFontOfSize:10];
    self.myCategoryView1.subTitleSelectedFont = [UIFont boldSystemFontOfSize:10];
    self.myCategoryView1.subTitleNormalColor = [UIColor whiteColor];
    self.myCategoryView1.subTitleSelectedColor = [UIColor whiteColor];
    
    
    
    CGXCategoryIndicatorBackgroundView *backgroundView11 = [[CGXCategoryIndicatorBackgroundView alloc] init];
    backgroundView11.indicatorHeight = 15;
    backgroundView11.indicatorCornerRadius = 7.5;
    backgroundView11.indicatorWidthIncrement = 10;
    backgroundView11.verticalMargin = -15;
    backgroundView11.scrollEnabled = NO;
    backgroundView11.indicatorColor = [UIColor redColor];
    self.myCategoryView1.indicators = @[backgroundView11];
    
    NSMutableArray <NSString *> *statusTB = [@[@"猜你喜欢", @"疯狂抢购", @"网红推荐", @"低价抢购", @"进口好货"] mutableCopy];
    NSMutableArray <NSString *> *titleTB = [@[@"全部", @"购物节", @"直播", @"热门商品", @"精品课"] mutableCopy];
    self.myCategoryView2 = [[CGXCategoryTitleSubtitleView alloc] init];
    self.myCategoryView2.delegate = self;
    self.myCategoryView2.frame = CGRectMake(0, 50, self.view.bounds.size.width, 50);
    [self.view addSubview:self.myCategoryView2];
    self.myCategoryView2.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.myCategoryView2.titleArray = titleTB;
    self.myCategoryView2.subTitleArray = statusTB;
    self.myCategoryView2.titleLabelVerticalOffset = 0;
    self.myCategoryView2.subTitleSpace = -5;
    self.myCategoryView2.titleSpace = -5;
    //    self.myCategoryView2.titleColorGradientEnabled = YES;
    //设置底部状态
    self.myCategoryView2.titleColor = [UIColor blackColor];
    self.myCategoryView2.titleSelectedColor = [UIColor redColor];
    self.myCategoryView2.titleFont = [UIFont systemFontOfSize:10];
    self.myCategoryView2.titleFont = [UIFont systemFontOfSize:13];
    self.myCategoryView2.titleSelectedFont = [UIFont systemFontOfSize:15];
    //设置顶部时间
    self.myCategoryView2.subTitleFont = [UIFont boldSystemFontOfSize:10];
    self.myCategoryView2.subTitleSelectedFont = [UIFont boldSystemFontOfSize:10];
    self.myCategoryView2.subTitleNormalColor = [UIColor blackColor];
    self.myCategoryView2.subTitleSelectedColor = [UIColor whiteColor];
    
    CGXCategoryIndicatorBackgroundView *backgroundView22 = [[CGXCategoryIndicatorBackgroundView alloc] init];
    backgroundView22.indicatorHeight = 15;
    backgroundView22.indicatorCornerRadius = 7.5;
    backgroundView22.indicatorWidthIncrement = 20;
    backgroundView22.verticalMargin = -15;
    backgroundView22.scrollEnabled = NO;
    backgroundView22.indicatorColor = [UIColor redColor];
    self.myCategoryView2.indicators = @[backgroundView22];
    
    NSUInteger count = status.count;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myCategoryView2.frame), ScreenWidth, kSafeVCHeight-50-50)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame)*count, CGRectGetHeight(self.scrollView.frame));
    [self.view addSubview:self.scrollView];
    self.myCategoryView2.contentScrollView = self.scrollView;
    
    
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < count; i ++) {
        UIViewController *listVC = [[UIViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        listVC.view.backgroundColor = randomColor;
        [self.scrollView addSubview:listVC.view];
        CGXWaterCollectionView *waterView = [[CGXWaterCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        waterView.titleStr = @"";
        waterView.scrollViewBlock = ^(UIScrollView *scrollView) {
            CGFloat height = scrollView.contentOffset.y;
            NSLog(@"heightheight--%f",height);
        };
        [listVC.view addSubview:waterView];
    }
}

- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didSelectedItemAtIndex--%ld",(long)index);
    if (categoryView == self.myCategoryView2) {
        [self.myCategoryView1 selectItemAtIndex:index];
    }
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
    if (categoryView == self.myCategoryView2) {
        [self.myCategoryView1 selectItemAtIndex:index];
    }
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
