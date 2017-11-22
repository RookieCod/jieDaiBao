//
//  HotDaiKuanRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "HotDaiKuanRequest.h"

@interface HotDaiKuanRequest()
{
    NSInteger _type;
}
@end

@implementation HotDaiKuanRequest

- (instancetype)initWithType:(NSInteger)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

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
             @"type" : @(_type),
             };
}

@end
