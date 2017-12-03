//
//  TongjiRequest.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/3.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "TongjiRequest.h"

@interface TongjiRequest()
{
    NSNumber *_loanId;
    NSNumber *_cardId;
}
@end
@implementation TongjiRequest
- (instancetype)initWithLoanId:(NSNumber *)loanid cardId:(NSNumber *)cardId
{
    if (self = [super init]) {
        _loanId = loanid;
        _cardId = cardId;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"count/apply";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"sessionid" : [ZSUntils getApplicationDelegate].userSession,
             @"cardid":_cardId,
             @"loanid":_loanId,
             };
}

@end
