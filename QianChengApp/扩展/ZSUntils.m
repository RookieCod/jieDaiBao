//
//  ZSUntils.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSUntils.h"
#import "ZSLoginViewController.h"

#define kStringIsSpace @"^\\s*$"
#define kPhoneNumberFormat @"^[1][3-8]+\\d{9}"

@implementation ZSUntils

// 获取共享控制器
+ (AppDelegate *)getApplicationDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
// 判断字符串是否全为空格
+ (BOOL)getStringIsSpace:(NSString *)string
{
    NSError *err;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:kStringIsSpace
                                                                         options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                                                           error:&err];
    NSArray *matches = [reg matchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, [string length])];

    if ([matches count] == 0) {
        return NO;
    } else {
        return YES;
    }
}

// 手机号校验
+ (BOOL)mobileNumFormatCheck:(NSString *)telNum
{
    // 手机号格式
    NSError *err;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:kPhoneNumberFormat
                                                                         options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                                                           error:&err];
    NSArray *matches = [reg matchesInString:telNum options:NSMatchingReportCompletion range:NSMakeRange(0, [telNum length])];

    if ([matches count] == 0) {
        return NO;
    } else {
        return YES;
    }
}

// 判断是否需要登录，并弹出登录页面
+ (BOOL)isNeedToUserLogin:(afterLoginBlock)block
{

    //    NSLog(@"%@", [self getApplicationDelegate].userId);
    //    NSLog(@"%@", [self getApplicationDelegate].userSession);

    if (![self getApplicationDelegate].userSession || [[self getApplicationDelegate].userSession isEqualToString:@""]) {
        // 登录
        ZSLoginViewController *loginCtrl = [[ZSLoginViewController alloc] init];
        UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:loginCtrl];

        [[self getApplicationDelegate].tabBarController presentViewController:navCtrl
                                                                     animated:YES completion:^{
                                                                         if (block) {
                                                                             block();
                                                                         }
                                                                     }];
        return YES;
    } else {
        return NO;
    }
}

// 中英文混合长度计算
+ (int)convertToInt:(NSString*)strtemp {

    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength/2;
}
@end
