//
//  RegistRequest.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/29.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "RegistRequest.h"

@interface RegistRequest()
{
    NSString *_phoneNum;
    NSString *_password;
    NSString *_verity;
}
@end
@implementation RegistRequest
- (instancetype)initWithPhoneNum:(NSString *)phoneNum password:(NSString *)password verity:(NSString *)verity
{
    if (self = [super init]) {
        _phoneNum = phoneNum;
        _password = password;
        _verity = verity;
    }
    return self;
}


- (NSString *)requestUrl
{
    return @"sso/register";
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
             @"verify":_verity,
             };
}

@end
