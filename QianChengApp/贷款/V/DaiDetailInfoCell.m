//
//  DaiDetailInfoCell.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/27.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "DaiDetailInfoCell.h"

@interface DaiDetailInfoCell()

@property (weak, nonatomic) IBOutlet UILabel *EDuLabel;
@property (weak, nonatomic) IBOutlet UILabel *QiXianLabel;
@property (weak, nonatomic) IBOutlet UILabel *LiXiLabel;

@end
@implementation DaiDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(DaiDetailModel *)model
{
    self.EDuLabel.text = [NSString stringWithFormat:@"%@元-%@元",model.loanMoneyMin,model.loanMoneyMax];
    self.QiXianLabel.text = model.loanTerm;
    self.LiXiLabel.text = [NSString stringWithFormat:@"%@%@",model.loanRate,@"%"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
