//
//  UIViewController+ButtonBarItem.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/24.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "UIViewController+ButtonBarItem.h"

@implementation UIViewController (ButtonBarItem)

- (UIBarButtonItem *)backButtonBar
{
    UIBarButtonItem *rbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"xiabai"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    return rbtn;
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
