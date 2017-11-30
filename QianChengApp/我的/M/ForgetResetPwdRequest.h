//
//  ForgetResetPwdRequest.h
//  QianChengApp
//
//  Created by 张松 on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface ForgetResetPwdRequest : YTKRequest

- (instancetype)initWithSessionId:(NSString *)sessionId newsPwd:(NSString *)newPwd;
@end
