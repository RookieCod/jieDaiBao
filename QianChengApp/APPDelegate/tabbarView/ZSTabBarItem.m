//
//  ZSTabBarItem.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSTabBarItem.h"

@interface ZSTabBarItem()

/** itemModel */
@property (nonatomic, strong) ZSTabBarItemModel *itemModel;

@end

@implementation ZSTabBarItem

-(void)layoutSubviews{
    
    [super layoutSubviews];
    float topMargin = 6.f;
    float bottomMargin = 5.f;
    UILabel *titleLabel = self.titleLabel;
    UIImageView *iconView = self.imageView;
    iconView.bounds = CGRectMake(0, 0, 22, 22);
    titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, 14);
    
    iconView.center = CGPointMake(self.bounds.size.width/2, topMargin + iconView.bounds.size.height/2);
    titleLabel.center = CGPointMake(self.bounds.size.width/2,
                                    self.bounds.size.height - bottomMargin - /*titleLabel.bounds.size.height*/12/2);
}

-(void)configWithItemModel:(ZSTabBarItemModel*)model status:(BOOL)highlighted
{
    self.itemModel = model;
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    if (highlighted) {
        
        [self setTitleColor:[UIColor redColor]
                   forState:UIControlStateNormal];
        
//        if (model.selectIconImage) {
//            [self setImage:model.selectIconImage
//                  forState:UIControlStateNormal];
//        }else
//        {
//            [self setImageWithURLString:model.selectIcon
//                               forState:UIControlStateNormal];
//        }
        [self setImage:model.selectedIcon
              forState:UIControlStateNormal];
        
        [self setTitle:model.title
              forState:UIControlStateNormal];
    }else
    {
        [self setTitleColor:[UIColor blackColor]
                   forState:UIControlStateNormal];
        
//        if (model.iconImage) {
//            [self setImage:model.iconImage
//                  forState:UIControlStateNormal];
//
//        }else
//        {
//            [self setImageWithURLString:model.icon
//                               forState:UIControlStateNormal];
//        }
        [self setImage:model.defaultIcon
              forState:UIControlStateNormal];
        
        [self setTitle:model.title
              forState:UIControlStateNormal];
        
    }
}
-(void)setItemHighlighted:(BOOL)highlighted
{
    [self configWithItemModel:self.itemModel status:highlighted];
}


@end
