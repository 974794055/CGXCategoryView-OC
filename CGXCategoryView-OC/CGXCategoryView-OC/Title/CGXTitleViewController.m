//
//  CGXTitleViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleViewController.h"
#import "CGXTitleOneViewController.h"
#import "CGXTitleTwoViewController.h"
#import "CGXTitleThreeViewController.h"
#import "CGXTitleFourViewController.h"
@interface CGXTitleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *titleArray;

@end

@implementation CGXTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"多样式按钮样式";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.titleArray = [NSMutableArray arrayWithObjects:
                       @"下划线效果",
                       @"点线效果",
                       @"下划线彩虹效果",
                       @"圆点",
                       @"三角形",
                       @"BackgroundView",
                       @"底部图片",
                       @"cell图片背景",
                       @"图片滚动",
                       @"混合使用",
                       @"颜色渐变",
                       @"大小缩放",
                       @"大小缩放+底部锚点",
                       @"大小缩放+顶部锚点",
                       @"大小缩放+字体粗细",
                       @"大小缩放+点击动画",
                       @"大小缩放+Cell宽度缩放",
                       @"Cell背景色渐变",
                       @"分割线",
                       @"多行文本",
                       @"背景边框",
                       nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kTabBarHeight)  style:UITableViewStyleGrouped];;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollsToTop = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UITableViewHeaderFooterView class])];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
    }
    headerView.contentView.backgroundColor = [UIColor lightTextColor];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
    }
    footerView.contentView.backgroundColor = [UIColor lightTextColor];
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];

    
    NSString *title = self.titleArray[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.titleArray[indexPath.row];
    if ([title isEqualToString:@"下划线效果"]) {
        CGXTitleOneViewController *vc = [[CGXTitleOneViewController alloc] init];
        vc.categorytitle = title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"大小缩放"]||
               [title isEqualToString:@"大小缩放+底部锚点"]||
               [title isEqualToString:@"大小缩放+顶部锚点"]||
               [title isEqualToString:@"大小缩放+字体粗细"]||
               [title isEqualToString:@"大小缩放+点击动画"]||
               [title isEqualToString:@"大小缩放+Cell宽度缩放"]){
        CGXTitleThreeViewController *vc = [[CGXTitleThreeViewController alloc] init];
          vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
          [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([title isEqualToString:@"BackgroundView"]){
        CGXTitleFourViewController *vc = [[CGXTitleFourViewController alloc] init];
          vc.hidesBottomBarWhenPushed = YES;
          [self.navigationController pushViewController:vc animated:YES];
    }

    else{
        CGXTitleTwoViewController *vc = [[CGXTitleTwoViewController alloc] init];
        vc.categorytitle = title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
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
