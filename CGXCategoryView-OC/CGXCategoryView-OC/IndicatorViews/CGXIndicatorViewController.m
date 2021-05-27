//
//  CGXIndicatorViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/23.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXIndicatorViewController.h"


@interface CGXIndicatorViewController ()<CGXCategoryViewDelegate>

@property (nonatomic , strong) CGXCategoryTitleView *categoryView;
@property (nonatomic , strong) NSMutableArray *titleAry;


@end

@implementation CGXIndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.categoryView.titleArray = self.titleAry;
    [self.view addSubview:self.categoryView];
    self.categoryView.cellWidthZenter = self.titleAry.count == 2 ? YES:NO;


    NSString *title = self.title;
    if ([title isEqualToString:@"圆形"]){
        self.categoryView.titleColorGradientEnabled = YES;
        CGXCategoryIndicatorBallView *ballView = [[CGXCategoryIndicatorBallView alloc] init];
        self.categoryView.indicators = @[ballView];
    } else if ([title isEqualToString:@"三角形"]){
        self.categoryView.titleColorGradientEnabled = YES;
        CGXCategoryIndicatorTriangleView *triangleView = [[CGXCategoryIndicatorTriangleView alloc] init];
        self.categoryView.indicators = @[triangleView];
    } else if ([title isEqualToString:@"底部图片"]){
        self.categoryView.tag = 99999;
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        CGXCategoryIndicatorImageView *indicatorImageView = [[CGXCategoryIndicatorImageView alloc] init];
        indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"apple_select"];
        self.categoryView.indicators = @[indicatorImageView];
        
        self.categoryView.bgImage = [self getImageWithIndex:0];

        interH = 100;
        self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, interH);
        
    } else if ([title isEqualToString:@"cell背景图"]){
        CGXCategoryIndicatorImageView *indicatorImageView = [[CGXCategoryIndicatorImageView alloc] init];
        indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"apple_Noselect"];
        indicatorImageView.indicatorImageViewSize = CGSizeMake(50, 50);
        self.categoryView.indicators = @[indicatorImageView];
    } else if ([title isEqualToString:@"图片滚动"]){
        CGXCategoryIndicatorImageView *indicatorImageView = [[CGXCategoryIndicatorImageView alloc] init];
        indicatorImageView.indicatorImageViewRollEnabled = YES;
        indicatorImageView.indicatorImageViewSize = CGSizeMake(15, 15);
        indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"football"];
        self.categoryView.indicators = @[indicatorImageView];
    } else if ([title isEqualToString:@"混合使用"]){
        self.categoryView.titleColorGradientEnabled = NO;
        self.categoryView.titleLabelMaskEnabled = YES;
        CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
        CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorHeight = 20;
        self.categoryView.indicators = @[backgroundView, lineView];
    } else if ([title isEqualToString:@"Cell背景色渐变"]){
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.cellBackgroundColorGradientEnabled = YES;
        self.categoryView.cellSpacing = 0;
        self.categoryView.cellWidthIncrement = 20;
    } else if ([title isEqualToString:@"内环圆角"]){
        CGXCategoryIndicatorArcView *aView= [[CGXCategoryIndicatorArcView alloc] init];
        aView.indicatorColor = [UIColor orangeColor];
        aView.indicatorCornerRadius  = 20;
        aView.indicatorHeight  = 60;
        aView.verticalSpace = 20;
        aView.specialStyle =CGXCategoryIndicatorArcStyle_Round1;
        self.categoryView.titleSelectedColor = [UIColor whiteColor];
        self.categoryView.indicators = @[aView];
    } else if ([title isEqualToString:@"外环圆角"]){
        CGXCategoryIndicatorArcView *aView= [[CGXCategoryIndicatorArcView alloc] init];
        aView.indicatorColor = [UIColor orangeColor];
        aView.indicatorCornerRadius  = 20;
        aView.indicatorHeight  = 60;
        aView.verticalSpace = 20;
        aView.specialStyle =CGXCategoryIndicatorArcStyle_Round2;
        self.categoryView.indicators = @[aView];
        self.categoryView.titleSelectedColor = [UIColor whiteColor];
    } else if ([title isEqualToString:@"弧形"]){
        CGXCategoryIndicatorArcView *aView= [[CGXCategoryIndicatorArcView alloc] init];
        aView.indicatorColor = [UIColor orangeColor];
        aView.indicatorCornerRadius  = 20;
        aView.indicatorHeight  = 60;
        aView.verticalSpace = 20;
        aView.specialStyle =CGXCategoryIndicatorArcStyle_Arc;
        self.categoryView.indicators = @[aView];
    } else if ([title isEqualToString:@"爱奇艺弧形"]){
        CGXCategoryIndicatorArcView *aView= [[CGXCategoryIndicatorArcView alloc] init];
        aView.indicatorColor = [UIColor whiteColor];
        aView.indicatorCornerRadius  = 20;
        aView.indicatorHeight  = 60;
        aView.verticalSpace = 20;
        aView.specialStyle =CGXCategoryIndicatorArcStyle_IQIYI;
        self.categoryView.indicators = @[aView];
        self.categoryView.titleColor = [UIColor blackColor];
        self.categoryView.titleSelectedColor = [UIColor redColor];
        self.categoryView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.6];
    }
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
    
    [self.categoryView selectItemAtIndex:0];

}


- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didSelectedItemAtIndex:%ld---%ld",(long)categoryView.selectedIndex,(long)index);;
    if (categoryView.tag == 99999) {
        self.categoryView.bgImage = [self getImageWithIndex:index];
    }
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didClickSelectedItemAtIndex:%ld---%ld",(long)categoryView.selectedIndex,(long)index);;

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
