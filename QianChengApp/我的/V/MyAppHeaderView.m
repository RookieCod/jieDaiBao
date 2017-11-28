//
//  MyAppHeaderView.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "MyAppHeaderView.h"
@interface MyAppHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@end
@implementation MyAppHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.loginButton.layer.borderWidth = 1;
    self.loginButton.layer.borderColor = [UIColor colorWithHexString:@"B22614"].CGColor;
    self.loginButton.layer.cornerRadius = 10;
    self.loginButton.layer.masksToBounds = YES;

    self.registButton.layer.borderWidth = 1;
    self.registButton.layer.borderColor = [UIColor colorWithHexString:@"B22614"].CGColor;
    self.registButton.layer.cornerRadius = 10;
    self.registButton.layer.masksToBounds = YES;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
