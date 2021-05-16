//
//  AppDelegate.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "AppDelegate.h"

#import "TableViewController.h"

#import "CGXNestViewController.h"

#import "CGXListContainerTableViewController.h"

#import "CGXDataListContainerViewController.h"

#import "CGXTitleViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UITabBarController *tb=[[UITabBarController alloc]init];
    self.window.rootViewController=tb;
    CGXTitleViewController *c0=[[CGXTitleViewController alloc]init];
    c0.tabBarItem.title=@"样式";
    c0.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c0.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav0 = [[UINavigationController alloc] initWithRootViewController:c0];
        
    TableViewController *c1=[[TableViewController alloc]init];
    c1.tabBarItem.title=@"菜单";
    c1.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c1.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:c1];

    CGXListContainerTableViewController *c2=[[CGXListContainerTableViewController alloc]init];
    c2.tabBarItem.title=@"视图";
    c2.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c2.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:c2];

    tb.viewControllers=@[nav0,nav1,nav2];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
@end
