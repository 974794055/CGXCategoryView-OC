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
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"simpleHead"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"simpleFoot"];
    [self.collectionView reloadData];
    
    CGXTitleSortIndicatorLineView *lineView = [[CGXTitleSortIndicatorLineView alloc] init];
    lineView.indicatorWidth = 30;
    lineView.indicatorColor = [UIColor redColor];
    lineView.alignmentStyle = CGXCategoryIndicatorAlignmentStyleNode;
    self.categoryView.indicators = @[lineView];
    
    self.titles = @[@"综合", @"销量", @"价格",@"", @"筛选"].mutableCopy;
    self.categoryView.titleArray = self.titles;
    self.categoryView.sortUITypeDic = @{@(0) : @(CGXCategoryTitleSortUIType_ArrowUpDown),
                                        @(1) : @(CGXCategoryTitleSortUIType_OnlyTitle),
                                        @(2) : @(CGXCategoryTitleSortUIType_ArrowBoth),
                                        @(3) : @(CGXCategoryTitleSortUIType_OnlyImage),
                                        @(4) : @(CGXCategoryTitleSortUIType_SingleImage)}.mutableCopy;
    
    self.categoryView.arrowDirections = @{@(0) : @(CGXCategoryTitleSortArrowDirection_Both),
                                          @(2) : @(CGXCategoryTitleSortArrowDirection_Both)}.mutableCopy;
    self.categoryView.singleImages = @{@(3) : [UIImage imageNamed:@"sorting"],
                                       @(4) : [UIImage imageNamed:@"filter"]}.mutableCopy;
    
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
    } else if (index != 4){
        CGXCategoryTitleSortArrowDirection currentPriceDirection = (CGXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(0)].integerValue);
        if (currentPriceDirection != CGXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(0)] = @(CGXCategoryTitleSortArrowDirection_Both);
            [self.categoryView reloadCellAtIndex:0];
        }
        self.statusString = self.titles[index];
    }
    
    if (index == 1) {
        [self.categoryView reloadCellAtIndex:1];
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
        
    } else if (index != 4){
        CGXCategoryTitleSortArrowDirection currentPriceDirection = (CGXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);
        if (currentPriceDirection != CGXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(2)] = @(CGXCategoryTitleSortArrowDirection_Both);
            [self.categoryView reloadCellAtIndex:2];
        }
        self.statusString = self.titles[index];
    }
    if (index == 3) {
        self.isSingular = !self.isSingular;
        CGXCategoryTitleSortArrowDirection currentPriceDirection = (CGXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);
        if (currentPriceDirection != CGXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(2)] = @(CGXCategoryTitleSortArrowDirection_Both);
            [self.categoryView reloadCellAtIndex:2];
        }
        self.statusString = self.titles[index];
        [self.collectionView reloadData];
    }
    
}

- (BOOL)categoryView:(CGXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    if (index == 4) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您点击了筛选，自定义打开您的筛选条件页面" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}
- (CGFloat)categoryTitleView:(CGXCategoryTitleView *)titleView AtIndex:(NSInteger)index
{
    NSNumber *num = @((ScreenWidth-0)/5.0);
    NSArray *arr = @[num,num,num, @(80), @(100)];
    
    return [arr[index] floatValue];
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
    CGFloat width = (collectionView.frame.size.width-10*3)/2;
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
    titleLabel.attributedText = [[NSAttributedString alloc] initWithString:self.statusString];;
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
