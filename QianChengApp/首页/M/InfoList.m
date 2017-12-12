//
//  InfoList.m
//  QianChengApp
//
//  Created by zhangsong on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "InfoList.h"

@interface InfoList()
{
    NSString *_type;
}
@end
@implementation InfoList

- (instancetype)initWithType:(NSString *)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}


- (NSString *)requestUrl
{
    return @"information/list";
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
