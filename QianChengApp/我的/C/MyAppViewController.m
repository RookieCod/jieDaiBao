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
#import "ResetPwdViewController.h"
#import "ReloginRequest.h"
#import "AboutViewController.h"
#import "MyCollectViewController.h"
#import "WebViewController.h"

static  NSString * const cellNameArray[] = {
    [0] = @"我的收藏",
    [1] = @"修改密码",
    [2] = @"关于",
    [3] = @"版本号",
};
@interface MyAppViewController ()<UITableViewDelegate,UITableViewDataSource>
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
    //self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.tableHeaderView = self.headerView;
    self.baseTableView.tableFooterView = self.footerView;

    @weakify(self);
    [[self.headerView.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        ZSLoginViewController *loginVC = [[ZSLoginViewController alloc] init];
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNav
                           animated:YES
                         completion:nil];
    }];

    [[self.headerView.registButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        RegistViewController *registVC = [[RegistViewController alloc] init];
        [self.navigationController pushViewController:registVC animated:YES];
    }];


    [self.baseTableView registerNib:[UINib nibWithNibName:@"MyAppTableViewCell" bundle:nil]
             forCellReuseIdentifier:myAppTableViewCell];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadHeaderAndFooter];
}

- (void)reloadHeaderAndFooter
{
    if ([ZSUntils getApplicationDelegate].userSession.length > 0) {
        //登录状态
        self.headerView.loginButton.hidden = YES;
        self.headerView.registButton.hidden = YES;
        self.headerView.phoneNumLabel.hidden = NO;
        self.headerView.phoneNumLabel.text = [ZSUntils getApplicationDelegate].userPhone;
        
        self.baseTableView.tableFooterView = self.footerView;
    } else {
        self.headerView.loginButton.hidden = NO;
        self.headerView.registButton.hidden = NO;
        self.headerView.phoneNumLabel.hidden = YES;
        
        self.baseTableView.tableFooterView = nil;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAppTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myAppTableViewCell forIndexPath:indexPath];
    cell.nameLabel.text = cellNameArray[indexPath.row];

    if (indexPath.row == 3) {
        cell.rightImage.hidden = YES;
        cell.versionLabel.hidden = NO;
    } else {
        cell.rightImage.hidden = NO;
        cell.versionLabel.hidden = YES;
    }


    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[[tap rac_gestureSignal] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
        if (indexPath.row == 0) {
            //收藏
            if ([ZSUntils isNeedToUserLogin:nil]) {
                return ;
            }

            self.hidesBottomBarWhenPushed = YES;
            MyCollectViewController *collection = [[MyCollectViewController alloc] init];
            [self.navigationController pushViewController:collection animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else if (indexPath.row == 1) {
            //修改密码
            if ([ZSUntils isNeedToUserLogin:nil]) {
                return ;
            }
            self.hidesBottomBarWhenPushed = YES;
            ResetPwdViewController *reset = [[ResetPwdViewController alloc] init];
            reset.pushType = pushTypeForget;
            [self.navigationController pushViewController:reset animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else if (indexPath.row == 2) {
            self.hidesBottomBarWhenPushed = YES;
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.title = @"关于";
            webVC.webUrl = @"";
            [self.navigationController pushViewController:webVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } 
    }];
    [cell addGestureRecognizer:tap];
    return cell;
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
        [[_footerView.reLoginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                     message:@"退出登录"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            //取消:style:UIAlertActionStyleCancel
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyle)UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                ReloginRequest *request = [[ReloginRequest alloc] init];
                [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    NSDictionary *dic = request.responseObject;
                    [MBProgressHUD showMessage:dic[@"errorMsg"] toView:self.view];
                    if ([dic[@"code"] integerValue] == 00) {
                        [[ZSUntils getApplicationDelegate] clearUserInfo];

                        [self reloadHeaderAndFooter];
                    }
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

                }];
            }];
            [alertController addAction:okAction];

            [self presentViewController:alertController animated:YES completion:nil];
        }];

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
