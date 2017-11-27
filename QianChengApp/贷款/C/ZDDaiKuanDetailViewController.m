//
//  ZDDaiKuanDetailViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/24.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZDDaiKuanDetailViewController.h"
#import "DaiKuanDetailRequest.h"
#import "DaiDetailProductCell.h"
#import "DaiDetailInfoCell.h"
#import "DaiDetailJiSuanCell.h"
#import "DaiDetailConditionCell.h"
#import "DaiDetailModel.h"

@interface ZDDaiKuanDetailViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

/* 网络请求 */
@property (nonatomic, strong) DaiKuanDetailRequest *netRequest;

/* <##> */
@property (nonatomic, strong) DaiDetailModel *detailModel;

/*  */
@property (nonatomic, strong) UITextField *moneyField;

/* <##> */
@property (nonatomic, strong) NSArray *loanTermArray;

@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *totalLixi;
@end

@implementation ZDDaiKuanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"贷款详情";
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    self.navigationItem.leftBarButtonItem = [self backButtonBar];

    self.totalMoney = @"0";
    self.totalLixi = @"0.00";

    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.contentInset = UIEdgeInsetsMake(3, 0, 0, 0);
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DaiDetailProductCell" bundle:nil]
             forCellReuseIdentifier:detailProductCell];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DaiDetailInfoCell" bundle:nil]
             forCellReuseIdentifier:detailInfoCell];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DaiDetailJiSuanCell" bundle:nil]
             forCellReuseIdentifier:detailJiSuanCell];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DaiDetailConditionCell" bundle:nil]
             forCellReuseIdentifier:detailConditionCell];

    [self requestContent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)requestContent
{
    DaiKuanDetailRequest *request = [[DaiKuanDetailRequest alloc] initWithLoanId:self.loanId];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *responseDic = request.responseObject;
        if ([responseDic[@"code"] integerValue] == 00) {
            NSDictionary *dic = responseDic[@"data"][@"loanDtail"];
            self.detailModel = [DaiDetailModel mj_objectWithKeyValues:dic];
            self.loanTermArray = [self.detailModel.loanTerm componentsSeparatedByString:@"-"];
            [self.baseTableView reloadData];
            MJExtensionLog(@"%@",self.detailModel);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];
}

- (DaiKuanDetailRequest *)netRequest
{
    if (!_netRequest) {
        _netRequest = [[DaiKuanDetailRequest alloc] init];
    }
    return _netRequest;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 83;
    } else if (indexPath.row == 1) {
        return 75;
    } else if (indexPath.row == 2) {
        return 185;
    } else {
        return 68;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [self productCellWithTableView:tableView indexPath:indexPath];
    } else if (indexPath.row == 1)
    {
        return [self infoCellWithTableView:tableView indexPath:indexPath];
    } else if (indexPath.row == 2) {
        return [self jiSuanCellWithTableView:tableView indexPath:indexPath];
    } else {
        DaiDetailConditionCell *cell = [self conditionCellWithTableView:tableView indexPath:indexPath];
        if (indexPath.row == 3) {
            cell.condiLabel.text = @"放款时间";
            [cell fillCellWithText:self.detailModel.loanPermit];
        } else if (indexPath.row == 4) {
            cell.condiLabel.text = @"申请条件";
            [cell fillCellWithText:self.detailModel.loanCondition];
        } else {
            cell.condiLabel.text = @"产品备注";
            [cell fillCellWithText:self.detailModel.loanRemark];
        }
        return cell;
    }
}

- (DaiDetailProductCell *)productCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DaiDetailProductCell *cell = [tableView dequeueReusableCellWithIdentifier:detailProductCell forIndexPath:indexPath];
    cell.model = self.detailModel;
    return cell;
}

- (DaiDetailInfoCell *)infoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DaiDetailInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:detailInfoCell forIndexPath:indexPath];
    infoCell.model = self.detailModel;
    return infoCell;
}

- (DaiDetailJiSuanCell *)jiSuanCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DaiDetailJiSuanCell *cell = [tableView dequeueReusableCellWithIdentifier:detailJiSuanCell forIndexPath:indexPath];
    cell.JinField.delegate = self;
    self.moneyField = cell.JinField;
    [cell reloadMoneyWithTotal:self.totalMoney liXi:self.totalLixi];
    [[[cell.JinField rac_textSignal] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(NSString *x) {
        MJExtensionLog(@"%@",x);
        if ([x integerValue] > [self.detailModel.loanMoneyMax integerValue]) {
            self.moneyField.text = [NSString stringWithFormat:@"%@",self.detailModel.loanMoneyMax];
            [MBProgressHUD showError:@"超出了最大贷款金额"];
            return ;
        }
        self.totalLixi = [NSString stringWithFormat:@"%.2f",[x floatValue] * [self.detailModel.loanRate floatValue]];
        self.totalMoney = [NSString stringWithFormat:@"%.2f",[self.moneyField.text floatValue] + [self.totalLixi floatValue]];
        [cell reloadMoneyWithTotal:self.totalMoney liXi:self.totalLixi];
    }];

    [cell.tapSubject subscribeNext:^(id x) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择贷款期限"
                                                                                 message:nil
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        //取消:style:UIAlertActionStyleCancel
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];

        for (int i = 0; i < self.loanTermArray.count; i++) {
            NSString *str = self.loanTermArray[i];
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (i == 0) {

                    self.totalMoney = [NSString stringWithFormat:@"%.2f",[self.moneyField.text floatValue] + [self.totalLixi floatValue]];
                    cell.qiXianLabel.text = self.loanTermArray[0];
                } else {
                    cell.qiXianLabel.text = self.loanTermArray[1];
                }
                [cell reloadMoneyWithTotal:self.totalMoney liXi:self.totalLixi];
            }];
            [alertController addAction:OKAction];
        }

        [self presentViewController:alertController animated:YES completion:nil];

    }];

    cell.model = self.detailModel;

    return cell;
}

- (DaiDetailConditionCell *)conditionCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DaiDetailConditionCell *cell = [tableView dequeueReusableCellWithIdentifier:detailConditionCell forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转
    self.hidesBottomBarWhenPushed = YES;

}

#pragma mark UITextField
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 0 && [string isEqualToString:@"0"]) {
        [MBProgressHUD showError:@"金额不能为0元哦" toView:self.view];
        return NO;
    }
    return YES;
}

- (IBAction)collectButtonClick:(id)sender {

}

- (IBAction)applyButtonClick:(id)sender {
    
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
