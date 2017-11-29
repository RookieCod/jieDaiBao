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
        self.phoneField = self.pwdLogin.phone;
        self.pwdField = self.pwdLogin.pwd;
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
        LoginRequest *request = [[LoginRequest alloc] initWithPhoneNum:self.phoneField.text password:self.pwdField.text type:[NSString stringWithFormat:@"%ld",self.segmentView.selectedSegmentIndex + 1]];
        [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSDictionary *dic = request.responseObject;
            MJExtensionLog(@"%@",dic);
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        }];
    }];
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

    self.pwdLogin.hidden = YES;
    self.verifyLogin.hidden = YES;
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
