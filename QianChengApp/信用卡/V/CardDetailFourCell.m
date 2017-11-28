//
//  CardDetailFourCell.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "CardDetailFourCell.h"
@interface CardDetailFourCell()
@property (weak, nonatomic) IBOutlet UILabel *teQuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *eDuLabel;

@property (weak, nonatomic) IBOutlet UILabel *gaiLvLabel;
@property (weak, nonatomic) IBOutlet UILabel *yiDuLabel;

@end
@implementation CardDetailFourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setCardDetailModel:(CardDetailModel *)cardDetailModel
{
    self.teQuanLabel.text = cardDetailModel.cardPrivilege;
    self.eDuLabel.text = cardDetailModel.cardLimit;
    self.gaiLvLabel.text = cardDetailModel.cardApproval;
    self.yiDuLabel.text = cardDetailModel.cardDifficulty;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
