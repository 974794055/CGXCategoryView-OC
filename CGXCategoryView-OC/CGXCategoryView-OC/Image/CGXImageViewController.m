//
//  CGXImageViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXImageViewController.h"

@interface CGXImageViewController ()<CGXCategoryViewDelegate>
@property (nonatomic, strong) CGXCategoryImageView *categoryView;
@property (nonatomic, strong) NSMutableArray *imageNames;
@property (nonatomic, strong) NSMutableArray *selectedImageNames;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation CGXImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"纯图片";
    self.imageNames = [NSMutableArray array];
    self.selectedImageNames = [NSMutableArray array];
    
    self.categoryView = [[CGXCategoryImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.averageCellSpacingEnabled = YES;
    self.categoryView.imageSize = CGSizeMake(30, 30);
    self.categoryView.imageZoomEnabled = YES;
    self.categoryView.imageZoomScale = 1.5;
    [self.view addSubview:self.categoryView];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.frame =CGRectMake(0, CGRectGetHeight(self.categoryView.frame), ScreenWidth, ScreenHeight-kTopHeight-CGRectGetHeight(self.categoryView.frame)-kSafeHeight);
    self.categoryView.contentScrollView = self.scrollView;
    for (int i = 0; i < 6; i ++) {
        CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self addChildViewController:listVC];
        [self.scrollView addSubview:listVC.view];
        listVC.titleStr =  [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",i]];;
        
        [self.imageNames addObject:@"apple_Noselect"];
        [self.selectedImageNames addObject:@"apple_select"];
    }
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame)*self.imageNames.count, CGRectGetHeight(self.scrollView.frame));
    self.categoryView.imageNames = self.imageNames;
    self.categoryView.selectedImageNames = self.selectedImageNames;
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
