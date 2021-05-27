//
//  MyListViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXMenuListViewController.h"
#import "CGXCategoryTitleMenuView.h"
@interface CGXMenuListViewController ()<CGXCategoryViewDelegate>

@property (nonatomic, strong) CGXCategoryTitleView *categoryView;

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CGXMenuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.titleArr= [NSMutableArray array];
    
    
    self.categoryView = [[CGXCategoryTitleView alloc] init];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.averageCellSpacingEnabled = YES;
        self.categoryView.cellWidthIncrement = 20;
    [self.view addSubview:self.categoryView];
    self.categoryView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
    CGXCategoryIndicatorLineView *lineView = [[CGXCategoryIndicatorLineView alloc] init];
    lineView.indicatorWidth = CGXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.frame =CGRectMake(0, 50, ScreenWidth, ScreenHeight-kTopHeight-kTabBarHeight-100);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.categoryView.contentScrollView = self.scrollView;
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self updateView];
}
- (void)updateView
{
    [self.titleArr removeAllObjects];
    for (int i = 0; i<2 + arc4random() % 5; i++) {
        [self.titleArr addObject:[NSString stringWithFormat:@"%@-%d",self.tagStr,i]];
    }
    self.categoryView.titleArray = self.titleArr;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds)*self.titleArr.count, CGRectGetHeight(self.scrollView.bounds));
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < self.titleArr.count; i ++) {
            CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
            listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
            [self addChildViewController:listVC];
            listVC.view.tag = 10000+i;
            [self.scrollView addSubview:listVC.view];
            listVC.titleStr =  [[NSAttributedString alloc] initWithString:self.titleArr[i]];;
            listVC.selectBlock = ^(NSIndexPath *indexPath) {
                CGXCustomListViewController *vc = [[CGXCustomListViewController alloc]init];
                vc.view.backgroundColor = [UIColor whiteColor];
                [self.navigationController pushViewController:vc animated:YES];
            };
        }
    });
}
/**
 点击选中的情况才会调用该方法
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"点击选中--%ld",(long)index);
    

}
/**
 滚动选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"滚动选中--%ld",(long)index);
}
/**
 可选实现，列表显示的时候调用
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView ListDidDisappear:(NSInteger)index
{
    NSLog(@"列表消失的时候调用--%ld",(long)index);
}
/**
 可选实现，列表消失的时候调用
 */
- (void)categoryMenuView:(CGXCategoryTitleMenuView *)categoryView ListDidAppearIndex:(NSInteger)index
{
    NSLog(@"列表显示的时候调用--%ld",(long)index);
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
