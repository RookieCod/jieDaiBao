//
//  LoanCollectList.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/3.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "LoanCollectList.h"

@implementation LoanCollectList
- (NSString *)requestUrl
{
    return @"collection/loanlist";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"sessionid" : [ZSUntils getApplicationDelegate].userSession,
             };
}
@end
