//
//  ZSSegmentView.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSSegmentView.h"

@interface ZSSegmentView()
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

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
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor colorWithHexString:@"B22614"] CGColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

- (IBAction)buttonDidClick:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    NSInteger index = button.tag - 1000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedSegmentView:atIndex:)]) {
        [self.delegate selectedSegmentView:self atIndex:index];
    }
}

- (void)reloadSubview:(NSInteger)index
{
    if (index == 1) {
        [self.leftButton setImage:[UIImage imageNamed:@"shangbai"] forState:UIControlStateNormal];
        self.leftButton.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        self.leftButton.backgroundColor = [UIColor colorWithHexString:@"B22614"];
        [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightButton.backgroundColor = [UIColor whiteColor];
        [self.rightButton setImage:[UIImage imageNamed:@"shanghong"] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor colorWithHexString:@"B22614"] forState:UIControlStateNormal];
    } else if (index == 2) {
        self.leftButton.backgroundColor = [UIColor whiteColor];
        [self.leftButton setImage:[UIImage imageNamed:@"shanghong"] forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor colorWithHexString:@"B22614"] forState:UIControlStateNormal];
        self.rightButton.backgroundColor = [UIColor colorWithHexString:@"B22614"];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}
- (void)reloadTitle:(NSString *)string index:(NSInteger)index
{
    if (index == 1) {
        [self.leftButton setTitle:string forState:UIControlStateNormal];
        [self.rightButton setTitle:@"默认排序" forState:UIControlStateNormal];
    } else {
        [self.rightButton setTitle:string forState:UIControlStateNormal];
        [self.leftButton setTitle:@"可贷额度" forState:UIControlStateNormal ];
    }
}
@end
