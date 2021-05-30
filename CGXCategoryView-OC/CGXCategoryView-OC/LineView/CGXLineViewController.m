//
//  CGXLineViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXLineViewController.h"

@interface CGXLineViewController ()<CGXCategoryViewDelegate>
{
    NSInteger selectinter;
    UIScrollView *mainScrollViewH;
}
@property (nonatomic , strong) NSMutableArray *titleAry;
@property (nonatomic , strong) UIImageView *bgSelectedImageView;
@property (nonatomic , strong) UIImageView *bgUnselectedImageView;

@end

@implementation CGXLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    selectinter = 0;
    
    
    
    self.titleAry = [NSMutableArray arrayWithObjects:@"精选",@"俱乐部",@"电影",@"电视剧",@"综艺",@"动漫",@"儿童",@"演唱会",@"票务",@"美食",@"生活",@"商城",@"知识",nil];
    
    
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:
                                  @"LineView固定长度",
                                  @"LineView与Cell同宽",
                                  @"LineView延长style",
                                  @"LineView延长+偏移style",
                                  @"点线效果",
                                  @"下划线彩虹效果",
                                  @"分割线",nil];
    NSInteger interH = 40;
    mainScrollViewH=[[UIScrollView alloc]init];
    mainScrollViewH.pagingEnabled = YES;
    mainScrollViewH.bounces = NO;
    mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    mainScrollViewH.showsHorizontalScrollIndicator = NO;
    mainScrollViewH.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollViewH];
    mainScrollViewH.frame =CGRectMake(0, (interH+5)*titleArray.count, ScreenWidth, ScreenHeight-(interH+5)*titleArray.count-kTopHeight-kSafeHeight);
    for (int i = 0; i<self.titleAry.count; i++) {
        CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(mainScrollViewH.frame), 0, CGRectGetWidth(mainScrollViewH.frame), CGRectGetHeight(mainScrollViewH.frame));
        [self addChildViewController:listVC];
        [mainScrollViewH addSubview:listVC.view];
        listVC.titleStr =  [[NSAttributedString alloc] initWithString:self.titleAry[i]];;
    }
    mainScrollViewH.contentSize = CGSizeMake(ScreenWidth * self.titleAry.count,CGRectGetHeight(mainScrollViewH.frame));
    

    for (int i = 0 ; i<titleArray.count; i++) {
        
        NSString *title = titleArray[i];
        CGXCategoryTitleView *titleCategoryView = [[CGXCategoryTitleView alloc] init];
        titleCategoryView.backgroundColor = [UIColor whiteColor];
        titleCategoryView.frame = CGRectMake(0, (interH+5)*i, ScreenWidth, interH);
        titleCategoryView.delegate = self;
        titleCategoryView.titleArray = self.titleAry;
        titleCategoryView.cellWidthIncrement  = 20;
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
        }else if ([title isEqualToString:@"点线效果"]){
            
            titleCategoryView.titleColorGradientEnabled = YES;
            CGXCategoryIndicatorDotLineView *lineView = [[CGXCategoryIndicatorDotLineView alloc] init];
            lineView.indicatorWidth = 6;
            lineView.indicatorHeight = 6;
            titleCategoryView.indicators = @[lineView];
        } else if ([title isEqualToString:@"下划线彩虹效果"]){
            CGXCategoryIndicatorRainbowLineView *lineView = [[CGXCategoryIndicatorRainbowLineView alloc] init];
            NSArray *colors = @[[UIColor redColor],
                                [UIColor yellowColor],
                                [UIColor blueColor],
                                [UIColor orangeColor],
                                [UIColor purpleColor],
                                [UIColor cyanColor],
                                [UIColor magentaColor],
                                [UIColor grayColor],
                                [UIColor redColor],
                                [UIColor yellowColor],
                                [UIColor blueColor],
                                [UIColor magentaColor],
                                [UIColor grayColor],];
            lineView.indicatorColors = colors;
            lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
            titleCategoryView.indicators = @[lineView];
        } else if ([title isEqualToString:@"分割线"]){
            CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
            titleCategoryView.separatorLineShowEnabled = YES;
            titleCategoryView.separatorLineSize = CGSizeMake(1, 20);
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
