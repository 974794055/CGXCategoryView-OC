//
//  CGXTitleSortViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXTitleSortViewController.h"

#import "CGXCategoryTitleSortView.h"
#import "CGXTitleSortIndicatorLineView.h"

#import "CGXCustomListViewCell.h"

@interface CGXTitleSortViewController () <CGXCategoryViewDelegate,CGXCategoryTitleViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) CGXCategoryTitleSortView *categoryView;


@property (nonatomic, strong) NSString *statusString;

@property (assign, nonatomic) BOOL isSingular;//默认YES

@end

@implementation CGXTitleSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.statusString = @"综合";
    self.isSingular = YES;
    self.titles = @[@"综合", @"销量", @"价格",@"排序", @"筛选"].mutableCopy;
    
    self.categoryView = [[CGXCategoryTitleSortView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.titleDataSource = self;
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [self.view addSubview:self.categoryView];
    
    
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
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator=YES;
    [self.collectionView registerClass:[CGXCustomListViewCell class] forCellWithReuseIdentifier:@"CGXCustomListViewCell"];
    [self.collectionView reloadData];
    
    self.titles = @[@"综合", @"销量", @"价格",@"", @"筛选"].mutableCopy;
    self.categoryView.titleArray = self.titles;
    self.categoryView.sortUITypeDic = @{@(0) : @(CGXCategoryTitleSortUIType_ArrowUpDown),
                                        @(1) : @(CGXCategoryTitleSortUIType_OnlyTitle),
                                        @(2) : @(CGXCategoryTitleSortUIType_ArrowBoth),
                                        @(3) : @(CGXCategoryTitleSortUIType_SingleImage),
                                        @(4) : @(CGXCategoryTitleSortUIType_OnlyImage)}.mutableCopy;
    
    self.categoryView.arrowDirections = @{@(0) : @(CGXCategoryTitleSortArrowDirection_Both),
                                          @(2) : @(CGXCategoryTitleSortArrowDirection_Both)}.mutableCopy;
    self.categoryView.singleImages = @{@(3) : [UIImage imageNamed:@"filter"],
                                       @(4) : [UIImage imageNamed:@"sorting1"]}.mutableCopy;
    
    self.categoryView.separatorLineDic = @{@(0) : @(NO),@(1) : @(NO),@(2) : @(NO),@(3) : @(YES),@(4) : @(NO)}.mutableCopy;
    
    self.categoryView.arrowTopImage =  [UIImage imageNamed:@"arrow_up"];
    self.categoryView.arrowBottomImage =[UIImage imageNamed:@"arrow_down"];
    
    
    [self.categoryView  selectItemAtIndex:0];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    self.collectionView.frame = CGRectMake(0, 50, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight-50);
}

#pragma mark - CGXCategoryViewDelegate
- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    if (index == 0) {
        CGXCategoryTitleSortArrowDirection currentPriceDirection = (CGXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(0)].integerValue);
        NSArray *titleA =  @[@"综合",@"新品促销",@"评论高",@"评论低",@"价格高",@"价格低"];
        if (currentPriceDirection == CGXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(0)] = @(CGXCategoryTitleSortArrowDirection_Down);
            [self.categoryView reloadCellAtIndex:0];
            self.statusString = titleA[index];
            [self.collectionView reloadData];
            return;
        }else{
            if (currentPriceDirection == CGXCategoryTitleSortArrowDirection_Up) {
                self.categoryView.arrowDirections[@(0)] = @(CGXCategoryTitleSortArrowDirection_Down);
            }else {
                self.categoryView.arrowDirections[@(0)] = @(CGXCategoryTitleSortArrowDirection_Up);
            }
            [self.categoryView reloadCellAtIndex:0];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定切换排序方式吗？" preferredStyle:UIAlertControllerStyleAlert];
            for (int i = 0; i<titleA.count; i++) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:titleA[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    self.titles[0] = titleA[i];
                    self.categoryView.titleArray = self.titles;
                    self.categoryView.arrowDirections[@(0)] = @(CGXCategoryTitleSortArrowDirection_Down);
                    [self.categoryView reloadCellAtIndex:index];
                    self.statusString = titleA[i];
                    
                    [self.collectionView reloadData];
                }];
                if ([action.title isEqualToString:self.statusString]) {
                    [action setValue:[UIColor redColor] forKey:@"_titleTextColor"];
                }else{
                    [action setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
                }
                [alert addAction:action];
            }
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    if (index == 1 && self.statusString != self.titles[index]) {
            self.statusString = self.titles[index];
            [self.collectionView reloadData];
    }
    
    if (index == 2) {
        CGXCategoryTitleSortArrowDirection currentPriceDirection = (CGXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);
        if (currentPriceDirection == CGXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(2)] = @(CGXCategoryTitleSortArrowDirection_Down);
        }else if (currentPriceDirection == CGXCategoryTitleSortArrowDirection_Up) {
            self.categoryView.arrowDirections[@(2)] = @(CGXCategoryTitleSortArrowDirection_Down);
        }else {
            self.categoryView.arrowDirections[@(2)] = @(CGXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadCellAtIndex:index];
        self.statusString = self.titles[index];
        [self.collectionView reloadData];
    }
}

- (BOOL)categoryView:(CGXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    if (index == 3) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您点击了筛选，自定义打开您的筛选条件页面" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    if (index == 4) {
        self.isSingular = !self.isSingular;
        if (self.categoryView.singleImages[@(4)] == [UIImage imageNamed:@"sorting1"]) {
            self.categoryView.singleImages[@(4)] = [UIImage imageNamed:@"sorting2"];
        } else{
            self.categoryView.singleImages[@(4)] = [UIImage imageNamed:@"sorting1"];
        }
        [self.categoryView reloadCellAtIndex:index];
        [self.collectionView reloadData];
        return NO;
    }
    return YES;
}
- (CGFloat)categoryTitleView:(CGXCategoryTitleView *)titleView AtIndex:(NSInteger)index
{
    NSNumber *num = @((ScreenWidth-80-80)/3.0);
    NSArray *arr = @[num,num,num, @(80), @(80)];
    
    return [arr[index] floatValue];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
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
    if (self.isSingular) {
        CGFloat width = collectionView.frame.size.width-10;
        return CGSizeMake(floor(width),100);
    } else{
        CGFloat width = (collectionView.frame.size.width-10*3)/2;
        return CGSizeMake(floor(width),floor(width));
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXCustomListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGXCustomListViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = randomColor;
    
    cell.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.statusString];;;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld---%ld" ,(long)indexPath.section,(long)indexPath.row);
    
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
