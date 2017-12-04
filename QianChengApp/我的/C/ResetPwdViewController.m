//
//  ResetPwdViewController.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/30.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "YanZhengLoginView.h"
#import "RegistYanZheng.h"
#import "ResetViewController.h"

@interface ResetPwdViewController ()
/*  */
@property (nonatomic, strong) YanZhengLoginView *resetPwdView;
@property (nonatomic,strong) UIButton *loginButton;
@property (assign, nonatomic) dispatch_queue_t queue;

@property (strong, nonatomic) dispatch_source_t timer;
/*  */
@property (nonatomic, strong) NSString *verify;
@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if (self.pushType == pushTypeForget) {
        self.navigationItem.title = @"忘记密码";
    } else {
        self.navigationItem.title = @"修改密码";
    }

    self.navigationItem.leftBarButtonItem = [self backButtonBar];

    [self.view addSubview:self.resetPwdView];
    [self.resetPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(95));
    }];

    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(155);
        make.size.mas_equalTo(CGSizeMake(289, 40));
    }];

    @weakify(self);
    [[[self.resetPwdView.getYanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        if (![self yanZhengMaCheck]) {
            return;
        }

        RegistYanZheng *request = [[RegistYanZheng alloc] initWithPhoneNum:self.resetPwdView.phone.text password:@"" type:@"2"];
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSDictionary *dic = request.responseObject;
            if ([dic[@"code"] integerValue] == 00) {
                [[ZSUntils getApplicationDelegate] saveUserInfo:dic[@"data"][@"sessionId"] userPhone:@"account"];
                //成功
                [self startTimer];
            }

        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        }];

    }];


    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if (![self yanZhengMaCheck]) {
            return;
        }

        if (self.resetPwdView.verify.text.length != 6) {
            [MBProgressHUD showError:@"请输入正确验证码" toView:self.view];
            return;
        }

        ResetViewController *vc = [[ResetViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}
- (void)startTimer
{
    self.resetPwdView.getYanBtn.enabled = NO;
    if (!self.resetPwdView.getYanBtn.enabled) {
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
                    [self.resetPwdView.getYanBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    self.resetPwdView.getYanBtn.enabled = YES;
                    //                    self.countDownButton.userInteractionEnabled = YES;
                });
            }else{
                NSInteger seconds = timeout;
                NSString *text = @"重新获取";

                NSString *strTime = [NSString stringWithFormat:@"%@(%ldS)",text,(long)seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.resetPwdView.getYanBtn setTitle:strTime forState:UIControlStateNormal];
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
    [self.resetPwdView.getYanBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.resetPwdView.getYanBtn.enabled = YES;
}
- (BOOL)yanZhengMaCheck
{
    if (self.resetPwdView.phone.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号" toView:self.view];
        return NO;
    }
    if (![ZSUntils mobileNumFormatCheck:self.resetPwdView.phone.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        return NO;
    }
    return YES;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.backgroundColor = [UIColor colorWithHexString:@"B22614"];
        [_loginButton setTitle:@"下一步" forState:UIControlStateNormal];
    }

    return _loginButton;
}

- (YanZhengLoginView *)resetPwdView
{
    if (!_resetPwdView) {
        _resetPwdView = [[[NSBundle mainBundle] loadNibNamed:@"YanZhengLoginView" owner:nil options:nil] lastObject];
    }
    return _resetPwdView;
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
