//
//  InfoDetailRequest.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "InfoDetailRequest.h"

@interface InfoDetailRequest()
{
    NSNumber *_infoId;
}
@end
@implementation InfoDetailRequest
- (instancetype)initWithInformationId:(NSNumber *)infoId
{
    if(self = [super init]) {
        _infoId = infoId;
    }
    return self;
}


- (NSString *)requestUrl
{
    return @"information/detail";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"informationid":_infoId,
             };
}

@end
