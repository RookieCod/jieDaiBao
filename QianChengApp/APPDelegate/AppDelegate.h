//
//  AppDelegate.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

/*  */
@property (nonatomic, strong) NSString *userSession;

/*  */
@property (nonatomic, strong) NSString *userPhone;

- (void)saveUserInfo:(NSString *)userSession userPhone:(NSString *)phone;
- (void)clearUserInfo;

@end

