//
//  RegistCell.h
//  QianChengApp
//
//  Created by 张松 on 2017/11/29.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define registCell @"RegistCell"
@interface RegistCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end
