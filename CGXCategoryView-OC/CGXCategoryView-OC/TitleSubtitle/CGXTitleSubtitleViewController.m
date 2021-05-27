//
//  CGXCategoryTitleSubViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleSubtitleViewController.h"

#import "CGXCategoryTitleSubView.h"

@interface CGXTitleSubtitleViewController ()<CGXCategoryViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) CGXCategoryTitleSubView *categoryView;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , assign) CGFloat maxCategoryViewHeight;

@property (nonatomic , assign) CGFloat minCategoryViewHeight;
@end


@implementation CGXTitleSubtitleViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray <NSString *> *status = [@[@"已开抢", @"抢购中", @"即将开抢", @"抢购中", @"抢购完"] mutableCopy];
    NSMutableArray <NSString *> *times = [@[@"12:00", @"13:00", @"14:00", @"15:00", @"16:00"] mutableCopy];
    self.maxCategoryViewHeight= 60;
    self.minCategoryViewHeight= 60;
    
    self.categoryView = [[CGXCategoryTitleSubView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.maxCategoryViewHeight);
    [self.view addSubview:self.categoryView];
    self.categoryView.backgroundColor = [UIColor blackColor];
    self.categoryView.titleArray = status;
    self.categoryView.subTitleArray = times;
    
    self.categoryView.titleLabelVerticalOffset = -10;
    self.categoryView.subTitleSpace =15;
    self.categoryView.titleColorGradientEnabled = YES;
    //设置底部状态
    self.categoryView.titleColor = [UIColor lightGrayColor];
    self.categoryView.titleSelectedColor = [UIColor whiteColor];
    self.categoryView.titleFont = [UIFont systemFontOfSize:14];
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:16];
    //设置顶部时间
    self.categoryView.subTitleFont = [UIFont boldSystemFontOfSize:10];
    self.categoryView.subTitleSelectedFont = [UIFont boldSystemFontOfSize:10];
    self.categoryView.subTitleNormalColor = [UIColor whiteColor];
    self.categoryView.subTitleSelectedColor = [UIColor whiteColor];
//    self.categoryView.subTitleNBgColor = [UIColor redColor];
//    self.categoryView.subTitleSBgColor = [UIColor orangeColor];
    
    [self BackgroundViewPercent:1.0];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), ScreenWidth, kSafeVCHeight-self.maxCategoryViewHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame)* status.count, CGRectGetHeight(self.scrollView.frame));
    [self.view addSubview:self.scrollView];
    self.categoryView.contentScrollView = self.scrollView;
    
    
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i <  status.count; i ++) {
        CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self addChildViewController:listVC];
        [self.scrollView addSubview:listVC.view];
        listVC.titleStr =  [[NSAttributedString alloc] initWithString:status[i]];;
        listVC.scrollViewBlock = ^(UIScrollView *scrollView) {
            [weakSelf listScrollViewDidScroll:scrollView];
        };
    }
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didSelectedItemAtIndex--%ld",(long)index);
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"didScrollSelectedItemAtIndex--%ld",(long)index);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll---:%f",scrollView.contentOffset.y);
}

- (void)listScrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.contentOffset.y;
    NSLog(@"heightheight--%f",height);
    if (self.maxCategoryViewHeight != self.minCategoryViewHeight) {
        //用于垂直方向滚动时，视图的frame调整
        if ((self.categoryView.bounds.size.height < self.maxCategoryViewHeight) && scrollView.contentOffset.y < 0) {
            
            CGRect categoryViewFrame = self.categoryView.frame;
            categoryViewFrame.size.height -= scrollView.contentOffset.y;
            categoryViewFrame.size.height = MIN(self.maxCategoryViewHeight, categoryViewFrame.size.height);
            self.categoryView.frame = categoryViewFrame;
            self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame));
            
            scrollView.contentOffset = CGPointZero;
        }else if (((self.categoryView.bounds.size.height < self.maxCategoryViewHeight) && scrollView.contentOffset.y >= 0 && self.categoryView.bounds.size.height > self.minCategoryViewHeight) ||
                  (self.categoryView.bounds.size.height >= self.maxCategoryViewHeight && scrollView.contentOffset.y >= 0)) {
            CGRect categoryViewFrame = self.categoryView.frame;
            categoryViewFrame.size.height -= scrollView.contentOffset.y;
            categoryViewFrame.size.height = MAX(self.minCategoryViewHeight, categoryViewFrame.size.height);
            self.categoryView.frame = categoryViewFrame;
            
            self.scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame));
            
            scrollView.contentOffset = CGPointZero;
        }
        //必须调用
        CGFloat percent = (self.categoryView.bounds.size.height - self.minCategoryViewHeight)/(self.maxCategoryViewHeight - self.minCategoryViewHeight);
        [self.categoryView listDidScrollWithVerticalHeightPercent:percent];
        
        [self BackgroundViewPercent:percent];
    } else{
        //必须调用
        CGFloat percent =  scrollView.contentOffset.y/self.maxCategoryViewHeight;
        if (scrollView.contentOffset.y > self.maxCategoryViewHeight) {
            percent = 1;
        }
        [self.categoryView listDidScrollWithVerticalHeightPercent:1-percent];
        
        [self BackgroundViewPercent:1-percent];
    }

}

- (void)BackgroundViewPercent:(CGFloat)percent
{
    CGXCategoryIndicatorBackgroundView *backgroundView11 = [[CGXCategoryIndicatorBackgroundView alloc] init];
    backgroundView11.indicatorHeight = 15;
    backgroundView11.indicatorCornerRadius = 7.5;
    backgroundView11.indicatorWidthIncrement = 10;
    backgroundView11.verticalMargin = -(self.minCategoryViewHeight/2.0-15);
    backgroundView11.scrollEnabled = NO;
    backgroundView11.indicatorColor = [[UIColor redColor] colorWithAlphaComponent:percent];
    self.categoryView.indicators = @[backgroundView11];
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
