//
//  AppDelegate.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "AppDelegate.h"
#import "ZSHomeViewController.h"
#import "ZSMarketViewController.h"
#import "ZSNewsViewController.h"
#import "ZSMyAppViewController.h"
#import "ZSTabBarViewController.h"

@interface AppDelegate ()

@property (nonatomic, retain) ZSTabBarViewController * tabBarVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    YTKNetworkConfig *networkConfig = [YTKNetworkConfig sharedConfig];
    networkConfig.baseUrl = @"http://106.75.84.49:8080/";
    
    networkConfig.debugLogEnabled = YES;
    
    [self customGlobalBarAppearance];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [self initTabBarVC];
    self.window.rootViewController = self.tabBarController;

    [self.window makeKeyAndVisible];
    return YES;
}


/**
 全局设置导航栏的style
 */
- (void)customGlobalBarAppearance
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:20.0f],
                                                            NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"] }];
    
}


- (void)initTabBarVC
{
    //首页
    ZSHomeViewController *homeVC = [[ZSHomeViewController alloc] init];
    UINavigationController* homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    ZSMarketViewController *marketVC = [[ZSMarketViewController alloc] init];
    UINavigationController* marketNav = [[UINavigationController alloc] initWithRootViewController:marketVC];
    
    ZSNewsViewController *newsVC = [[ZSNewsViewController alloc] init];
    UINavigationController* newsNav = [[UINavigationController alloc] initWithRootViewController:newsVC];
    
    ZSMyAppViewController *myAppVC = [[ZSMyAppViewController alloc] init];
    UINavigationController* myAppNav = [[UINavigationController alloc] initWithRootViewController:myAppVC];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:homeNav, marketNav, newsNav, myAppNav, nil];
    //self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:68/255.0 green:173/255.0 blue:159/255.0 alpha:1];
    self.tabBarVC = [[ZSTabBarViewController alloc] initWithNibName:@"ZSTabBarViewController" bundle:nil];
    self.tabBarVC.view.frame = CGRectMake(0, 0, MAINWIDTH, 49);
    self.tabBarVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tabBarController.tabBar addSubview:self.tabBarVC.view];
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
