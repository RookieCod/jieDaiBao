//
//  CardDetailThreeCell.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "CardDetailThreeCell.h"

@interface CardDetailThreeCell()
@property (weak, nonatomic) IBOutlet UILabel *nianFeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *biLiLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *huanKuanLabel;

@end
@implementation CardDetailThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setCardDetailModel:(CardDetailModel *)cardDetailModel
{
    self.nianFeiLabel.text = cardDetailModel.cardCost;
    self.biLiLabel.text = cardDetailModel.cardDrawing;
    self.threeLabel.text = cardDetailModel.cardEnchashment;
    self.huanKuanLabel.text = cardDetailModel.cardRepayment;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
