//
//  FasleInfoListViewController.h
//  QianChengApp
//
//  Created by zhangsong on 2017/12/12.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, infoListVCPushType) {
    infoListVCPushTypeFromHome,
    infoListVCPushTypeFromTab,
};

@interface FasleInfoListViewController : UIViewController
@property (nonatomic, assign) infoListVCPushType pushType;

@end
