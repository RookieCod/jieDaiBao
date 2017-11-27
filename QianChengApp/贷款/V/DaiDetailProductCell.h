//
//  DaiDetailProductCell.h
//  QianChengApp
//
//  Created by 张松 on 2017/11/27.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaiDetailModel.h"

#define detailProductCell @"DaiDetailProductCell"
@interface DaiDetailProductCell : UITableViewCell

/*  */
@property (nonatomic, strong) DaiDetailModel *model;
@end
