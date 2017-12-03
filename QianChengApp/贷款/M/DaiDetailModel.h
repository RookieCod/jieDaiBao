//
//  DaiDetailModel.h
//  QianChengApp
//
//  Created by 张松 on 2017/11/27.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DaiDetailModel : NSObject
/* loanI<##>  */
@property (nonatomic, strong) NSNumber *loanId;

/* 贷款产品名称 */
@property (nonatomic, strong) NSString *loanName;

/* 贷款产品图片 */
@property (nonatomic, strong) NSString *loanPic;

/* loanUrl */
@property (nonatomic, strong) NSString *loanUrl;

/* <##> */
@property (nonatomic, strong) NSString *loanEssay;

/* <##> */
@property (nonatomic, strong) NSNumber *loanMoneyMax;

/* <##> */
@property (nonatomic, strong) NSNumber *loanMoneyMin;

/* <##> */
@property (nonatomic, strong) NSNumber *loanRate;

/* <##> */
@property (nonatomic, strong) NSString *loanTerm;

/* <##> */
@property (nonatomic, strong) NSString *loanPermit;

/* <##> */
@property (nonatomic, strong) NSString *loanCondition;

/* <##> */
@property (nonatomic, strong) NSString *loanRemark;
/*  */
@property (nonatomic, strong) NSNumber *loanCollection;
@end
