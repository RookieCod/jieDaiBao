//
//  ZSCreditCardRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/24.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSCreditCardRequest.h"

@interface ZSCreditCardRequest()
{
    NSString *_bankName;
}
@end
@implementation ZSCreditCardRequest

- (instancetype)initWithBank:(NSString *)bankName
{
    if (self = [super init]) {
        _bankName = bankName;
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
             @"type":@(2),
             @"bank" : _bankName,
             };
}
@end
