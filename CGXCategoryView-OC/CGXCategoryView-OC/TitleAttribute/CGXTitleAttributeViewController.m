//
//  CGXTitleAttributeViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleAttributeViewController.h"
#import "CGXCategoryView.h"
@interface CGXTitleAttributeViewController ()<CGXCategoryViewDelegate>

@property (nonatomic, strong) CGXCategoryTitleAttributeView *titleAttributeCategoryView;

@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong)  NSMutableArray   *listVCArray;

@end

@implementation CGXTitleAttributeViewController
- (IBAction)next:(UIBarButtonItem *)sender {
    CGXTitleAttributeViewController *vc = [[CGXTitleAttributeViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"富文本cell";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.listVCArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *attriArr = [NSMutableArray arrayWithObjects:@"周一\n8月20号", @"周二\n8月21号",@"周三\n8月22号",@"周四\n8月23号",@"周五\n8月24号",@"周六\n8月25号",@"周日\n8月26号",nil];
    NSMutableArray *attriTitlesArr = [NSMutableArray array];
    
    NSMutableArray *attriTitlesSelectArr = [NSMutableArray array];
    
    for (int i = 0; i<attriArr.count; i++) {
        NSString *title = attriArr[i];
        NSMutableAttributedString *attributedString =[CGXCategoryTitleFactory itemWithTitle:title TitleColor:[UIColor blackColor]];
        [attriTitlesArr addObject:attributedString];
        
        
        NSMutableAttributedString *attributedSelectString =[CGXCategoryTitleFactory itemWithTitle:title TitleColor:[UIColor redColor]];
        [attriTitlesSelectArr addObject:attributedSelectString];
    }
    NSMutableArray *titleArr= [NSMutableArray arrayWithObjects:@"视频",@"美食",@"新闻",@"搜索",@"美食",@"视频",@"美是",nil];
    for (int i = 0; i<titleArr.count; i++) {
        NSString *title = titleArr[i];
        
        if (i==0) {
            [attriTitlesArr addObject:[CGXCategoryTitleFactory itemWithImageStr:@"apple_Noselect"]];
            [attriTitlesSelectArr addObject:[CGXCategoryTitleFactory itemWithImageStr:@"apple_select"]];
        } else{
            [attriTitlesArr addObject:[CGXCategoryTitleFactory itemWithMoreTitle:title ImageStr:@"apple_Noselect" TitleColor:[UIColor blackColor] Position:CGXCategoryTitlePositionBottom]];
            [attriTitlesSelectArr addObject:[CGXCategoryTitleFactory itemWithMoreTitle:title ImageStr:@"apple_select" TitleColor:[UIColor redColor] Position:CGXCategoryTitlePositionBottom]];
        }
    }
    self.titleAttributeCategoryView = [[CGXCategoryTitleAttributeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];;
    self.titleAttributeCategoryView.delegate = self;
    self.titleAttributeCategoryView.contentScrollAnimated = NO;
    self.titleAttributeCategoryView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self.view addSubview:self.titleAttributeCategoryView];
    CGXCategoryIndicatorLineView *lineView5 = [[CGXCategoryIndicatorLineView alloc] init];
    lineView5.indicatorWidth = CGXCategoryViewAutomaticDimension;
    self.titleAttributeCategoryView.indicators = @[lineView5];
    
    
    NSUInteger count = attriTitlesArr.count;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleAttributeCategoryView.frame), ScreenWidth, kSafeVCHeight-60)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*count, kSafeVCHeight-60);
    [self.view addSubview:self.scrollView];
    self.titleAttributeCategoryView.contentScrollView = self.scrollView;
    
    for (int i = 0; i < count; i ++) {
        UIViewController *listVC = [[UIViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        listVC.view.backgroundColor = randomColor;
        [self.scrollView addSubview:listVC.view];
        CGXWaterCollectionView *waterView = [[CGXWaterCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
        waterView.titleStr = @"";
        
        [listVC.view addSubview:waterView];
        [self.listVCArray addObject:listVC];
    }
 
    [self.titleAttributeCategoryView updateWithAttribute:attriTitlesArr SelectAttribute:attriTitlesSelectArr];
    
    [self.titleAttributeCategoryView selectItemAtIndex:2];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"位置切换" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)rightItemClicked {
    NSString *title = [NSString stringWithFormat:@"星期一\n8月%@号",@(arc4random() % 10 +10)];
        NSMutableAttributedString *attributedString =[CGXCategoryTitleFactory itemWithTitle:title TitleColor:[UIColor blackColor]];
        NSMutableAttributedString *attributedSelectString =[CGXCategoryTitleFactory itemWithTitle:title TitleColor:[UIColor redColor]];
    [self.titleAttributeCategoryView updateWithAttributeString:attributedString SelectAttributeString:attributedSelectString AtInter:0];


}
#pragma mark - CGXCategoryViewDelegate

//为什么会把选中代理分为三个，因为有时候只关心点击选中的，有时候只关心滚动选中的，有时候只关心选中。所以具体情况，使用对应方法。
/**
 点击选择或者滚动选中都会调用该方法，如果外部不关心具体是点击还是滚动选中的，只关心选中这个事件，就实现该方法。
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    //    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"titleAttributeCategoryView 点击选择或者滚动选中-%ld--%ld",(long)index,(long)categoryView.selectedIndex);
    
    CGXCategoryTitleBadgeModel *badge = [[CGXCategoryTitleBadgeModel alloc] init];
    badge.count = arc4random() % 10+index;
//    [self.titleAttributeCategoryView updateWithBadge:badge AtInter:index];
    
}

/**
 点击选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"titleAttributeCategoryView 点击选中-%ld",(long)index);
}

/**
 滚动选中的情况才会调用该方法
 
 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"titleAttributeCategoryView 滚动选中-%ld",(long)index);
}

/**
 只有点击的选中才会调用！！！
 因为用户点击，contentScrollView即将过渡到目标index的位置。内部默认实现`[self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];`。如果实现该代理方法，以自定义实现为准。比如将animated设置为NO，点击切换时无需滚动效果。类似于今日头条APP。
 
 @param categoryView categoryView description
 @param index index description
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index
{
    NSLog(@"titleAttributeCategoryView 只有点击的选中-%ld",(long)index);
}
/**
 正在滚动中的回调
 
 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 百分比
 */
- (void)categoryView:(CGXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio
{
    //   NSLog(@"正在滚动中的回调");
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
