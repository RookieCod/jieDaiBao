//
//  RegistRequest.h
//  QianChengApp
//
//  Created by 张松 on 2017/11/29.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface RegistRequest : YTKRequest
- (instancetype)initWithPhoneNum:(NSString *)phoneNum password:(NSString *)password verity:(NSString *)verity;
@end
