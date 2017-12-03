//
//  TongjiRequest.h
//  QianChengApp
//
//  Created by 张松 on 2017/12/3.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface TongjiRequest : YTKRequest
- (instancetype)initWithLoanId:(NSNumber *)loanid cardId:(NSNumber *)cardId;
@end
