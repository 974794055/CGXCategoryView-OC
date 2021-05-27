//
//  CGXCustomListViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2021/5/23.
//  Copyright © 2021 CGX. All rights reserved.
//

#import "CGXCustomListViewController.h"

@interface CGXCustomListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger inter;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation CGXCustomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    inter = arc4random() % 3+1;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator=YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simpleHead"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"simpleFoot"];
    [self.collectionView reloadData];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}
//设置head foot视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"simpleHead" forIndexPath:indexPath];
        head.backgroundColor = [UIColor orangeColor];
        return head;
    }else {
        UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"simpleFoot" forIndexPath:indexPath];
        foot.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        return foot;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return arc4random() % 3 + 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arc4random() % 20 + 10;
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
   return CGSizeMake(collectionView.bounds.size.width, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
   return CGSizeMake(collectionView.bounds.size.width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (collectionView.frame.size.width-10*(inter+1))/inter;
    return CGSizeMake(floor(width),100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = randomColor;
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
    }];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:cell.contentView.frame];
    [cell.contentView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.attributedText =self.titleStr;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld---%ld" ,(long)indexPath.section,(long)indexPath.row);
    if (self.selectBlock) {
        self.selectBlock(indexPath);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollViewBlock) {
        self.scrollViewBlock(scrollView);
    }
}
- (void)setTitleStr:(NSAttributedString *)titleStr
{
    _titleStr = titleStr;
    [self.collectionView reloadData];
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
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.titleStr,(long)index);
}
/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.titleStr,(long)index);
}
/**
 可选实现，列表将要消失的时候调用
 */
- (void)listWillDisappearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.titleStr,(long)index);
}
/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappearAtIndex:(NSInteger)index
{
    NSLog(@"%@:%@:%ld", NSStringFromSelector(_cmd),self.titleStr,(long)index);
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
