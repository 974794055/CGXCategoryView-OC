//
//  CGXTitleAttributeViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleAttributeViewController.h"

@interface CGXTitleAttributeViewController ()<CGXCategoryViewDelegate>

@property (nonatomic, strong) CGXCategoryTitleAttributeView *categoryView;

@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong)  NSMutableArray   *listVCArray;

@end

@implementation CGXTitleAttributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"富文本";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.listVCArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *attriArr = [NSMutableArray arrayWithObjects:@"周一\n8月20号", @"周二\n8月21号",@"周三\n8月22号",@"周四\n8月23号",@"周五\n8月24号",@"周六\n8月25号",@"周日\n8月26号",nil];
    NSMutableArray *attriTitlesArr = [NSMutableArray array];
    
    NSMutableArray *attriTitlesSelectArr = [NSMutableArray array];
    
    for (int i = 0; i<attriArr.count; i++) {
        NSString *title = attriArr[i];
        NSMutableAttributedString *attributedString =[CGXCategoryTitleFactory itemWithTitle:title TitleColor:[UIColor blackColor] TitleFont:[UIFont systemFontOfSize:12]];
        [attriTitlesArr addObject:attributedString];
        
        NSMutableAttributedString *attributedSelectString =[CGXCategoryTitleFactory itemWithTitle:title TitleColor:[UIColor redColor] TitleFont:[UIFont systemFontOfSize:16]];
        [attriTitlesSelectArr addObject:attributedSelectString];
    }
    self.categoryView = [[CGXCategoryTitleAttributeView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];;
    self.categoryView.delegate = self;
    self.categoryView.contentScrollAnimated = YES;
    self.categoryView.selectedAnimationEnabled = YES;
    self.categoryView.cellWidthIncrement = 10;
    self.categoryView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    [self.view addSubview:self.categoryView];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), ScreenWidth, kSafeVCHeight-60)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*attriArr.count, kSafeVCHeight-60);
    [self.view addSubview:self.scrollView];
    self.categoryView.contentScrollView = self.scrollView;
    
    [self.listVCArray removeAllObjects];
    for (int i = 0; i < attriArr.count; i ++) {
        CGXCustomListViewController *listVC = [[CGXCustomListViewController alloc] init];
        listVC.view.frame = CGRectMake(i*CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self addChildViewController:listVC];
        [self.scrollView addSubview:listVC.view];
        listVC.titleStr = attriTitlesArr[i];
        
        [self.listVCArray addObject:listVC];
    }

    [self.categoryView updateWithAttribute:attriTitlesArr SelectAttribute:attriTitlesSelectArr];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"更新某个item" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)rightItemClicked {
    NSString *title = [NSString stringWithFormat:@"星期一周一\n8月%@号",@(arc4random() % 10 +10)];
    NSMutableAttributedString *attributedString =[CGXCategoryTitleFactory itemWithTitle:title TitleColor:[UIColor blackColor]];
    NSMutableAttributedString *attributedSelectString =[CGXCategoryTitleFactory itemWithTitle:title TitleColor:[UIColor orangeColor]];
    [self.categoryView updateWithAttributeString:attributedString SelectAttributeString:attributedSelectString AtInter:self.categoryView.selectedIndex];
   
    
    CGXCustomListViewController *listVC = self.listVCArray[self.categoryView.selectedIndex];
    listVC.titleStr = attributedString;
    
    [self.categoryView reloadData];
}

- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"categoryView 点击选择或者滚动选中-%ld--%ld",(long)index,(long)categoryView.selectedIndex);
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"categoryView 点击选中-%ld",(long)index);
}
- (void)categoryView:(CGXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"categoryView 滚动选中-%ld",(long)index);
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
