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
@property (nonatomic, strong) NSArray *loanMoneyList;
@end

@implementation ZSDaiKuanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);

    //默认选择项
    selectedIndex = 1;
    self.navigationItem.title = @"贷款";
    self.request.money = @(0);
    self.request.sort = @(0);
    [self requestContent];
    [self initHeaderView];
    
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DaiKuanTableViewCell" bundle:nil] forCellReuseIdentifier:daiKuanCellIdentifier];
}

- (void)requestContent
{
    [self.request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *requestDic = request.responseObject;
        self.loanMoneyList = [LoanMoneyModel mj_objectArrayWithKeyValuesArray:requestDic[@"data"][@"loanMoneyList"]];
        [self initHeaderView];
        
        self.loanListArray = [DaiKuanModel mj_objectArrayWithKeyValuesArray:requestDic[@"data"][@"loanList"]];
        [self.baseTableView reloadData];
        
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
            make.top.equalTo(self.view).offset(64);
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
            [self createSelectViewWithCondition:@[@"100",@"200",@"400"]];
            [UIView animateWithDuration:1.5
                                  delay:0
                                options:0
                             animations:^{
                                 self.conditionView.height = conditionViewHeight;
                             } completion:^(BOOL finished) {
                                 
                             }];
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)createSelectViewWithCondition:(NSArray *)conditionArray
{
    [self.view addSubview:self.conditionView];
    for(UIView *view in [self.conditionView subviews])
    {
        [view removeFromSuperview];
    }
    self.conditionView.frame = CGRectMake(20, 0, MAINWIDTH - 40, 0);
    
    CGFloat originY = 20;
    for (int i = 0; i<conditionArray.count; i++) {
        NSString *condition = conditionArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        button.frame = CGRectMake(50, originY, 100, 20);
        [button setTitle:condition forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [[[button rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            UIButton *button = (UIButton *)x;
            NSLog(@"%d",button.tag- 100);
        }];
        
        [self.conditionView addSubview:button];
        
        originY += 20 + 7;
    }
    conditionViewHeight = originY;
    self.conditionView.frame = CGRectMake(20, 107, MAINWIDTH-40, 0);
    //[self.view insertSubview:self.conditionView belowSubview:self.segmentView];
}

- (UIView *)conditionView
{
    if (!_conditionView) {
        _conditionView = [[UIView alloc] init];
        _conditionView.backgroundColor = [UIColor lightGrayColor];
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
