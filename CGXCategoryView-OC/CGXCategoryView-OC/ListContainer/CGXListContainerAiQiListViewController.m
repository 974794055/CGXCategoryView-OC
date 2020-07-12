//
//  CGXListContainerAiQiListViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXListContainerAiQiListViewController.h"
#import "CGXWaterCollectionView.h"
@interface CGXListContainerAiQiListViewController ()

@property (nonatomic , strong) CGXWaterCollectionView *waterView;

@end

@implementation CGXListContainerAiQiListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.waterView = [[CGXWaterCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.waterView];
    __weak typeof(self) weakSelf = self;
    self.waterView.selectBlock = ^(NSIndexPath *indexPath) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.waterView.collectionView reloadData];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.waterView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
     [self.waterView.collectionView reloadData];
}
- (void)setTagStr:(NSString *)tagStr
{
    _tagStr = tagStr;
    self.waterView.titleStr = tagStr;
}
#pragma mark - CGXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}
/**
 可选实现，列表将要显示的时候调用
 */
- (void)listWillAppearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.tagStr,(long)index);
}
/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.tagStr,(long)index);
}
/**
 可选实现，列表将要消失的时候调用
 */
- (void)listWillDisappearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.tagStr,(long)index);
}
/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.tagStr,(long)index);
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//  NSLog(@"%@:%@", NSStringFromSelector(_cmd),self.tagStr);
//
//}
//
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//   NSLog(@"%@:%@", NSStringFromSelector(_cmd),self.tagStr);
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    NSLog(@"%@:%@", NSStringFromSelector(_cmd),self.tagStr);
//}
//
//- (void)viewDidDisappear:(BOOL)animated {
//    [super viewDidDisappear:animated];
//
//   NSLog(@"%@:%@", NSStringFromSelector(_cmd),self.tagStr);
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
