//
//  HomeTangDouTableViewCell.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TangDouTableViewCell @"HomeTangDouTableViewCell"

@interface HomeTangDouTableViewCell : UITableViewCell

/** <#description#> */
@property (nonatomic, strong) RACSubject *buttonClick;
@end
