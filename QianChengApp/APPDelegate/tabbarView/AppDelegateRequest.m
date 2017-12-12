//
//  AppDelegateRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/12/12.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "AppDelegateRequest.h"

@implementation AppDelegateRequest

- (NSString *)requestUrl
{
    return @"sso/audit";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end
