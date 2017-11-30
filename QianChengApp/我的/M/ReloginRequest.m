//
//  ReloginRequest.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ReloginRequest.h"

@implementation ReloginRequest
- (NSString *)requestUrl
{
    return @"sso/relogin";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"sessionid":[ZSUntils getApplicationDelegate].userSession,
             };
}
@end
