//
//  RegistYanZheng.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/29.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "RegistYanZheng.h"

@interface RegistYanZheng()
{
    NSString *_phoneNum;
    NSString *_password;
    NSString *_type;
}
@end

@implementation RegistYanZheng
- (instancetype)initWithPhoneNum:(NSString *)phoneNum password:(NSString *)password
{
    if (self = [super init]) {
        _phoneNum = phoneNum;
        _password = password;
        _type = @"1";
    }
    return self;
}


- (NSString *)requestUrl
{
    return @"sso/getverify";
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
