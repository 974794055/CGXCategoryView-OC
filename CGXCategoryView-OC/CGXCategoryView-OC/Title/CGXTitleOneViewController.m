//
//  CGXTitleOneViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleOneViewController.h"
#import "CGXCategoryView.h"
@interface CGXTitleOneViewController ()<CGXCategoryViewDelegate>
{
    NSInteger selectinter;
    UIScrollView *mainScrollViewH;
}
@property (nonatomic , strong) NSMutableArray *titleAry;
@property (nonatomic , strong) UIImageView *bgSelectedImageView;
@property (nonatomic , strong) UIImageView *bgUnselectedImageView;

@end

@implementation CGXTitleOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.categorytitle;;
    self.titleAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    selectinter = 0;
    
    
    
    self.titleAry = [NSMutableArray arrayWithObjects:@"全部",@"推荐", @"直播", @"热门商品", @"精品课", @"生活", @"新鲜水果" @"时尚",nil];
    
    
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:
                                  @"LineView固定长度",
                                  @"LineView与Cell同宽",
                                  @"LineView延长style",
                                  @"LineView延长+偏移style",nil];
    NSInteger interH = 50;
    CGFloat sssss = (ScreenHeight-kTopHeight-kSafeHeight- interH*4-40)/4.0;
    
    mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, (interH+10)*4, ScreenWidth, sssss)];
    mainScrollViewH.pagingEnabled = YES;
    mainScrollViewH.bounces = NO;
    mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    mainScrollViewH.showsHorizontalScrollIndicator = NO;
    mainScrollViewH.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollViewH];
    mainScrollViewH.frame =CGRectMake(0, (interH+10)*titleArray.count, ScreenWidth, ScreenHeight-(interH+10)*titleArray.count-kTopHeight-kSafeHeight);
    for (int i = 0; i<self.titleAry.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = randomColor;
        vc.view.frame = CGRectMake(CGRectGetWidth(mainScrollViewH.frame)*i, 0, CGRectGetWidth(mainScrollViewH.frame), CGRectGetHeight(mainScrollViewH.frame));
        [self addChildViewController:vc];
        CGXWaterCollectionView *waterView = [[CGXWaterCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(mainScrollViewH.frame), CGRectGetHeight(mainScrollViewH.frame))];
        
        waterView.titleStr = @"";
        [vc.view addSubview:waterView];
        [mainScrollViewH addSubview:vc.view];
    }
    mainScrollViewH.contentSize = CGSizeMake(ScreenWidth * self.titleAry.count,CGRectGetHeight(mainScrollViewH.frame));
    
    for (int i = 0 ; i<titleArray.count; i++) {
        
        NSString *title = titleArray[i];
        CGXCategoryTitleView *titleCategoryView = [[CGXCategoryTitleView alloc] init];
        titleCategoryView.backgroundColor = [UIColor whiteColor];
        titleCategoryView.frame = CGRectMake(0, interH*i +10*i, ScreenWidth, interH);
        titleCategoryView.delegate = self;
        titleCategoryView.titleArray = self.titleAry;
        titleCategoryView.tag = 100+i;
        [self.view addSubview:titleCategoryView];
        
        if ([title isEqualToString:@"LineView固定长度"]) {
            titleCategoryView.titleColorGradientEnabled = YES;
            CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
            lineView.indicatorWidth = 10;
            titleCategoryView.indicators = @[lineView];
        } else if ([title isEqualToString:@"LineView与Cell同宽"]){
            titleCategoryView.titleColorGradientEnabled = YES;
            CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
            lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
            titleCategoryView.indicators = @[lineView];
        } else if ([title isEqualToString:@"LineView延长style"]){
            titleCategoryView.titleColorGradientEnabled = YES;
            CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
            lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
            lineView.lineStyle = CGXCategoryIndicatorLineStyle_JD;
            titleCategoryView.indicators = @[lineView];
        } else if ([title isEqualToString:@"LineView延长+偏移style"]){
            titleCategoryView.titleColorGradientEnabled = YES;
            CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
            lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
            lineView.lineStyle = CGXCategoryIndicatorLineStyle_IQIYI;
            titleCategoryView.indicators = @[lineView];
        }
        titleCategoryView.contentScrollView = mainScrollViewH;
        [titleCategoryView selectItemAtIndex:0];
    }
    
    
    
}


- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld---%ld",(long)categoryView.selectedIndex,(long)index);
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
