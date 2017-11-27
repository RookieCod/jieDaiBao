//
//  DaiDetailConditionCell.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/27.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "DaiDetailConditionCell.h"
@interface DaiDetailConditionCell ()
@property (weak, nonatomic) IBOutlet UILabel *conditionDesc;


@end
@implementation DaiDetailConditionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)fillCellWithText:(NSString *)condition
{
    self.conditionDesc.text = (condition.length > 0 ? condition : @"暂无");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
