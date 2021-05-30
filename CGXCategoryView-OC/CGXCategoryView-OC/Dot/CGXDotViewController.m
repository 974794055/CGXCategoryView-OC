//
//  CGXDotViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/1/31.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXDotViewController.h"

@interface CGXDotViewController ()<CGXCategoryViewDelegate>
@property (nonatomic, strong) CGXCategoryDotView *myCategoryView;
@property (nonatomic, assign) CGXCategoryTitleImageType currentType;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *imageNames;
@property (nonatomic, strong) NSMutableArray *selectedImageNames;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CGXDotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.titles = [NSMutableArray array];
    
    self.titles =  [@[@"全部", @"直播", @"热门商品", @"精品课", @"生活", @"新鲜水果"] mutableCopy];

    self.imageNames = [@[@"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect", @"apple_Noselect"] mutableCopy];
    self.selectedImageNames = [@[@"apple_select", @"apple_select", @"apple_select", @"apple_select", @"apple_select", @"apple_select"] mutableCopy];
    
    self.myCategoryView = [[CGXCategoryDotView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
    self.myCategoryView.delegate = self;
    self.myCategoryView.titleArray = self.titles;
    self.myCategoryView.imageNames = self.imageNames;
    self.myCategoryView.selectedImageNames = self.selectedImageNames;
    self.myCategoryView.dotSize = CGSizeMake(10, 10);
    [self.view addSubview:self.myCategoryView];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.frame =CGRectMake(0, CGRectGetHeight(self.myCategoryView.frame), ScreenWidth, ScreenHeight-kTopHeight-CGRectGetHeight(self.myCategoryView.frame)-kSafeHeight);
    self.myCategoryView.contentScrollView = self.scrollView;
    
    for (int i = 0; i < self.titles.count; i ++) {
        CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self addChildViewController:listVC];
        [self.scrollView addSubview:listVC.view];
        listVC.titleStr =  [[NSAttributedString alloc] initWithString:self.titles[i]];;
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame)*self.titles.count, CGRectGetHeight(self.scrollView.frame));
    
    NSMutableArray *types = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        [types addObject:@(CGXCategoryTitleImageType_OnlyTitle)];
    }
    self.myCategoryView.imageTypes = types;
    [self.myCategoryView reloadData];
    
    [self.myCategoryView updateWithDotHidden:NO AtInter:0];
    [self.myCategoryView updateWithDotHidden:NO AtInter:1];
    [self.myCategoryView updateWithDotHidden:NO AtInter:2];
    [self.myCategoryView updateWithDotHidden:NO AtInter:3];
    [self.myCategoryView updateWithDotHidden:NO AtInter:4];
    [self.myCategoryView updateWithDotHidden:NO AtInter:5];
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    if(index > 2){
        [self.myCategoryView updateWithDotHidden:YES AtInter:index];
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
