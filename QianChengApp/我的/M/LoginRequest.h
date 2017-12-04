//
//  LoginRequest.h
//  QianChengApp
//
//  Created by 张松 on 2017/11/30.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface LoginRequest : YTKRequest

- (instancetype)initWithPhoneNum:(NSString *)phoneNum password:(NSString *)password verify:(NSString *)verify type:(NSString *)type;
@end
