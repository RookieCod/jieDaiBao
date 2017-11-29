//
//  LoginRequest.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/30.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "LoginRequest.h"
@interface LoginRequest()
{
    NSString *_phoneNum;
    NSString *_password;
    NSString *_type;
}
@end

@implementation LoginRequest
- (instancetype)initWithPhoneNum:(NSString *)phoneNum password:(NSString *)password type:(NSString *)type
{
    if (self = [super init]) {
        _phoneNum = phoneNum;
        _password = password;
        _type = type;
    }
    return self;
}


- (NSString *)requestUrl
{
    return @"sso/smlogin";
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (id)requestArgument
{
    return @{
             @"account":_phoneNum,
             @"pwd":_password,
             @"type":_type,
             };
}

@end
