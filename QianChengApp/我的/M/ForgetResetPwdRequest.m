//
//  ForgetResetPwdRequest.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ForgetResetPwdRequest.h"

@interface ForgetResetPwdRequest()

{
    NSString *_sessionId;
    NSString *_newPwd;
}
@end
@implementation ForgetResetPwdRequest
- (instancetype)initWithSessionId:(NSString *)sessionId newsPwd:(NSString *)newPwd
{
    if (self = [super init]) {
        _sessionId = sessionId;
        _newPwd = newPwd;
    }
    return self;
}

- (NSString *)requestUrl
{
    return @"sso/repwd";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"sessionid":_sessionId,
             @"newpwd":_newPwd,
             };
}
@end
