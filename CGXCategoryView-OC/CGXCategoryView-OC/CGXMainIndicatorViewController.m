//
//  CGXMainIndicatorViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXMainIndicatorViewController.h"

#import "CGXTitleAttributeViewController.h"
#import "CGXTitleImageViewController.h"
#import "CGXNestViewController.h"
#import "CGXTitleSubtitleViewController.h"
#import "CGXTitleSortViewController.h"
#import "CGXBadgeViewController.h"
#import "CGXBackgroundViewController.h"
#import "CGXDotViewController.h"
#import "CGXLineViewController.h"
#import "CGXIndicatorViewController.h"
#import "CGXTitlePinViewViewController.h"

@interface CGXMainIndicatorViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *titleArray;

@end

@implementation CGXMainIndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"指示器";
    self.titleArray = [NSMutableArray arrayWithObjects:
                       @"UISegmentedControl",
                       @"BackgroundView",
                       @"下划线",
                       @"商品排序",
                       @"主副标题",
                       @"角标",
                       @"红点",
                       @"圆形",
                       @"三角形",
                       @"底部图片",
                       @"背景图",
                       @"图片滚动",
                       @"背景色渐变",
                       @"图标指示",
                       @"内环圆角",
                       @"底部弧形",
                       @"爱奇艺弧形",
                       @"混合使用",
                       nil];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kTabBarHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.collectionView.showsVerticalScrollIndicator = YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [self.collectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.frame.size.width-31)/2;
    return CGSizeMake(floor(width),60);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    UILabel *titleLabel = [[UILabel alloc] init];
    [cell.contentView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 1;
    titleLabel.frame = cell.contentView.bounds;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.font = [UIFont systemFontOfSize:16];
    NSString *title = self.titleArray[indexPath.row];
    titleLabel.text = title;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.titleArray[indexPath.row];
    if ([title isEqualToString:@"UISegmentedControl"]){
        CGXNestViewController *vc = [[CGXNestViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"BackgroundView"]){
        CGXBackgroundViewController *vc = [[CGXBackgroundViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"商品排序"]){
        CGXTitleSortViewController *vc = [[CGXTitleSortViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"主副标题"]){
        CGXTitleSubtitleViewController *vc = [[CGXTitleSubtitleViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"角标"]){
        CGXBadgeViewController *vc = [[CGXBadgeViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"红点"]){
        CGXDotViewController *vc = [[CGXDotViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"下划线"]){
        CGXLineViewController *vc = [[CGXLineViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"图标指示"]){
        CGXTitlePinViewViewController *vc = [[CGXTitlePinViewViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else{
        CGXIndicatorViewController *vc = [[CGXIndicatorViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
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
