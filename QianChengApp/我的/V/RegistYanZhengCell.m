//
//  RegistYanZhengCell.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/29.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "RegistYanZhengCell.h"

@implementation RegistYanZhengCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.getYanZhengBtn.layer.borderWidth = 1;
    self.getYanZhengBtn.layer.borderColor = [UIColor colorWithHexString:@"B22614"].CGColor;
    self.getYanZhengBtn.layer.cornerRadius = 7;
    self.getYanZhengBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
