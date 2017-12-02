//
//  CollectRequest.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/2.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "CollectRequest.h"

@interface CollectRequest()
{
    NSNumber *_type;
}
@end
@implementation CollectRequest

- (instancetype)initWithCollectType:(NSNumber *)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

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
             @"type":_type,
             };
}
@end
