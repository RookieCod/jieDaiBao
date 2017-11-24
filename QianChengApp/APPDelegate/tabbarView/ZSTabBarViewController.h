//
//  ZSTabBarViewController.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

static  NSString * const tabBarNameArray[] = {
    [0] = @"首页",
    [1] = @"超市",
    [2] = @"资讯",
    [3] = @"我的",
};
@protocol MyTabBarDelegate;

@interface ZSTabBarViewController : UIViewController

/** id */
@property (nonatomic, assign) id<MyTabBarDelegate> delegate;

- (void)setBarItemIndex:(NSInteger)index;

@end

@protocol MyTabBarDelegate <NSObject>

- (void)tapWithIndex:(NSInteger)index;

@end
