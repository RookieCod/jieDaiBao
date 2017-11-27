//
//  DaiDetailProductCell.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/27.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "DaiDetailProductCell.h"

@interface DaiDetailProductCell()

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productDesc;

@end

@implementation DaiDetailProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(DaiDetailModel *)model
{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.loanPic] placeholderImage:nil];
    self.productName.text = model.loanName;
    self.productDesc.text = model.loanEssay;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
