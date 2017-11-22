//
//  HotXinYongRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "HotXinYongRequest.h"

@interface HotXinYongRequest()
{
    NSInteger _type;
}
@end

@implementation HotXinYongRequest

- (instancetype)initWithType:(NSInteger)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"card/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
        @"type":@(_type),
    };
}

@end
