//
//  ZSNewsViewController.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, CardListPushType) {
    CardListPushTypeFromHome,
    CardListPushTypeFromTab,
};
@interface ZSNewsViewController : UIViewController

/** 推出方式 */
@property (nonatomic, assign) CardListPushType pushType;
@end
