//
//  ZSDaiKuanListViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSDaiKuanListViewController.h"
#import "DaiKuanTableViewCell.h"
#import "ZSSegmentView.h"
#import "DaiKuanListRequest.h"
#import "DaiKuanModel.h"
#import "LoanMoneyModel.h"
#import "ZDDaiKuanDetailViewController.h"

@interface ZSDaiKuanListViewController ()
<UITableViewDelegate,
UITableViewDataSource,
ZSSegmentViewDelegate>

{
    NSInteger selectedIndex;
    CGFloat conditionViewHeight;
}

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

/** headView */
@property (nonatomic, strong) ZSSegmentView *segmentView;

/** conditionView */
@property (nonatomic, strong) UIView *conditionView;

/** request */
@property (nonatomic, strong) DaiKuanListRequest *request;

/** loanList */
@property (nonatomic, strong) NSArray *loanListArray;

/** loanMoneyList */
@property (nonatomic, strong) NSMutableArray *loanMoneyList;
@end

@implementation ZSDaiKuanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);


    //默认选择项
    selectedIndex = 0;
    self.navigationItem.title = @"贷款";
    self.request.money = @"0";
    self.request.sort = @"0";
    [self requestContent];
    [self initHeaderView];
    
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DaiKuanTableViewCell" bundle:nil] forCellReuseIdentifier:daiKuanCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.pushType == DaiKuanListPushTyeFromHome) {
        self.navigationItem.leftBarButtonItem = [self backButtonBar];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.conditionView.hidden = YES;
}

- (void)requestContent
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *requestDic = request.responseObject;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([requestDic[@"code"] integerValue] == 00) {
            self.loanMoneyList = (NSMutableArray *)[LoanMoneyModel mj_objectArrayWithKeyValuesArray:requestDic[@"data"][@"loanMoneyList"]];
            [self.loanMoneyList insertObject:@"不限" atIndex:0];
            [self initHeaderView];

            self.loanListArray = [DaiKuanModel mj_objectArrayWithKeyValuesArray:requestDic[@"data"][@"loanList"]];
            [self.baseTableView reloadData];
        } else {
            [MBProgressHUD showError:requestDic[@"errorMsg"] toView:self.view];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (DaiKuanListRequest *)request
{
    if (!_request) {
        _request = [[DaiKuanListRequest alloc] init];
    }
    return _request;
}

- (void)initHeaderView
{
    if (self.loanMoneyList) {
        [self.view addSubview:self.segmentView];
        [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.top.equalTo(self.view.mas_top);
        }];
    }
}

- (ZSSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [[[NSBundle mainBundle] loadNibNamed:@"ZSSegmentView" owner:nil options:nil] lastObject];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

#pragma mark - ZSSegmentViewDelegate
- (void)selectedSegmentView:(ZSSegmentView *)view atIndex:(NSInteger)index
{
    switch (index) {
        case 1:
        {
            if (selectedIndex != 1) {

                self.conditionView.hidden = NO;
                [self.segmentView reloadSubview:1];

            } else {
                self.conditionView.hidden = !self.conditionView.hidden;
                if (self.conditionView.isHidden == YES) {
                    [self.segmentView.leftButton setImage:[UIImage imageNamed:@"shangbai"] forState:UIControlStateNormal];
                } else {
                    [self.segmentView.leftButton setImage:[UIImage imageNamed:@"xiabai"] forState:UIControlStateNormal];
                }
            }
            selectedIndex = 1;

            [self createSelectViewWithCondition:self.loanMoneyList index:1];
        }
            break;
        case 2:
        {

            if (selectedIndex != 2) {
                [self.segmentView reloadSubview:2];
                self.conditionView.hidden = NO;
            } else {
                self.conditionView.hidden = !self.conditionView.hidden;
                if (self.conditionView.isHidden == YES) {
                    [self.segmentView.rightButton setImage:[UIImage imageNamed:@"shangbai"] forState:UIControlStateNormal];
                } else {
                    [self.segmentView.rightButton setImage:[UIImage imageNamed:@"xiabai"] forState:UIControlStateNormal];
                }
            }
            selectedIndex = 2;

            [self createSelectViewWithCondition:@[@"不限",@"额度",@"利率"] index:2];



        }
            break;
        default:
            break;
    }
}

- (void)createSelectViewWithCondition:(NSArray *)conditionArray index:(NSInteger)index
{
    [self.view addSubview:self.conditionView];
    for(UIView *view in [self.conditionView subviews])
    {
        [view removeFromSuperview];
    }    
    CGFloat originY = 20;
    for (int i = 0; i < conditionArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        if (index == 1) {
            if (i == 0) {
                [button setTitle:conditionArray[i] forState:UIControlStateNormal];
            } else {
                LoanMoneyModel *model = conditionArray[i];
                [button setTitle:[NSString stringWithFormat:@"%@",model.loanMoneyMax] forState:UIControlStateNormal];
            }

        } else {
            NSString *condition = conditionArray[i];
            [button setTitle:condition forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [[[button rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            UIButton *button = (UIButton *)x;
            NSInteger index = button.tag - 100;
            if (selectedIndex == 1) {
                LoanMoneyModel *model = conditionArray[index];
                if (index == 0) {
                    self.request.money = @"0";
                    [self.segmentView reloadTitle:@"可贷额度" index:1];
                } else {
                    self.request.money = [NSString stringWithFormat:@"%@",model.loanMoneyMax];
                    [self.segmentView reloadTitle:[NSString stringWithFormat:@"%@",model.loanMoneyMax] index:1];
                }
                self.request.sort = @"0";
            } else {
                self.request.money = @"0";
                self.request.sort = [NSString stringWithFormat:@"%ld",(long)index];
                if (index == 0) {
                    [self.segmentView reloadTitle:@"默认排序" index:2];
                } else {
                    [self.segmentView reloadTitle:conditionArray[index] index:2];
                }
            }

            self.conditionView.hidden = YES;
            [self requestContent];
        }];
        
        [self.conditionView addSubview:button];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.conditionView.mas_top).offset(originY);
            make.centerX.equalTo(self.conditionView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];

        originY += 20 + 7;
    }
    conditionViewHeight = originY;
    self.conditionView.frame = CGRectMake(20, 30, MAINWIDTH - 40, originY);
    //[self.view insertSubview:self.conditionView belowSubview:self.segmentView];
}

- (UIView *)conditionView
{
    if (!_conditionView) {
        _conditionView = [[UIView alloc] init];
        _conditionView.backgroundColor = [UIColor colorWithHexString:@"FBFBFB"];
        _conditionView.hidden = YES;
    }
    return _conditionView;
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.loanListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return (UITableViewCell *)[self daiKuanCellWithTableView:tableView atIndexPath:indexPath];
}

- (DaiKuanTableViewCell *)daiKuanCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    DaiKuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:daiKuanCellIdentifier forIndexPath:indexPath];
    DaiKuanModel *model = self.loanListArray[indexPath.row];
    cell.daiKuanModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转
    self.hidesBottomBarWhenPushed = YES;
    ZDDaiKuanDetailViewController *detailVC = [[ZDDaiKuanDetailViewController alloc] init];
    DaiKuanModel *daikuanModel = self.loanListArray[indexPath.row];
    detailVC.loanId = [NSString stringWithFormat:@"%@",daikuanModel.loanId];
    [self.navigationController pushViewController:detailVC animated:YES];
    if (self.pushType == DaiKuanListPushTyeFromTab) {
        self.hidesBottomBarWhenPushed = NO;
    }
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
