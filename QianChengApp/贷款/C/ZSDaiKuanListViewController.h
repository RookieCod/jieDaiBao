//
//  ZSDaiKuanListViewController.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DaiKuanListPushTye) {
    DaiKuanListPushTyeFromHome,
    DaiKuanListPushTyeFromTab,
};

@interface ZSDaiKuanListViewController : UIViewController
@property (nonatomic, assign) DaiKuanListPushTye pushType;
@end
