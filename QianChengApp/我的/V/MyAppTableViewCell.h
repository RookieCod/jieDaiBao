//
//  MyAppTableViewCell.h
//  QianChengApp
//
//  Created by 张松 on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define myAppTableViewCell @"myAppTableViewCell"
@interface MyAppTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@end
