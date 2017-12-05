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
#import "RegistYanZheng.h"
#import "RegistFooterView.h"
#import "RegistRequest.h"
#import "ZSLoginViewController.h"
#import "WebViewController.h"

@interface RegistViewController ()

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

/*  */
@property (nonatomic, strong) UITextField *phoneNumField;

/*  */
@property (nonatomic, strong) UITextField *passwordField;

/*  */
@property (nonatomic, strong) UITextField *yanZhengField;

/*  */
@property (nonatomic, strong) UIButton *yanZhengButton;

@property (assign, nonatomic) dispatch_queue_t queue;

@property (strong, nonatomic) dispatch_source_t timer;

/*  */
@property (nonatomic, strong) RegistFooterView *footerView;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];

    self.baseTableView.tableFooterView = self.footerView;
    self.baseTableView.contentInset = UIEdgeInsetsMake(13, 0, 0, 0);
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:@"RegistCell" bundle:nil]
             forCellReuseIdentifier:registCell];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"RegistYanZhengCell" bundle:nil]
             forCellReuseIdentifier:registYanZhengCell];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopCountDown];
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
        self.phoneNumField = cell.inputField;
        [[cell.inputField rac_textSignal] subscribeNext:^(NSString *x) {
            MJExtensionLog(@"%@",x);
        }];
        return cell;
    } else if (indexPath.row == 1) {
        RegistCell *cell = [self registCellForTableView:tableView indexPath:indexPath];
        cell.leftLabel.text = @"登录密码";
        cell.rightImage.hidden = NO;
        cell.inputField.placeholder = @"请设置6-16位，包含数字和字符";
        cell.inputField.secureTextEntry = YES;
        self.passwordField = cell.inputField;
        [[cell.inputField rac_textSignal] subscribeNext:^(NSString *x) {
            MJExtensionLog(@"%@",x);
        }];
        return cell;
    } else {
        RegistYanZhengCell *cell = [self yanZhengCellForTableView:tableView indexPath:indexPath];
        self.yanZhengField = cell.yanZhengField;
        self.yanZhengButton = cell.getYanZhengBtn;
        [[[cell.getYanZhengBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(id x) {
            //验证手机号
            MJExtensionLog(@"%@",self.phoneNumField.text);

            if (![self check]) {
                return ;
            }
            //开始获取验证码
            [self requestContent];
        }];
        return cell;
    }
}

- (BOOL)check
{
    if (self.phoneNumField.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:self.view];
        return NO;
    }
    if (![ZSUntils mobileNumFormatCheck:self.phoneNumField.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return NO;
    }

    if ( [ZSUntils getStringIsSpace:self.passwordField.text]) {
        [MBProgressHUD showError:@"请输入正确密码格式" toView:self.view];
        return NO;
    }

    if (self.passwordField.text.length == 0) {
        [MBProgressHUD showError:@"请输入密码" toView:self.view];
        return NO;
    }
    if (self.passwordField.text.length < 6 || self.passwordField.text.length > 16) {
        [MBProgressHUD showError:@"密码长度必须为6-16位" toView:self.view];
        return NO;
    }

    return YES;
}

- (void)requestContent
{
    RegistYanZheng *request = [[RegistYanZheng alloc] initWithPhoneNum:self.phoneNumField.text password:self.passwordField.text type:@"1"];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        MJExtensionLog(@"%@",request.responseObject);
        NSDictionary *dic = request.responseObject;
        if ([dic[@"code"] integerValue] == 00) {
            [MBProgressHUD showSuccess:@"验证码已发送" toView:self.view];
            [self startTimer];
        } else {
            [MBProgressHUD showError:dic[@"errorMsg"] toView:self.view];

        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];
}

- (void)startTimer
{
    self.yanZhengButton.enabled = NO;
    if (!self.yanZhengButton.enabled) {
        __block NSInteger timeout = 60; //倒计时时间
        self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,self.queue);

        dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(self.timer, ^{
            if(timeout < 0){ //倒计时结束，关闭
                dispatch_source_cancel(self.timer);
                //                dispatch_release(self.timer);
                self.timer = nil;
                self.queue = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.yanZhengButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                    self.yanZhengButton.enabled = YES;
                    //                    self.countDownButton.userInteractionEnabled = YES;
                });
            }else{
                NSInteger seconds = timeout;
                NSString *text = @"重新获取";

                NSString *strTime = [NSString stringWithFormat:@"%@(%ldS)",text,(long)seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.yanZhengButton setTitle:strTime forState:UIControlStateNormal];
                });
                timeout--;
            }
        });
        dispatch_resume(self.timer);
    }
}

- (void)stopCountDown
{
    if (_timer)
    {
        dispatch_source_cancel(self.timer);

        self.timer = nil;
        self.queue = nil;
    }
    [self.yanZhengButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.yanZhengButton.enabled = YES;
}

- (RegistFooterView *)footerView
{
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"RegistFooterView" owner:nil options:nil] lastObject];
        @weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            self.hidesBottomBarWhenPushed = YES;
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.title = @"钱诚信贷宝服务协议";
            webVC.webUrl = @"http://106.75.84.49:8080/other/agreement.html";
            [self.navigationController pushViewController:webVC animated:YES];
        }];
        [_footerView addGestureRecognizer:tap];

        [[[_footerView.sureButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            @strongify(self);
            if ([self check] && (self.yanZhengField.text.length > 0)) {
                RegistRequest *request = [[RegistRequest alloc] initWithPhoneNum:self.phoneNumField.text
                                                                        password:self.passwordField.text verity:self.yanZhengField.text];
                [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    NSDictionary *responseDic = request.responseObject;
                    MJExtensionLog(@"dic = %@",responseDic);
                    if ([responseDic[@"code"] integerValue] == 00) {
                        [MBProgressHUD showSuccess:responseDic[@"errorMsg"] toView:self.view];

                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    } else {
                        [MBProgressHUD showError:responseDic[@"errorMsg"] toView:self.view];
                    }
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

                }];
                return ;
            };
        }];
    }
    return _footerView;
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
