//
//  ZSSegmentView.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSSegmentView.h"

@implementation ZSSegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor colorWithHexString:@"B22614"] CGColor];
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
}

- (IBAction)buttonDidClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    NSInteger index = button.tag - 1000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedSegmentView:atIndex:)]) {
        [self.delegate selectedSegmentView:self atIndex:index];
    }
}

@end
