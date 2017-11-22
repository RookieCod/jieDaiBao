//
//  DaiKuanModel.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaiKuanModel : NSObject
/** 贷款id */
@property (nonatomic, strong) NSNumber *loanId;

/** 贷款最大额度 */
@property (nonatomic, strong) NSNumber *loanMoneyMax;

/** 贷款最小额度 */
@property (nonatomic, strong) NSNumber *loanMoneyMin;

/** 贷款名称 */
@property (nonatomic, strong) NSString *loanName;

/** 放款时间 */
@property (nonatomic, strong) NSString *loanPermit;

/** url */
@property (nonatomic, strong) NSString *loanPic;

/** 利率 */
@property (nonatomic, strong) NSNumber *loanRate;

/** 期限 */
@property (nonatomic, strong) NSString *loanTerm;
@end
