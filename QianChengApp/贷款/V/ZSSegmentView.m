//
//  ZSSegmentView.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSSegmentView.h"

@interface ZSSegmentView()


@end
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

    self.leftButton.titleLabel.
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor colorWithHexString:@"B22614"] CGColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;

    self.leftButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.rightButton.titleLabel.textAlignment= NSTextAlignmentCenter;
}

- (IBAction)buttonDidClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    NSInteger index = button.tag - 1000;

    if (index == 1) {
        [self.leftButton setImage:[UIImage imageNamed:@"xiabai"] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"shanghong"] forState:UIControlStateNormal];
    } else {
        [self.leftButton setImage:[UIImage imageNamed:@"shanghong"] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"xiabai"] forState:UIControlStateNormal];
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedSegmentView:atIndex:)]) {
        [self.delegate selectedSegmentView:self atIndex:index];
    }
}

- (void)reloadSubview:(NSInteger)index
{
    if (index == 1) {
        self.leftButton.backgroundColor = [UIColor colorWithHexString:@"B22614"];


        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightButton.backgroundColor = [UIColor whiteColor];

        [self.rightButton setTitleColor:[UIColor colorWithHexString:@"B22614"] forState:UIControlStateNormal];
    } else if (index == 2) {
        self.leftButton.backgroundColor = [UIColor whiteColor];

        [self.leftButton setTitleColor:[UIColor colorWithHexString:@"B22614"] forState:UIControlStateNormal];
        self.rightButton.backgroundColor = [UIColor colorWithHexString:@"B22614"];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
- (void)reloadTitle:(NSString *)string index:(NSInteger)index
{
    if (index == 1) {
        [self.leftButton setTitle:string forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"shangbai"] forState:UIControlStateNormal];
        [self.rightButton setTitle:@"默认排序" forState:UIControlStateNormal];
    } else {
        [self.rightButton setTitle:string forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"shangbai"] forState:UIControlStateNormal];
        [self.leftButton setTitle:@"可贷额度" forState:UIControlStateNormal ];
    }
}
@end
