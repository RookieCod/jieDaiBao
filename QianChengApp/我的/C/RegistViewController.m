//
//  RegistViewController.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "RegistViewController.h"
#import "RegistCell.h"
#import "RegistYanZhengCell.h"

@interface RegistViewController ()

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];

    self.baseTableView.contentInset = UIEdgeInsetsMake(13, 0, 0, 0);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:@"RegistCell" bundle:nil]
             forCellReuseIdentifier:registCell];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"RegistYanZhengCell" bundle:nil]
             forCellReuseIdentifier:registYanZhengCell];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RegistCell *cell = [self registCellForTableView:tableView indexPath:indexPath];
        cell.leftLabel.text = @"手机号";
        cell.rightImage.hidden = YES;
        cell.inputField.placeholder = @"请输入手机号码";
        cell.inputField.keyboardType = UIKeyboardTypeNumberPad;
        [[cell.inputField rac_textSignal] subscribeNext:^(NSString *x) {
            MJExtensionLog(@"%@",x);
        }];
        return cell;
    } else if (indexPath.row == 1) {
        RegistCell *cell = [self registCellForTableView:tableView indexPath:indexPath];
        cell.leftLabel.text = @"登录密码";
        cell.rightImage.hidden = NO;
        cell.inputField.placeholder = @"请设置6-16位，包含数字和字符";
        [[cell.inputField rac_textSignal] subscribeNext:^(NSString *x) {
            MJExtensionLog(@"%@",x);
        }];
        return cell;
    } else {
        RegistYanZhengCell *cell = [self yanZhengCellForTableView:tableView indexPath:indexPath];
        return cell;
    }
}

- (RegistCell *)registCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:registCell forIndexPath:indexPath];
}

- (RegistYanZhengCell *)yanZhengCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:registYanZhengCell forIndexPath:indexPath];
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
