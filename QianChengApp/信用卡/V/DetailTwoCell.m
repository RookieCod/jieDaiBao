//
//  DetailTwoCell.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "DetailTwoCell.h"

@interface DetailTwoCell()
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *biZhongLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *qiXianLabel;
@property (weak, nonatomic) IBOutlet UILabel *guiZeLabel;

@end
@implementation DetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCardDetailModel:(CardDetailModel *)cardDetailModel
{
    self.levelLabel.text = cardDetailModel.cardLevel;
    self.biZhongLabel.text = cardDetailModel.cardType;
    self.bankLabel.text = cardDetailModel.cardAgency;
    self.qiXianLabel.text = cardDetailModel.cardFree;
    self.guiZeLabel.text = cardDetailModel.cardIntegral;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
