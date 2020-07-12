//
//  LoadDataListScrollZoomViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXScrollZoomListViewController.h"


@interface CGXScrollZoomListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, assign) CGFloat topContainerHeight;
@end

@implementation CGXScrollZoomListViewController

- (void)dealloc
{
    self.didScrollCallback = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.topContainerHeight = 150;
    [self.view addSubview:self.tableView];
    self.topView = [[UIView alloc] init];
    self.topView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topContainerHeight);
    self.topView.backgroundColor = [UIColor orangeColor];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:self.topView.frame];
    if ([self.tagStr isEqualToString:@"推荐"]) {
            headImg.image = [UIImage imageNamed:@"IndicatorImage2"];
    } else{
            headImg.image = [UIImage imageNamed:@"IndicatorImage3"];
    }

    [self.topView addSubview:headImg];
    [self.view addSubview:self.topView];
    
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(self.topContainerHeight, 0, 0, 0);
        tableView.contentOffset = CGPointMake(0, -self.topContainerHeight);
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView = tableView;
        return tableView;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%ld",self.tagStr, (long)indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect topViewFrame = self.topView.frame;
    CGFloat targetY = -scrollView.contentOffset.y - self.topContainerHeight;
    topViewFrame.origin.y = MIN(0, targetY);
    self.topView.frame = topViewFrame;
    !self.didScrollCallback ?: self.didScrollCallback(scrollView);
}


- (UIView *)listView {
    return self.view;
}
- (void)listDidAppearAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
- (void)listDidDisappearAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
