//
//  CGXMainContainerViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXMainContainerViewController.h"

#import "CGXMenuViewController.h"
#import "CGXTitleAttributeViewController.h"
#import "CGXMainTitleViewController.h"
#import "CGXTitleImageViewController.h"
#import "CGXMainTitleViewController.h"
#import "CGXNestViewController.h"

#import "CGXTitleSubtitleViewController.h"
#import "CGXTitleSortViewController.h"

#import "CGXVerticalListViewController.h"
#import "CGXVerticalListTableViewController.h"
#import "CGXScrollZoomViewController.h"

#import "CGXMenuViewController.h"
#import "CGXDataListContainerViewController.h"
#import "CGXListContainerAiQiViewController.h"


@interface CGXMainContainerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *titleArray;
@end

@implementation CGXMainContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"视图";
     self.titleArray = [NSMutableArray arrayWithObjects:@"菜单列表设置",@"高性能列表",@"垂直列表滚动(UICollectionView)",@"垂直列表滚动(UITableView)",@"垂直列表滚动缩放",@"爱奇艺", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kTabBarHeight) style:UITableViewStyleGrouped];;
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar navBarBackGroundColor:[UIColor whiteColor] image:nil isOpaque:YES];
    [self.navigationController.navigationBar navBarMyLayerHeight:kTopHeight isOpaque:NO];//背景高度
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
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (headerView == nil) {
        headerView = [[NSClassFromString(@"UITableViewHeaderFooterView") alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
    }
    headerView.contentView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (footerView == nil) {
        footerView = [[NSClassFromString(@"UITableViewHeaderFooterView") alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
    }
    footerView.contentView.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    return footerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    NSString *title = self.titleArray[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.titleArray[indexPath.row];
    if ([title isEqualToString:@"菜单列表设置"]) {
        CGXMenuViewController *vc = [[CGXMenuViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"高性能列表"]){
        CGXDataListContainerViewController *vc = [[CGXDataListContainerViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"垂直列表滚动(UICollectionView)"]){
        CGXVerticalListViewController *vc = [[CGXVerticalListViewController alloc] init];
        vc.title = title;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"垂直列表滚动(UITableView)"]){
        CGXVerticalListTableViewController *vc = [[CGXVerticalListTableViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
         vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"垂直列表滚动缩放"]){
        CGXScrollZoomViewController *vc = [[CGXScrollZoomViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
         vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"爱奇艺"]) {
        CGXListContainerAiQiViewController *vc = [[CGXListContainerAiQiViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
