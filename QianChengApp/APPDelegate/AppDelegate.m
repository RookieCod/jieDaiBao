//
//  AppDelegate.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "AppDelegate.h"
#import "ZSHomeViewController.h"
#import "ZSNewsViewController.h"
#import "MyAppViewController.h"
#import "ZSTabBarViewController.h"
#import "ZSDaiKuanListViewController.h"

#define testIP @"http://106.75.84.49:8080/"
#define productIP @"http://product.ccqsign.com/webapp-supermarket-h5/"

@interface AppDelegate ()<MyTabBarDelegate>

@property (nonatomic, retain) ZSTabBarViewController * tabBarVC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    YTKNetworkConfig *networkConfig = [YTKNetworkConfig sharedConfig];
    networkConfig.baseUrl = productIP;
    
    networkConfig.debugLogEnabled = NO;

    [self getUserSessionFromLocal];
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
    
    ZSDaiKuanListViewController *daiKuanVC = [[ZSDaiKuanListViewController alloc] init];
    daiKuanVC.pushType = DaiKuanListPushTyeFromTab;
    UINavigationController* marketNav = [[UINavigationController alloc] initWithRootViewController:daiKuanVC];
    
    ZSNewsViewController *newsVC = [[ZSNewsViewController alloc] init];
    newsVC.pushType = CardListPushTypeFromTab;
    UINavigationController* newsNav = [[UINavigationController alloc] initWithRootViewController:newsVC];
    
    MyAppViewController *myAppVC = [[MyAppViewController alloc] init];
    UINavigationController* myAppNav = [[UINavigationController alloc] initWithRootViewController:myAppVC];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:homeNav, marketNav, newsNav, myAppNav, nil];
    
    self.tabBarVC = [[ZSTabBarViewController alloc] initWithNibName:@"ZSTabBarViewController" bundle:nil];
    self.tabBarVC.delegate = self;
    self.tabBarVC.view.frame = CGRectMake(0, 0, MAINWIDTH, 49);
    self.tabBarVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tabBarController.tabBar addSubview:self.tabBarVC.view];
}

- (void)tapWithIndex:(NSInteger)index
{
    if (self.tabBarController.selectedIndex != index) {
        
        [self.tabBarController setSelectedIndex:index];
    }
    else {
        UINavigationController* itemNav = (UINavigationController*)[self.tabBarController.viewControllers objectAtIndex:index];
        [itemNav popToRootViewControllerAnimated:YES];
    }
}

- (void)getUserSessionFromLocal
{
    self.userSession = [[NSUserDefaults standardUserDefaults] objectForKey:UserSession];
    self.userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:UserPhone];
    if (!self.userSession) {
        self.userSession = @"";
        self.userPhone = @"";
    }
}

- (void)saveUserInfo:(NSString *)userSession userPhone:(NSString *)phone
{
    [[NSUserDefaults standardUserDefaults] setObject:userSession forKey:UserSession];
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:UserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self getUserSessionFromLocal];

}
- (void)clearUserInfo
{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UserSession];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:UserPhone];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self getUserSessionFromLocal];
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
