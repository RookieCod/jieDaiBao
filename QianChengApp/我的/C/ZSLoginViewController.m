//
//  ZSLoginViewController.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSLoginViewController.h"

@interface ZSLoginViewController ()

@end

@implementation ZSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
