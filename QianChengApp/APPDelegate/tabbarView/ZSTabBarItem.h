//
//  ZSTabBarItem.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSTabBarItemModel.h"

@interface ZSTabBarItem : UIButton

-(void)configWithItemModel:(ZSTabBarItemModel*)model status:(BOOL)highlighted;

-(void)setItemHighlighted:(BOOL)highlighted;

@end
