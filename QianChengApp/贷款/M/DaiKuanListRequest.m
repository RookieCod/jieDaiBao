//
//  DaiKuanListRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "DaiKuanListRequest.h"

@implementation DaiKuanListRequest

- (NSString *)requestUrl
{
    return @"loan/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"type":@(2),
             @"money" : self.money,
             @"sort" : self.sort,
             };
}
@end
