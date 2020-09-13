//
//  CGXTitleThreeViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXTitleThreeViewController.h"
#import "CGXCategoryView.h"
@interface CGXTitleThreeViewController ()<CGXCategoryViewDelegate>
{
    NSInteger selectinter;
    UIScrollView *mainScrollViewH;
}
@property (nonatomic , strong) NSMutableArray *titleAry;
@property (nonatomic , strong) UIImageView *bgSelectedImageView;
@property (nonatomic , strong) UIImageView *bgUnselectedImageView;
@end

@implementation CGXTitleThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"大小缩放";
    self.titleAry = [NSMutableArray array];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    selectinter = 0;
    
    
    
    self.titleAry = [NSMutableArray arrayWithObjects:@"全部",@"推荐", @"直播", @"热门商品", @"精品课", @"生活", @"新鲜水果",nil];
    
    
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:
                                  @"大小缩放",
                                  @"大小缩放+底部锚点",
                                  @"大小缩放+顶部锚点",
                                  @"大小缩放+字体粗细",
                                  @"大小缩放+点击动画",
                                  @"大小缩放+Cell宽度缩放",
                                  nil];
    NSInteger interH = 50;
    CGFloat sssss = (ScreenHeight-kTopHeight-kSafeHeight- interH*4-40)/4.0;
    
    mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, (interH+10)*self.titleAry.count, ScreenWidth, sssss)];
    mainScrollViewH.pagingEnabled = YES;
    mainScrollViewH.bounces = NO;
    mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];
    mainScrollViewH.showsHorizontalScrollIndicator = NO;
    mainScrollViewH.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollViewH];
    mainScrollViewH.frame =CGRectMake(0, (interH+10)*titleArray.count, ScreenWidth, ScreenHeight-(interH+10)*titleArray.count-kTopHeight-kSafeHeight);
    for (int i = 0; i<self.titleAry.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = randomColor;
        vc.view.frame = CGRectMake(CGRectGetWidth(mainScrollViewH.frame)*i, 0, CGRectGetWidth(mainScrollViewH.frame), CGRectGetHeight(mainScrollViewH.frame));
        [self addChildViewController:vc];
        CGXWaterCollectionView *waterView = [[CGXWaterCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(mainScrollViewH.frame), CGRectGetHeight(mainScrollViewH.frame))];
        
        waterView.titleStr = @"";
        [vc.view addSubview:waterView];
        [mainScrollViewH addSubview:vc.view];
    }
    mainScrollViewH.contentSize = CGSizeMake(ScreenWidth * self.titleAry.count,CGRectGetHeight(mainScrollViewH.frame));
    
    for (int i = 0 ; i<titleArray.count; i++) {
        
        NSString *title = titleArray[i];
        CGXCategoryTitleView *titleCategoryView = [[CGXCategoryTitleView alloc] init];
        titleCategoryView.backgroundColor = [UIColor whiteColor];
        titleCategoryView.frame = CGRectMake(0, interH*i +10*i, ScreenWidth, interH);
        titleCategoryView.delegate = self;
        titleCategoryView.titleArray = self.titleAry;
        titleCategoryView.tag = 100+i;
        [self.view addSubview:titleCategoryView];
        
         if ([title isEqualToString:@"大小缩放"]){
              titleCategoryView.titleColorGradientEnabled = YES;
              titleCategoryView.titleLabelZoomEnabled = YES;
              titleCategoryView.titleLabelZoomScale = 1.3;
          } else if ([title isEqualToString:@"大小缩放+字体粗细"]){
              titleCategoryView.titleColorGradientEnabled = YES;
              titleCategoryView.titleLabelZoomEnabled = YES;
              titleCategoryView.titleLabelZoomScale = 1.3;
              titleCategoryView.titleLabelStrokeWidthEnabled = YES;
          } else if ([title isEqualToString:@"大小缩放+点击动画"]){
              titleCategoryView.titleColorGradientEnabled = YES;
              titleCategoryView.titleLabelZoomEnabled = YES;
              titleCategoryView.titleLabelZoomScale = 1.3;
              titleCategoryView.titleLabelStrokeWidthEnabled = YES;
              titleCategoryView.selectedAnimationEnabled = YES;
          } else if ([title isEqualToString:@"大小缩放+Cell宽度缩放"]){
              titleCategoryView.titleColorGradientEnabled = YES;
              titleCategoryView.titleLabelZoomEnabled = YES;
              titleCategoryView.titleLabelZoomScale = 1.3;
              titleCategoryView.titleLabelStrokeWidthEnabled = YES;
              titleCategoryView.selectedAnimationEnabled = YES;
              titleCategoryView.cellWidthZoomEnabled = YES;
              titleCategoryView.cellWidthZoomScale = 1.3;
          } else if ([title isEqualToString:@"大小缩放+底部锚点"]){
              titleCategoryView.titleColorGradientEnabled = YES;
              titleCategoryView.titleLabelZoomEnabled = YES;
              titleCategoryView.titleLabelZoomScale = 1.5;
              titleCategoryView.cellWidthIncrement = 10;
              titleCategoryView.titleLabelAnchorPointStyle = CGXCategoryTitleLabelAnchorPointStyleBottom;
              //            titleCategoryView.titleLabelVerticalOffset = 5;
          } else if ([title isEqualToString:@"大小缩放+顶部锚点"]){
              titleCategoryView.titleColorGradientEnabled = YES;
              titleCategoryView.titleLabelZoomEnabled = YES;
              titleCategoryView.titleLabelZoomScale = 1.5;
              titleCategoryView.cellWidthIncrement = 10;
              titleCategoryView.titleLabelAnchorPointStyle = CGXCategoryTitleLabelAnchorPointStyleTop;
              //            titleCategoryView.titleLabelVerticalOffset = 5;
          }
    
        titleCategoryView.contentScrollView = mainScrollViewH;
        [titleCategoryView selectItemAtIndex:0];
    }
    
    
    
}


- (void)categoryView:(CGXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld---%ld",(long)categoryView.selectedIndex,(long)index);
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
