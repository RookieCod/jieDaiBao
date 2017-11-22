//
//  HomeRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/21.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "HomeRequest.h"

@interface HomeRequest()
{
    NSNumber *_source;
}
@end

@implementation HomeRequest

- (instancetype)initWithSource:(NSNumber *)source
{
    if (self = [super init]) {
        _source = source;
    }
    return self;
}


- (NSString *)requestUrl
{
    return @"banner/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"source":_source,
             };
}

@end
