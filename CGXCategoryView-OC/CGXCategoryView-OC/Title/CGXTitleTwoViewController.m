//
//  CGXTitleTwoViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXTitleTwoViewController.h"
#import "CGXCategoryView.h"
@interface CGXTitleTwoViewController ()<CGXCategoryViewDelegate>

@property (nonatomic , strong) CGXCategoryTitleView *titleCategoryView;
@property (nonatomic , strong) NSMutableArray *titleAry;
@property (nonatomic , strong) UIImageView *bgSelectedImageView;
@property (nonatomic , strong) UIImageView *bgUnselectedImageView;

@end

@implementation CGXTitleTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.categorytitle;;
    self.titleAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.titleAry = [NSMutableArray arrayWithObjects:@"全部",@"推荐", @"直播", @"热门商品", @"精品课", @"生活", @"母婴",nil];

    NSInteger interH = 50;
    self.titleCategoryView = [[CGXCategoryTitleView alloc] init];
    self.titleCategoryView.backgroundColor = [UIColor whiteColor];
    self.titleCategoryView.frame = CGRectMake(0, 0, ScreenWidth, interH);
    self.titleCategoryView.delegate = self;
    self.titleCategoryView.titleArray = self.titleAry;
    [self.view addSubview:self.titleCategoryView];
    
    
    UIScrollView *mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, interH, ScreenWidth, kSafeVCHeight-interH)];
    mainScrollViewH.pagingEnabled = YES;
    mainScrollViewH.bounces = NO;
    mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    mainScrollViewH.showsHorizontalScrollIndicator = NO;
    mainScrollViewH.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollViewH];
    
    self.titleCategoryView.contentScrollView = mainScrollViewH;

    
    [self.titleCategoryView selectItemAtIndex:0];
    NSString *title = self.categorytitle;
    if ([title isEqualToString:@"DotLineView点线效果"]){
        
        self.titleCategoryView.titleColorGradientEnabled = YES;
        CGXCategoryIndicatorDotLineView *lineView = [[CGXCategoryIndicatorDotLineView alloc] init];
        self.titleCategoryView.indicators = @[lineView];
    } else if ([title isEqualToString:@"RainbowLineView彩虹效果"]){
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
                            [UIColor blueColor],];
        lineView.indicatorColors = colors;
        lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
        self.titleCategoryView.indicators = @[lineView];
    } else if ([title isEqualToString:@"BallView QQ小红点"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        CGXCategoryIndicatorBallView *ballView = [[CGXCategoryIndicatorBallView alloc] init];
        self.titleCategoryView.indicators = @[ballView];
    } else if ([title isEqualToString:@"TriangleView三角形"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        
        self.titleCategoryView.titleColorGradientEnabled = YES;
        CGXCategoryIndicatorTriangleView *triangleView = [[CGXCategoryIndicatorTriangleView alloc] init];
        self.titleCategoryView.indicators = @[triangleView];
    } else if ([title isEqualToString:@"ImageView底部"]){
        self.titleCategoryView.tag = 99999;
        self.titleCategoryView.titleColor = [UIColor whiteColor];
        self.titleCategoryView.titleSelectedColor = [UIColor redColor];
        self.titleCategoryView.titleColorGradientEnabled = YES;
        self.titleCategoryView.titleLabelZoomEnabled = YES;
        
        CGXCategoryIndicatorImageView *indicatorImageView = [[CGXCategoryIndicatorImageView alloc] init];
        indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"apple_select"];
        self.titleCategoryView.indicators = @[indicatorImageView];
        
        CGRect bgImageViewFrame = CGRectMake(0, 0, ScreenWidth, 100);
        UIImageView *bgSelectedImageView = [[UIImageView alloc] initWithFrame:bgImageViewFrame];
        bgSelectedImageView.contentMode = UIViewContentModeScaleAspectFill;
        bgSelectedImageView.image = [self getImageWithIndex:0];
        [self.titleCategoryView addSubview:bgSelectedImageView];
        
        UIImageView *bgUnselectedImageView = [[UIImageView alloc] initWithFrame:bgImageViewFrame];
        bgUnselectedImageView.contentMode = UIViewContentModeScaleAspectFill;
        bgUnselectedImageView.image = [self getImageWithIndex:1];
        [self.titleCategoryView addSubview:bgUnselectedImageView];
        
        [self.titleCategoryView sendSubviewToBack:bgSelectedImageView];
        [self.titleCategoryView sendSubviewToBack:bgUnselectedImageView];
        
        self.bgSelectedImageView = bgSelectedImageView;
        self.bgUnselectedImageView = bgUnselectedImageView;
        
        interH = 100;
        self.titleCategoryView.frame = CGRectMake(0, 0, ScreenWidth, interH);
        
    } else if ([title isEqualToString:@"ImageViewCell背景"]){
        CGXCategoryIndicatorImageView *indicatorImageView = [[CGXCategoryIndicatorImageView alloc] init];
        indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"LaunchScreen"];
        indicatorImageView.indicatorImageViewSize = CGSizeMake(50, 50);
        self.titleCategoryView.indicators = @[indicatorImageView];
    } else if ([title isEqualToString:@"ImageView足球滚动"]){
        CGXCategoryIndicatorImageView *indicatorImageView = [[CGXCategoryIndicatorImageView alloc] init];
        indicatorImageView.indicatorImageViewRollEnabled = YES;
        indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"football"];
        self.titleCategoryView.indicators = @[indicatorImageView];
    } else if ([title isEqualToString:@"混合使用"]){
        self.titleCategoryView.titleColorGradientEnabled = NO;
        self.titleCategoryView.titleLabelMaskEnabled = YES;
        CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
        CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorHeight = 20;
        self.titleCategoryView.indicators = @[backgroundView, lineView];
    } else if ([title isEqualToString:@"颜色渐变"]){
        CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
        self.titleCategoryView.indicators = @[lineView];
        self.titleCategoryView.titleColorGradientEnabled = YES;
    } else if ([title isEqualToString:@"大小缩放"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        self.titleCategoryView.titleLabelZoomEnabled = YES;
        self.titleCategoryView.titleLabelZoomScale = 1.3;
    } else if ([title isEqualToString:@"大小缩放+字体粗细"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        self.titleCategoryView.titleLabelZoomEnabled = YES;
        self.titleCategoryView.titleLabelZoomScale = 1.3;
        self.titleCategoryView.titleLabelStrokeWidthEnabled = YES;
    } else if ([title isEqualToString:@"大小缩放+点击动画"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        self.titleCategoryView.titleLabelZoomEnabled = YES;
        self.titleCategoryView.titleLabelZoomScale = 1.3;
        self.titleCategoryView.titleLabelStrokeWidthEnabled = YES;
        self.titleCategoryView.selectedAnimationEnabled = YES;
    } else if ([title isEqualToString:@"大小缩放+Cell宽度缩放"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        self.titleCategoryView.titleLabelZoomEnabled = YES;
        self.titleCategoryView.titleLabelZoomScale = 1.3;
        self.titleCategoryView.titleLabelStrokeWidthEnabled = YES;
        self.titleCategoryView.selectedAnimationEnabled = YES;
        self.titleCategoryView.cellWidthZoomEnabled = YES;
        self.titleCategoryView.cellWidthZoomScale = 1.3;
    }  else if ([title isEqualToString:@"Cell背景色渐变"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        self.titleCategoryView.cellBackgroundColorGradientEnabled = YES;
        self.titleCategoryView.cellSpacing = 0;
        self.titleCategoryView.cellWidthIncrement = 20;
    } else if ([title isEqualToString:@"分割线"]){
        CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
        self.titleCategoryView.indicators = @[lineView];
        self.titleCategoryView.separatorLineShowEnabled = YES;
    } else if ([title isEqualToString:@"大小缩放+底部锚点"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        self.titleCategoryView.titleLabelZoomEnabled = YES;
        self.titleCategoryView.titleLabelZoomScale = 1.5;
        self.titleCategoryView.cellWidthIncrement = 10;
        self.titleCategoryView.titleLabelAnchorPointStyle = CGXCategoryTitleLabelAnchorPointStyleBottom;
        //            titleCategoryView.titleLabelVerticalOffset = 5;
    } else if ([title isEqualToString:@"大小缩放+顶部锚点"]){
        self.titleCategoryView.titleColorGradientEnabled = YES;
        self.titleCategoryView.titleLabelZoomEnabled = YES;
        self.titleCategoryView.titleLabelZoomScale = 1.5;
        self.titleCategoryView.cellWidthIncrement = 10;
        self.titleCategoryView.titleLabelAnchorPointStyle = CGXCategoryTitleLabelAnchorPointStyleTop;
        //            titleCategoryView.titleLabelVerticalOffset = 5;
    } else if ([title isEqualToString:@"多行文本"]){
        //暂不支持自动换行，需要自行插入换行符\n
        self.titleCategoryView.titleNumberOfLines = 2;
        self.titleAry = [@[@"全部\n猜你喜欢", @"推荐\n热销产品",@"直播\n网红推荐", @"热门商品\n低价抢购", @"精品课\n进口好货", @"生活\n享受生活", @"母婴\n母婴大赏", @"时尚\n时尚好货"] mutableCopy];
        self.titleCategoryView.titleArray = self.titleAry;
    } else if ([title isEqualToString:@"背景边框"]){
        self.titleCategoryView.backgroundHeight = 30;
         self.titleCategoryView.cellWidthIncrement = 30;
        self.titleCategoryView.normalBackgroundColor = [UIColor whiteColor];
           self.titleCategoryView.normalBorderColor = [UIColor colorWithWhite:0.93 alpha:1];
           self.titleCategoryView.selectedBackgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
           self.titleCategoryView.selectedBorderColor = [UIColor colorWithWhite:0.93 alpha:1];
        self.titleCategoryView.backgroundCornerRadius = 15;
        self.titleCategoryView.cellSpacing = 10;
    }
    mainScrollViewH.frame =CGRectMake(0, interH, ScreenWidth, kSafeVCHeight-interH);
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
    
    [self.titleCategoryView selectItemAtIndex:2];

}


- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld---%ld",(long)categoryView.selectedIndex,(long)index);;
    if (categoryView.tag == 99999) {
        self.bgSelectedImageView.alpha = 1;
        self.bgUnselectedImageView.alpha = 0;
        self.bgSelectedImageView.image = [self getImageWithIndex:index];
    }
}



#pragma mark - CGXCategoryListContentViewDelegate
- (UIImage *)getImageWithIndex:(NSInteger)index {
    NSArray <UIImage *> *images = @[[UIImage imageNamed:@"IndicatorImage0"],
                                    [UIImage imageNamed:@"IndicatorImage1"],
                                    [UIImage imageNamed:@"IndicatorImage2"],
                                    [UIImage imageNamed:@"IndicatorImage3"],
                                    [UIImage imageNamed:@"IndicatorImage0"],
                                    [UIImage imageNamed:@"IndicatorImage1"],
                                    [UIImage imageNamed:@"IndicatorImage2"],
                                    [UIImage imageNamed:@"IndicatorImage3"],
                                    [UIImage imageNamed:@"IndicatorImage0"],
                                    [UIImage imageNamed:@"IndicatorImage1"],
                                    [UIImage imageNamed:@"IndicatorImage2"],
                                    [UIImage imageNamed:@"IndicatorImage3"]];
    return images[index];
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
