//
//  DaiKuanTableViewCell.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaiKuanModel.h"

#define daiKuanCellIdentifier @"DaiKuanTableViewCell"

@interface DaiKuanTableViewCell : UITableViewCell
/**  */
@property (nonatomic, strong) DaiKuanModel *daiKuanModel;
@end
