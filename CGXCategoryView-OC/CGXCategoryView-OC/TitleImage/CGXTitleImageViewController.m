//
//  ImageViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleImageViewController.h"
#import "CGXCategoryTitleImageView.h"
#import "TitleImageSettingViewController.h"


@interface CGXTitleImageViewController () <CGXCategoryViewDelegate, TitleTitleImageSettingViewControllerDelegate>
@property (nonatomic, strong) CGXCategoryTitleImageView *myCategoryView;
@property (nonatomic, assign) CGXCategoryTitleImageType currentType;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *imageNames;
@property (nonatomic, strong) NSMutableArray *selectedImageNames;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CGXTitleImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"图文设置";
    self.titles = [NSMutableArray array];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"位置切换" style:UIBarButtonItemStylePlain target:self action:@selector(leftItemItemClicked)];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(didSettingClicked)];
    self.navigationItem.rightBarButtonItems = @[leftItem,settingItem];
    
    
    self.titles =  [@[@"全部", @"直播", @"热门商品", @"精品课", @"生活", @"新鲜水果"] mutableCopy];
    
    self.imageNames = [@[@"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect"] mutableCopy];
    self.selectedImageNames = [@[@"apple_select", @"apple_select", @"apple_select", @"apple_select", @"apple_select", @"apple_select"] mutableCopy];
    
    self.myCategoryView = [[CGXCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
    self.myCategoryView.titleArray = self.titles;
    self.myCategoryView.imageNames = self.imageNames;
    self.myCategoryView.selectedImageNames = self.selectedImageNames;
    //    self.myCategoryView.imageZoomEnabled = YES;
    //    self.myCategoryView.imageZoomScale = 1.3;
//    self.myCategoryView.cellSpacing = 0;
        self.myCategoryView.averageCellSpacingEnabled = YES;
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
    
    [self configCategoryViewWithType:CGXCategoryTitleImageType_TopImage];
    
    [self.myCategoryView selectItemAtIndex:0];
    
    
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
        badge.count = 10+i;
//        [self.myCategoryView updateWithBadge:badge AtInter:i];
    }

    [componentView reloadData];
}
- (void)didSettingClicked {
    TitleImageSettingViewController *imageSettingVC = [[TitleImageSettingViewController alloc] init];
    imageSettingVC.imageType = self.currentType;
    imageSettingVC.delegate = self;
    [self.navigationController pushViewController:imageSettingVC animated:YES];
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

@end
