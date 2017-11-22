//
//  HotXinYongRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "HotXinYongRequest.h"

@implementation HotXinYongRequest
- (NSString *)requestUrl
{
    return @"card/hotlist";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}


@end
