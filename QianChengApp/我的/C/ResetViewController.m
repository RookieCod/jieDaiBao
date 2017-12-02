//
//  ResetViewController.m
//  QianChengApp
//
//  Created by 张松 on 2017/11/30.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ResetViewController.h"
#import "ForgetResetPwdRequest.h"

@interface ResetViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mima1Field;
@property (weak, nonatomic) IBOutlet UITextField *mima2Field;
@property (weak, nonatomic) IBOutlet UIImageView *yanjing1Image;
@property (weak, nonatomic) IBOutlet UIImageView *yanjing2Image;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation ResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设置新密码";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];

    @weakify(self);
    [[self.sureButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        //校验密码
        if ([ZSUntils getStringIsSpace:self.mima1Field.text] || self.mima1Field.text.length < 6 || self.mima1Field.text.length > 16) {
            [MBProgressHUD showError:@"密码格式不正确" toView:self.view];
            return ;
        }

        if (![_mima1Field.text isEqualToString:_mima2Field.text]) {
            [MBProgressHUD showError:@"两次输入的密码不一样" toView:self.view];
            return;
        }

        //请求接口
        ForgetResetPwdRequest *requst = [[ForgetResetPwdRequest alloc] initWithSessionId:[ZSUntils getApplicationDelegate].userSession newsPwd:self.mima1Field.text];
        [requst startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSDictionary *dic = requst.responseObject;
            if ([dic[@"code"] integerValue] == 00) {
                //修改成功
                [MBProgressHUD showSuccess:dic[@"errorMsg"] toView:self.view];
                [[ZSUntils getApplicationDelegate] clearUserInfo];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            } else {
                [MBProgressHUD showError:dic[@"errorMsg"] toView:self.view];
            }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

        }];


    }];

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
