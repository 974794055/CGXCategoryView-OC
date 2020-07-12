//
//  CGXBadgeViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2020/7/7.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXBadgeViewController.h"

@interface CGXBadgeViewController ()<CGXCategoryViewDelegate>
@property (nonatomic, strong) CGXCategoryBadgeView *myCategoryView;
@property (nonatomic, assign) CGXCategoryTitleImageType currentType;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *imageNames;
@property (nonatomic, strong) NSMutableArray *selectedImageNames;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CGXBadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;


    self.navigationItem.title = @"角标";
    self.titles = [NSMutableArray array];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"位置切换" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemItemClicked)];
    self.navigationItem.rightBarButtonItems = @[leftItem];
    
    
    self.titles =  [@[@"全部", @"直播", @"热门商品", @"精品课", @"生活", @"新鲜水果"] mutableCopy];
    
    self.imageNames = [@[@"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect"] mutableCopy];
    self.selectedImageNames = [@[@"apple_select", @"apple_select", @"apple_select", @"apple_select", @"apple_select", @"apple_select"] mutableCopy];
    
    self.myCategoryView = [[CGXCategoryBadgeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
    self.myCategoryView.titleArray = self.titles;
    self.myCategoryView.imageNames = self.imageNames;
    self.myCategoryView.selectedImageNames = self.selectedImageNames;
    //    self.myCategoryView.imageZoomEnabled = YES;
    //    self.myCategoryView.imageZoomScale = 1.3;
    //    self.myCategoryView.averageCellSpacingEnabled = NO;
    [self.view addSubview:self.myCategoryView];
    
    CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = 20;
    self.myCategoryView.indicators = @[lineView];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.frame =CGRectMake(0, CGRectGetHeight(self.myCategoryView.frame), ScreenWidth, ScreenHeight-kTopHeight-CGRectGetHeight(self.myCategoryView.frame)-kSafeHeight);
    self.myCategoryView.contentScrollView = self.scrollView;
    
    for (int i = 0; i < self.titles.count; i ++) {
        UIViewController *listVC = [[UIViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self addChildViewController:listVC];
        listVC.view.backgroundColor = randomColor;
        
        CGXWaterCollectionView *waterView = [[CGXWaterCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        waterView.titleStr = @"";
        [listVC.view addSubview:waterView];
        
        [self.scrollView addSubview:listVC.view];
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame)*self.titles.count, CGRectGetHeight(self.scrollView.frame));
    
    [self configCategoryViewWithType:CGXCategoryTitleImageType_OnlyTitle];
    
    [self.myCategoryView selectItemAtIndex:0];
    
    [self leftItemItemClicked];
    
}
- (void)leftItemItemClicked
{
    CGXCategoryIndicatorView *componentView = (CGXCategoryIndicatorView *)self.myCategoryView;
    for (CGXCategoryIndicatorComponentView *view in componentView.indicators) {
        if (view.componentPosition == CGXCategoryComponentPosition_Top) {
            view.componentPosition = CGXCategoryComponentPosition_Bottom;
        }else {
            view.componentPosition = CGXCategoryComponentPosition_Top;
        }
    }
    
    for (int i = 0; i<self.titles.count; i++) {
        CGXCategoryTitleBadgeModel *badge = [[CGXCategoryTitleBadgeModel alloc] init];
        badge.count = arc4random()% 20+i;
        [self.myCategoryView updateWithBadge:badge AtInter:i];
    }

    [componentView reloadData];
}

- (void)configCategoryViewWithType:(CGXCategoryTitleImageType)imageType {
    self.currentType = imageType;
    if ((NSInteger)imageType == 100) {
        NSMutableArray *types = [NSMutableArray array];
        for (int i = 0; i < self.titles.count; i++) {
            if (i == 2) {
                [types addObject:@(CGXCategoryTitleImageType_OnlyImage)];
            }else if (i == 4) {
                [types addObject:@(CGXCategoryTitleImageType_LeftImage)];
            }else {
                [types addObject:@(CGXCategoryTitleImageType_OnlyTitle)];
            }
        }
        self.myCategoryView.imageTypes = types;
    }else {
        NSMutableArray *types = [NSMutableArray array];
        for (int i = 0; i < self.titles.count; i++) {
            [types addObject:@(imageType)];
        }
        self.myCategoryView.imageTypes = types;
    }
    [self.myCategoryView reloadData];
}
- (void)titleImageSettingVCDidSelectedImageType:(CGXCategoryTitleImageType)imageType {
    [self configCategoryViewWithType:imageType];
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
