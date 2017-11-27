//
//  DaiDetailJiSuanCell.h
//  QianChengApp
//
//  Created by 张松 on 2017/11/27.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaiDetailModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#define detailJiSuanCell @"DaiDetailJiSuanCell"


@interface DaiDetailJiSuanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *JinField;
@property (weak, nonatomic) IBOutlet UILabel *qiXianLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

/*  */
@property (nonatomic, strong) DaiDetailModel *model;

/*  */
@property (nonatomic, strong) RACSubject *tapSubject;

- (void)reloadMoneyWithTotal:(NSString *)monty liXi:(NSString *)lixi;

@end
