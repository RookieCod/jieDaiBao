//
//  HomeCardTableViewCell.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/22.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "HomeCardTableViewCell.h"

@interface HomeCardTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankDesc;

@end
@implementation HomeCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCardModel:(HomeCardModel *)cardModel
{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:cardModel.cardPic] placeholderImage:nil];
    self.bankName.text = cardModel.cardName;
    self.bankDesc.text = cardModel.cardEssay;
}

- (void)setDetailModel:(CardDetailModel *)detailModel
{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.cardPic] placeholderImage:nil];
    self.bankName.text = detailModel.cardBank;
    self.bankDesc.text = detailModel.cardEssay;
}

- (void)setInfoListModel:(InfoListModel *)infoListModel
{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:infoListModel.informationPic] placeholderImage:nil];
    self.bankName.text = infoListModel.informationName;
    self.bankDesc.text = infoListModel.informationEssay;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
