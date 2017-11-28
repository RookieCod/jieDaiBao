//
//  ZSUntils.h
//  QianChengApp
//
//  Created by 张松 on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppDelegate.h"

typedef void(^afterLoginBlock)(void);

@interface ZSUntils : NSObject
// 获取共享控制器
+ (AppDelegate *)getApplicationDelegate;

// 判断字符串是否全为空格
+ (BOOL)getStringIsSpace:(NSString *)string;

// 手机号校验
+ (BOOL)mobileNumFormatCheck:(NSString *)telNum;

// 判断是否需要登录，并弹出登录页面
+ (BOOL)isNeedToUserLogin:(afterLoginBlock)block;

// 中英文混合长度计算
+ (int)convertToInt:(NSString*)strtemp;
@end
