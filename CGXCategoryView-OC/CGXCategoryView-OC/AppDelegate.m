//
//  AppDelegate.m
//  CGXCategoryView-OC
//
//  Created by CGX on 2018/05/20.
//  Copyright © 2018 CGX. All rights reserved.
//

#import "AppDelegate.h"
#import "CGXTabBarViewController.h"
#import "CGXNavigationController.h"

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
    CGXTabBarViewController *tb=[[CGXTabBarViewController alloc]init];
    self.window.rootViewController=tb;
    CGXTitleViewController *c0=[[CGXTitleViewController alloc]init];
    c0.tabBarItem.title=@"样式";
    c0.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c0.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGXNavigationController *nav0 = [[CGXNavigationController alloc] initWithRootViewController:c0];
        
    TableViewController *c1=[[TableViewController alloc]init];
    c1.tabBarItem.title=@"菜单";
    c1.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c1.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGXNavigationController *nav1 = [[CGXNavigationController alloc] initWithRootViewController:c1];

    CGXListContainerTableViewController *c2=[[CGXListContainerTableViewController alloc]init];
    c2.tabBarItem.title=@"视图";
    c2.tabBarItem.image=[[UIImage imageNamed:@"TabStatusNoSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    c2.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabStatusSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CGXNavigationController *nav2 = [[CGXNavigationController alloc] initWithRootViewController:c2];

    tb.viewControllers=@[nav0,nav1,nav2];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
