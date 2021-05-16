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
    NSMutableArray *titleArr= [NSMutableArray arrayWithObjects:@"全部",@"推荐",@"美食",@"新闻",
                               @"视频",@"美食",@"新闻",@"搜索",@"全部",@"热门",
                               nil];
    NSArray *imageNames = @[@"apple_Noselect",
                            @"apple_Noselect",
                            @"apple_Noselect",
                            @"apple_Noselect",
                            @"apple_Noselect",
                            @"apple_Noselect",
                            @"apple_Noselect",
                            @"apple_Noselect",
                            @"apple_Noselect",
                            @"apple_Noselect"];
    NSArray *selectedImageNames = @[@"apple_select",
                                    @"apple_select",
                                    @"apple_select",
                                    @"apple_select",
                                    @"apple_select",
                                    @"apple_select",
                                    @"apple_select",
                                    @"apple_select",
                                    @"apple_select",
                                    @"apple_select"];
    NSArray  *typesArr = @[@(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage),
                           @(CGXCategoryTitleImageType_TopImage)];
    
    self.menuView = [[CGXCategoryTitleMenuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kSafeVCHeight)];
    self.menuView.delegate=self;
    self.menuView.backgroundColor = [UIColor orangeColor];
    self.menuView.categoryViewHeight = 100;
//    self.menuView.topLineHeight = 3;
//    self.menuView.topLineColor = [UIColor grayColor];
    self.menuView.bottomLineHeight = 2;
    self.menuView.bottomLineColor = [UIColor grayColor];
    CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
    lineView.verticalMargin=0;
    self.menuView.categoryView.indicators = @[lineView];

    [self.view addSubview:self.menuView];
    NSMutableArray *vcArr= [NSMutableArray array];
    for (int i = 0; i<titleArr.count; i++) {
        CGXMenuListViewController *listVC = [[CGXMenuListViewController alloc] init];
        listVC.tagStr = titleArr[i];
        [vcArr addObject:listVC];
    }
    self.menuView.categoryView.imageNames = imageNames;
    self.menuView.categoryView.selectedImageNames = selectedImageNames;
    self.menuView.categoryView.imageTypes = typesArr;

    [self.menuView updateWithTitleArray:titleArr VCArray:vcArr];

}

#pragma mark - CGXCategoryListContentViewDelegate
- (UIImage *)getImageWithIndex:(NSInteger)index {
    NSArray <UIImage *> *images = @[[UIImage imageNamed:@"IndicatorImage1"],
                                    [UIImage imageNamed:@"IndicatorImage3"],
                                    [UIImage imageNamed:@"IndicatorImage0"],
                                    [UIImage imageNamed:@"IndicatorImage2"],
                                    [UIImage imageNamed:@"IndicatorImage1"],
                                    [UIImage imageNamed:@"IndicatorImage3"],
                                    [UIImage imageNamed:@"IndicatorImage0"],
                                    [UIImage imageNamed:@"IndicatorImage2"],
                                    [UIImage imageNamed:@"IndicatorImage1"],
                                    [UIImage imageNamed:@"IndicatorImage3"],
                                    [UIImage imageNamed:@"IndicatorImage0"],
                                    [UIImage imageNamed:@"IndicatorImage2"]];
    return images[index];
}
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
//    self.menuView.categoryView.bgImage = [self getImageWithIndex:index];
}
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
//    self.menuView.categoryView.bgImage = [self getImageWithIndex:index];
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
