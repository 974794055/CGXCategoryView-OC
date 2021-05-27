//
//  CGXBackgroundViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXBackgroundViewController.h"

@interface CGXBackgroundViewController ()<CGXCategoryViewDelegate>
{
    NSInteger selectinter;
    UIScrollView *mainScrollViewH;
}
@property (nonatomic , strong) NSMutableArray *titleAry;
@property (nonatomic , strong) UIImageView *bgSelectedImageView;
@property (nonatomic , strong) UIImageView *bgUnselectedImageView;
@end

@implementation CGXBackgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    selectinter = 0;
    
    
    
    self.titleAry = [NSMutableArray arrayWithObjects:@"精选",@"俱乐部",@"电影",@"电视剧",@"综艺",@"动漫",@"儿童",@"演唱会",@"票务",@"美食",@"生活",@"商城",@"知识",nil];
    
    
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:
                                  @"BackgroundView椭圆形",
                                  @"BackgroundView椭圆形+阴影",
                                  @"BackgroundView长方形",
                                  @"BackgroundView遮罩有背景",
                                  @"BackgroundView遮罩无背景",
                                  @"BackgroundView渐变色",
                                  nil];
    NSInteger interH = 50;
    CGFloat sssss = (ScreenHeight-kTopHeight-kSafeHeight- interH*4-40)/4.0;
    
    mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, (interH+10)*self.titleAry.count, ScreenWidth, sssss)];
    mainScrollViewH.pagingEnabled = YES;
    mainScrollViewH.bounces = NO;
    mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    mainScrollViewH.showsHorizontalScrollIndicator = NO;
    mainScrollViewH.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollViewH];
    mainScrollViewH.frame =CGRectMake(0, (interH+10)*titleArray.count, ScreenWidth, ScreenHeight-(interH+10)*titleArray.count-kTopHeight-kSafeHeight);
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
        titleCategoryView.frame = CGRectMake(0, interH*i +10*i, ScreenWidth, interH);
        titleCategoryView.delegate = self;
        titleCategoryView.titleArray = self.titleAry;
        titleCategoryView.tag = 100+i;
        [self.view addSubview:titleCategoryView];
        
        if ([title isEqualToString:@"BackgroundView椭圆形"]){
            titleCategoryView.titleColorGradientEnabled = YES;
            CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.indicatorHeight = 20;
            backgroundView.indicatorCornerRadius = 10;
            titleCategoryView.indicators = @[backgroundView];
        } else if ([title isEqualToString:@"BackgroundView椭圆形+阴影"]){
            titleCategoryView.titleColorGradientEnabled = YES;
            CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.indicatorHeight = 20;
            backgroundView.indicatorCornerRadius = 10;
            backgroundView.layer.shadowColor = [UIColor redColor].CGColor;
            backgroundView.layer.shadowRadius = 3;
            backgroundView.layer.shadowOffset = CGSizeMake(3, 4);
            backgroundView.layer.shadowOpacity = 0.6;
            titleCategoryView.indicators = @[backgroundView];
        } else if ([title isEqualToString:@"BackgroundView长方形"]){
            titleCategoryView.titleColorGradientEnabled = NO;
            titleCategoryView.titleLabelMaskEnabled = YES;
            CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.indicatorWidth = CGXCategoryViewAutomaticDimension;
            backgroundView.indicatorCornerRadius = 0;
            titleCategoryView.indicators = @[backgroundView];
            
        } else if ([title isEqualToString:@"BackgroundView遮罩有背景"]){
            titleCategoryView.titleColorGradientEnabled = NO;
            titleCategoryView.titleLabelMaskEnabled = YES;
            CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.indicatorWidthIncrement = 10;
            backgroundView.indicatorHeight = 30;
            titleCategoryView.indicators = @[backgroundView];
        } else if ([title isEqualToString:@"BackgroundView遮罩无背景"]){
            titleCategoryView.titleColorGradientEnabled = NO;
            titleCategoryView.titleLabelMaskEnabled = YES;
            CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.indicatorWidthIncrement = 10;
            backgroundView.indicatorHeight = 30;
            backgroundView.alpha = 0.3;
            titleCategoryView.indicators = @[backgroundView];
        } else if ([title isEqualToString:@"BackgroundView渐变色"]){
            titleCategoryView.titleColorGradientEnabled = YES;
            titleCategoryView.titleSelectedColor = [UIColor whiteColor];
            CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
            
            //相当于把CGXCategoryIndicatorBackgroundView当做视图容器，你可以在上面添加任何想要的效果
            CGXCategoryGradientView *gradientView = [CGXCategoryGradientView new];
            gradientView.gradientLayer.endPoint = CGPointMake(1, 0);
            gradientView.gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:90.0/255 green:215.0/255 blue:202.0/255 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:122.0/255 green:232.0/255 blue:169.0/255 alpha:1].CGColor,];
            //设置gradientView布局和CGXCategoryIndicatorBackgroundView一样
            gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [backgroundView addSubview:gradientView];
            backgroundView.indicatorHeight = 20;
            backgroundView.indicatorCornerRadius = 0;
            titleCategoryView.indicators = @[backgroundView];
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
