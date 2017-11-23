//
//  DaiKuanTableViewCell.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "DaiKuanTableViewCell.h"

@interface DaiKuanTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *daiKuanFanwei;
@property (weak, nonatomic) IBOutlet UILabel *kuanTime;
@property (weak, nonatomic) IBOutlet UILabel *lilvLabel;

@property (weak, nonatomic) IBOutlet UILabel *qixianLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@end
@implementation DaiKuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDaiKuanModel:(DaiKuanModel *)daiKuanModel
{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:daiKuanModel.loanPic] placeholderImage:nil];
    self.daiKuanFanwei.text = [NSString stringWithFormat:@"%@-%@",daiKuanModel.loanMoneyMin,daiKuanModel.loanMoneyMax];
    self.kuanTime.text = daiKuanModel.loanPermit;
    self.lilvLabel.text = [NSString stringWithFormat:@"%@",daiKuanModel.loanRate];
    self.qixianLabel.text = daiKuanModel.loanTerm;
    self.productName.text = daiKuanModel.loanName;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
