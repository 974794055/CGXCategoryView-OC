//
//  BaseViewController.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2022/2/13.
//  Copyright © 2022 CGX. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor=AppBackroudColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImage *image = [UIImage imageWithColor:AppThemeColor Size:CGSizeMake(ScreenWidth, kTopHeight)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance * appearance = [[UINavigationBarAppearance alloc] init];
        // 背景色
        appearance.backgroundColor = AppThemeColor;
        // 去除导航栏阴影（如果不设置clear，导航栏底下会有一条阴影线）
        appearance.shadowColor = [UIColor clearColor];
        // 字体颜色、尺寸等
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName:AppMainColor};
        // 带scroll滑动的页面
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        // 常规页面
        self.navigationController.navigationBar.standardAppearance = appearance;
    }
    // iOS 15适配
    if (@available(iOS 15.0, *)) {
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, 0) forBarMetrics:UIBarMetricsDefault];
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance setBackgroundColor:AppThemeColor];
        // UINavigationBarAppearance 会覆盖原有的导航栏设置，这里需要重新设置返回按钮隐藏，不隐藏可注释或删掉
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffsetMake(-200, 0);
        [[UINavigationBar appearance] setScrollEdgeAppearance:appearance];
        [[UINavigationBar appearance] setStandardAppearance:appearance];
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
