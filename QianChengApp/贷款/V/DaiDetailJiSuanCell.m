//
//  DaiDetailJiSuanCell.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/27.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "DaiDetailJiSuanCell.h"

@interface DaiDetailJiSuanCell ()
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UILabel *totalLiXi;

@end
@implementation DaiDetailJiSuanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.firstView.layer.borderWidth = 1;
    self.firstView.layer.borderColor = [UIColor colorWithHexString:@"B22614"].CGColor;
    self.firstView.layer.cornerRadius = 10;
    self.firstView.layer.masksToBounds = YES;

    self.secondView.layer.borderWidth = 1;
    self.secondView.layer.borderColor = [UIColor colorWithHexString:@"B22614"].CGColor;
    self.secondView.layer.cornerRadius = 10;
    self.secondView.layer.masksToBounds = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    self.qiXianLabel.userInteractionEnabled = YES;
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [self.tapSubject sendNext:nil];
    }];
    [self.qiXianLabel addGestureRecognizer:tap];
}

- (RACSubject *)tapSubject
{
    if (!_tapSubject) {
        _tapSubject = [[RACSubject alloc] init];
    }
    return _tapSubject;
}

- (void)reloadMoneyWithTotal:(NSString *)monty liXi:(NSString *)lixi
{
    self.totalMoney.text = [NSString stringWithFormat:@"%@元",monty];
    self.totalLiXi.text = [NSString stringWithFormat:@"%@元",lixi];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
