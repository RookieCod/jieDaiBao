//
//  ZSLoginViewController.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/28.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSLoginViewController.h"
#import "PasswordLoginView.h"
#import "YanZhengLoginView.h"
#import "LoginRequest.h"
#import "ResetPwdViewController.h"
#import "RegistYanZheng.h"

@interface ZSLoginViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;

/*  */
@property (nonatomic, strong) PasswordLoginView *pwdLogin;
/*  */
@property (nonatomic, strong) YanZhengLoginView *verifyLogin;

@property (nonatomic,strong) UIButton *loginButton;

/*  */
@property (nonatomic, strong) UITextField *phoneField;

/*  */
@property (nonatomic, strong) UITextField *pwdField;

@property (assign, nonatomic) dispatch_queue_t queue;

@property (strong, nonatomic) dispatch_source_t timer;

/*  */
@property (nonatomic, strong) UIButton *forgetButton;

@end

@implementation ZSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];

    [self initView];

    if (self.segmentView.selectedSegmentIndex == 0) {
        self.pwdLogin.hidden = NO;
        self.verifyLogin.hidden = YES;
    }


    @weakify(self);
    [[self.segmentView rac_newSelectedSegmentIndexChannelWithNilValue:@(self.segmentView.selectedSegmentIndex)] subscribeNext:^(NSNumber *x) {
        @strongify(self);
        MJExtensionLog(@"%@",x);
        switch ([x integerValue]) {
            case 0:
                self.verifyLogin.hidden = YES;
                self.pwdLogin.hidden = NO;
                break;
            case 1:
                self.pwdLogin.hidden = YES;
                self.verifyLogin.hidden = NO;
                break;
            default:
                break;
        }
    }];

    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        LoginRequest *request;
        if (self.segmentView.selectedSegmentIndex == 0) {
            request = [[LoginRequest alloc] initWithPhoneNum:self.pwdLogin.phone.text password:self.pwdLogin.pwd.text type:@"1"];
        } else {
            request = [[LoginRequest alloc] initWithPhoneNum:self.verifyLogin.phone.text password:self.verifyLogin.verify.text type:@"2"];
        }
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSDictionary *dic = request.responseObject;
            MJExtensionLog(@"%@",dic);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([dic[@"code"] integerValue] == 00) {
                [[ZSUntils getApplicationDelegate] saveUserInfo:dic[@"data"][@"sessionId"] userPhone:dic[@"data"][@"phone"]];
                [MBProgressHUD showSuccess:dic[@"errorMsg"] toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self back:nil];
                });
            }

        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        }];
    }];
}

- (void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initView
{
    [self.view addSubview:self.pwdLogin];
    [self.view addSubview:self.verifyLogin];
    [self.pwdLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_bottom).offset(5);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(95));;
    }];

    [self.verifyLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_bottom).offset(5);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(95));;

    }];

    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.pwdLogin.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(289, 40));
    }];

    [self.view addSubview:self.forgetButton];
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdLogin.mas_bottom).offset(120);
        make.right.equalTo(self.view.mas_right).offset(-43);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];

    self.pwdLogin.hidden = YES;
    self.verifyLogin.hidden = YES;
    @weakify(self);
    [[self.verifyLogin.getYanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (![self yanZhengMaCheck]) {
            return ;
        }

        RegistYanZheng *request = [[RegistYanZheng alloc] initWithPhoneNum:self.verifyLogin.phone.text
                    password:@""
                        type:@"3"];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSDictionary *dic = request.responseObject;
            [MBProgressHUD showMessage:dic[@"errorMsg"] toView:self.view];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        }];;


    }];

    [[self.forgetButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        ResetPwdViewController *resetVC = [[ResetPwdViewController alloc] init];
        [self.navigationController pushViewController:resetVC animated:YES];
    }];
}

- (BOOL)yanZhengMaCheck
{
    if (self.verifyLogin.phone.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:self.view];
        return NO;
    }
    if (![ZSUntils mobileNumFormatCheck:self.verifyLogin.phone.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return NO;
    }
    return YES;
}

- (void)startTimer
{
    self.verifyLogin.getYanBtn.enabled = NO;
    if (!self.verifyLogin.getYanBtn.enabled) {
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
                    [self.verifyLogin.getYanBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    self.verifyLogin.getYanBtn.enabled = YES;
                    //                    self.countDownButton.userInteractionEnabled = YES;
                });
            }else{
                NSInteger seconds = timeout;
                NSString *text = @"重新获取";

                NSString *strTime = [NSString stringWithFormat:@"%@(%ldS)",text,(long)seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.verifyLogin.getYanBtn setTitle:strTime forState:UIControlStateNormal];
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
    [self.verifyLogin.getYanBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.verifyLogin.getYanBtn.enabled = YES;
}

- (PasswordLoginView *)pwdLogin
{
    if (!_pwdLogin) {
        _pwdLogin = [[[NSBundle mainBundle] loadNibNamed:@"PasswordLoginView" owner:nil options:nil] lastObject];
    }
    return _pwdLogin;
}

- (YanZhengLoginView *)verifyLogin
{
    if (!_verifyLogin) {
        _verifyLogin = [[[NSBundle mainBundle] loadNibNamed:@"YanZhengLoginView" owner:nil options:nil] lastObject];
    }
    return _verifyLogin;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor colorWithHexString:@"B22614"];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }

    return _loginButton;
}

- (UIButton *)forgetButton
{
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _forgetButton.backgroundColor = [UIColor whiteColor];
        [_forgetButton setTitleColor:[UIColor colorWithHexString:@"B22614"] forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_forgetButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetButton.backgroundColor = [UIColor clearColor];
    }

    return _forgetButton;
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
