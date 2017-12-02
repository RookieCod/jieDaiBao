//
//  InfoList.m
//  QianChengApp
//
//  Created by zhangsong on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "InfoList.h"

@implementation InfoList
- (NSString *)requestUrl
{
    return @"information/list";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

@end
