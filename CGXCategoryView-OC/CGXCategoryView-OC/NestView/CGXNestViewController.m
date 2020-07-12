//
//  CGXNestViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "CGXNestViewController.h"

#import "CGXCategorySegmentedTitleView.h"
@interface CGXNestViewController ()<UIScrollViewDelegate,CGXCategoryViewDelegate>
@property (nonatomic, strong) CGXCategoryTitleView *categoryView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) CGXCategorySegmentedTitleView *segmented;

@property (nonatomic, strong) CGXWaterCollectionView *waterView;
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
//        self.segmented.bgNormalImage = [UIImage imageNamed:@"IndicatorImage1"];
//         self.segmented.bgSelectImage = [UIImage imageNamed:@"IndicatorImage3"];
    [self.view addSubview:self.segmented];
    __weak typeof(self) weakSelf = self;
    self.segmented.selectBlock = ^(NSMutableArray<NSString *> * _Nonnull titleArr, NSInteger inter) {
        NSLog(@"%@--%ld",titleArr,(long)inter) ;
        weakSelf.titleStr2 = titleArr[inter];
        [weakSelf updateData];
    };
  

    self.waterView = [[CGXWaterCollectionView alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight-60)];
    [self.view addSubview:self.waterView];
    
    self.categoryView.titleArray = self.titles;
    [self.categoryView selectItemAtIndex:1];
    
    [self.segmented updateWithTitleArray:titleA];
    [self.segmented selectSegmentAtIndex:1];

}
- (void)updateData
{
    self.waterView.titleStr = [NSString stringWithFormat:@"%@\n%@",self.titleStr1,self.titleStr2];
}

- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    self.titleStr1 = self.titles[index];
     [self updateData];
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
