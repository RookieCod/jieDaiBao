//
//  DaiKuanDetailRequest.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/24.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

@interface DaiKuanDetailRequest : YTKRequest

- (instancetype)initWithLoanId:(NSString *)loanId;
@end
