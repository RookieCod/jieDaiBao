//
//  CardDetailRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/24.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "CardDetailRequest.h"
@interface CardDetailRequest()
{
    NSString *_cardId;
}
@end
@implementation CardDetailRequest
- (instancetype)initWithBank:(NSString *)cardId
{
    if (self = [super init]) {
        _cardId = cardId;
    }
    return self;
}


- (NSString *)requestUrl
{
    return @"card/detail";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"cardid":_cardId,
             };
}
@end
