//
//  ZSInfoListViewController.h
//  QianChengApp
//
//  Created by zhangsong on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, infoVCPushType) {
    infoVCPushTypeFromHome,
    infoVCPushTypeFromTab,
};

@interface ZSInfoListViewController : UIViewController
@property (nonatomic, assign) infoVCPushType pushType;

@end
