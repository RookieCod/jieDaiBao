//
//  HotDaiKuanRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "HotDaiKuanRequest.h"

@implementation HotDaiKuanRequest
- (NSString *)requestUrl
{
    return @"loan/hotlist";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end
