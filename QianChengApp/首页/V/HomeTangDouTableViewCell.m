//
//  HomeTangDouTableViewCell.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "HomeTangDouTableViewCell.h"

@implementation HomeTangDouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)tangdouButtonDidClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    [self.buttonClick sendNext:@(button.tag)];
}

- (RACSubject *)buttonClick
{
    if (!_buttonClick) {
        _buttonClick = [[RACSubject alloc] init];
    }
    return _buttonClick;
}

@end
