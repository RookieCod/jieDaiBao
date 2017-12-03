//
//  CardCollectList.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/3.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "CardCollectList.h"

@implementation CardCollectList
- (NSString *)requestUrl
{
    return @"collection/cardlist";
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
