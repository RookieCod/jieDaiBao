//
//  DaiKuanDetailRequest.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/24.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "DaiKuanDetailRequest.h"

@interface DaiKuanDetailRequest ()
{
    NSNumber *_loanId;
}
@end
@implementation DaiKuanDetailRequest

- (instancetype)initWithLoanId:(NSNumber *)loanId
{
    if (self = [super init]) {
        _loanId = loanId;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"loan/detail";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"loanid":_loanId,
             };
}
@end
