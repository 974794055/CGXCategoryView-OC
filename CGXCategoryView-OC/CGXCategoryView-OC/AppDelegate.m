//
//  AppDelegate.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "AppDelegate.h"

#import "CGXMainIndicatorViewController.h"

#import "CGXNestViewController.h"

#import "CGXMainContainerViewController.h"

#import "CGXDataListContainerViewController.h"

#import "CGXMainTitleViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UITabBarController *tb=[[UITabBarController alloc]init];
    self.window.rootViewController=tb;
    CGXMainTitleViewController *c0=[[CGXMainTitleViewController alloc]init];
    c0.tabBarItem.title=@"样式";
    c0.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c0.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:c0];
        
    CGXMainIndicatorViewController *c1=[[CGXMainIndicatorViewController alloc]init];
    c1.tabBarItem.title=@"指示器";
    c1.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c1.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:c1];

    CGXMainContainerViewController *c2=[[CGXMainContainerViewController alloc]init];
    c2.tabBarItem.title=@"视图";
    c2.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c2.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:c2];

    tb.viewControllers=@[nav0,nav1,nav2];
    
    [self.window makeKeyAndVisible];
    
//    UIView.appearance.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    return YES;
}
@end
