//
//  MyAppViewController.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "MyAppViewController.h"
#import "MyAppHeaderView.h"
#import "MyAppTableViewCell.h"
#import "MyAppFooterView.h"
#import "ZSLoginViewController.h"
#import "RegistViewController.h"

static  NSString * const cellNameArray[] = {
    [0] = @"我的收藏",
    [1] = @"修改密码",
    [2] = @"关于",
    [3] = @"去评价",
    [4] = @"版本号",
};
@interface MyAppViewController ()
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

/*  */
@property (nonatomic, strong) MyAppHeaderView *headerView;

/*  */
@property (nonatomic, strong) MyAppFooterView *footerView;
@end

@implementation MyAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.title = @"我的";
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.tableHeaderView = self.headerView;
    self.baseTableView.tableFooterView = self.footerView;

    @weakify(self);
    [[self.headerView.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        ZSLoginViewController *loginVC = [[ZSLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }];

    [[self.headerView.registButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        RegistViewController *registVC = [[RegistViewController alloc] init];
        [self.navigationController pushViewController:registVC animated:YES];
    }];


    [self.baseTableView registerNib:[UINib nibWithNibName:@"MyAppTableViewCell" bundle:nil]
             forCellReuseIdentifier:myAppTableViewCell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAppTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myAppTableViewCell forIndexPath:indexPath];
    cell.nameLabel.text = cellNameArray[indexPath.row];
    return [[UITableViewCell alloc] init];
}


- (MyAppHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyAppHeaderView" owner:nil options:nil] lastObject];
    }
    return _headerView;
}

- (MyAppFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"MyAppFooterView" owner:nil options:nil] lastObject];

    }
    return _footerView;

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
