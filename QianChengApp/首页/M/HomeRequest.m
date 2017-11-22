//
//  HomeRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/21.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "HomeRequest.h"

@implementation HomeRequest

- (NSString *)requestUrl
{
    return @"banner/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

@end
