//
//  YanZhengLoginView.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/30.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "YanZhengLoginView.h"

@implementation YanZhengLoginView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.getYanBtn.layer.borderWidth = 1;
    self.getYanBtn.layer.borderColor = [UIColor colorWithHexString:@"B22614"].CGColor;
    self.getYanBtn.layer.cornerRadius = 7;
    self.getYanBtn.layer.masksToBounds = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
