//
//  ZSTabBarItemModel.h
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZSTabBarItemModel : NSObject

/** title */
@property (nonatomic, strong) NSString *title;

/** defaultIcon */
@property (nonatomic, strong) UIImage *defaultIcon;

/** selectedIcon */
@property (nonatomic, strong) UIImage *selectedIcon;

/** defaultColor */
@property (nonatomic, strong) UIColor *defaultColor;

/** selectedColor */
@property (nonatomic, strong) UIColor *selectedColor;

@end
