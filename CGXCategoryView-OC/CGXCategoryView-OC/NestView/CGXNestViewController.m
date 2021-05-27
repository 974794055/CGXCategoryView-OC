//
//  CGXNestViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXNestViewController.h"

#import "CGXCategorySegmentedTitleView.h"
@interface CGXNestViewController ()<UIScrollViewDelegate,CGXCategoryViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) CGXCategoryTitleView *categoryView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) CGXCategorySegmentedTitleView *segmented;

@property (nonatomic, strong) NSString *titleStr1;
@property (nonatomic, strong) NSString *titleStr2;


@end

@implementation CGXNestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.titles = [NSMutableArray arrayWithObjects:@"主题一", @"主题二", @"主题三", nil];
    
    self.categoryView = [[CGXCategoryTitleView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.frame = CGRectMake(0, 0, 180, 30);
    self.categoryView.layer.cornerRadius = 15;
    self.categoryView.layer.masksToBounds = YES;
    self.categoryView.layer.borderColor = [UIColor redColor].CGColor;
    self.categoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.categoryView.cellSpacing = 0;
    self.categoryView.titleColor = [UIColor redColor];
    self.categoryView.titleSelectedColor = [UIColor whiteColor];
    self.categoryView.titleLabelMaskEnabled = YES;
    CGXCategoryIndicatorBackgroundView *backgroundView = [[CGXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 30;
    backgroundView.indicatorWidthIncrement = 20;
    backgroundView.indicatorColor = [UIColor redColor];
    self.categoryView.indicators = @[backgroundView];
    self.navigationItem.titleView = self.categoryView;
    
    NSMutableArray *titleA = [NSMutableArray arrayWithObjects:@"全部", @"好货", @"生活", @"西瓜", nil];
    
    self.segmented = [[CGXCategorySegmentedTitleView alloc] init];
    self.segmented.frame = CGRectMake(50, 10, ScreenWidth-100, 40);
    [self.view addSubview:self.segmented];
    __weak typeof(self) weakSelf = self;
    self.segmented.selectBlock = ^(NSMutableArray<NSString *> * _Nonnull titleArr, NSInteger inter) {
        NSLog(@"%@--%ld",titleArr,(long)inter) ;
        weakSelf.titleStr2 = titleArr[inter];
        [weakSelf.collectionView reloadData];
    };
    
    
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
    
    self.categoryView.titleArray = self.titles;
    [self.categoryView selectItemAtIndex:1];
    
    [self.segmented updateWithTitleArray:titleA];
    [self.segmented selectSegmentAtIndex:1];
    
}

- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    self.titleStr1 = self.titles[index];
    [self.collectionView reloadData];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.collectionView.frame = CGRectMake(0, 60, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-60-kSafeHeight);
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
    titleLabel.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",self.titleStr1,self.titleStr2]];;;
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
