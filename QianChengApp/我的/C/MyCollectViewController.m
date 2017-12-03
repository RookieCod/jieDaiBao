//
//  MyCollectViewController.m
//  QianChengApp
//
//  Created by 张松 on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "MyCollectViewController.h"
#import "CollectDaiKuanView.h"
#import "CollectCardView.h"
#import "DaiKuanTableViewCell.h"
#import "HomeCardTableViewCell.h"
#import "CollectRequest.h"
#import "LoanCollectList.h"
#import "CardCollectList.h"
#import "DaiKuanModel.h"
#import "HomeCardModel.h"
#import "ZDDaiKuanDetailViewController.h"
#import "ZSCardDetailViewController.h"

@interface MyCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentView;

/*  */
@property (nonatomic, strong) CollectCardView *cardView;
/*  */
@property (nonatomic, strong) CollectDaiKuanView *daiKuanView;

/*  */
@property (nonatomic, strong) NSArray *daiKuanArray;

/*  */
@property (nonatomic, strong) NSArray *cardArray;
@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.title = @"我的收藏";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];

    [self initView];
    self.daiKuanView.hidden = NO;
    self.cardView.hidden = YES;

    [self.daiKuanView.daiKuanTable registerNib:[UINib nibWithNibName:@"DaiKuanTableViewCell" bundle:nil]
                        forCellReuseIdentifier:daiKuanCellIdentifier];
    [self.cardView.cardTable registerNib:[UINib nibWithNibName:@"HomeCardTableViewCell" bundle:nil] forCellReuseIdentifier:homeCardCellIdentifier];

    [[self.segmentView rac_newSelectedSegmentIndexChannelWithNilValue:@(self.segmentView.selectedSegmentIndex)] subscribeNext:^(NSNumber *x) {
        if ([x integerValue] == 0) {
            self.daiKuanView.hidden = NO;
            self.cardView.hidden = YES;

            [self requestContentDaiKuan];
        } else {
            self.daiKuanView.hidden = YES;
            self.cardView.hidden = NO;

            [self requestContentCard];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.segmentView.selectedSegmentIndex == 0) {
        [self requestContentDaiKuan];
    } else {
        [self requestContentCard];
    }
}

- (void)requestContentDaiKuan
{
    LoanCollectList *request = [[LoanCollectList alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dic = request.responseObject;
        MJExtensionLog(@"%@",dic);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dic[@"code"] integerValue] == 00) {
            self.daiKuanArray = [DaiKuanModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"loanList"]];
            [self.daiKuanView.daiKuanTable reloadData];
        } else {
            [MBProgressHUD showError:dic[@"errorMsg"] toView:self.view];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        MJExtensionLog(@"%@",request);

    }];
}

- (void)requestContentCard
{
    CardCollectList *request = [[CardCollectList alloc] init];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dic = request.responseObject;
        MJExtensionLog(@"%@",dic);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dic[@"code"] integerValue] == 00) {
            self.cardArray = [HomeCardModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"cardList"]];
            [self.cardView.cardTable reloadData];
        } else {
            [MBProgressHUD showError:dic[@"errorMsg"] toView:self.view];

        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        MJExtensionLog(@"%@",request);
    }];
}

- (void)initView
{
    [self.view addSubview:self.daiKuanView];
    [self.daiKuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self.view);
    }];

    [self.view addSubview:self.cardView];
    [self.cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.mas_bottom).offset(10);
        make.left.right.bottom.equalTo(self.view);

    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.daiKuanView.daiKuanTable) {
        return self.daiKuanArray.count;
    } else {
        return self.cardArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.daiKuanView.daiKuanTable) {
        return 94;
    } else {
        return 80;
    }}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.daiKuanView.daiKuanTable) {
        return [self daiKuanCellWithTableView:tableView  atIndexPath:indexPath];
    } else if (tableView == self.cardView.cardTable){
        return [self homeCardCellWithTableView:tableView atIndexPath:indexPath];
    }
    return nil;
}

- (DaiKuanTableViewCell *)daiKuanCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    DaiKuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:daiKuanCellIdentifier forIndexPath:indexPath];
    cell.daiKuanModel = self.daiKuanArray[indexPath.row];
    return cell;
}

- (HomeCardTableViewCell *)homeCardCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    HomeCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCardCellIdentifier forIndexPath:indexPath];
    cell.cardModel = self.cardArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.daiKuanView.daiKuanTable) {
        self.hidesBottomBarWhenPushed = YES;
        ZDDaiKuanDetailViewController *daiKuanDetail = [[ZDDaiKuanDetailViewController alloc] init];
        DaiKuanModel *model = [self.daiKuanArray objectAtIndex:indexPath.row];
        daiKuanDetail.loanId = [NSString stringWithFormat:@"%@",model.loanId];
        [self.navigationController pushViewController:daiKuanDetail animated:YES];
    } else {
        self.hidesBottomBarWhenPushed = YES;
        ZSCardDetailViewController *cardDetail =[[ZSCardDetailViewController alloc] init];
        HomeCardModel *model = self.cardArray[indexPath.row];
        cardDetail.cardid = model.cardId;
        [self.navigationController pushViewController:cardDetail animated:YES];
    }
}

- (CollectDaiKuanView *)daiKuanView
{
    if (!_daiKuanView) {
        _daiKuanView = [[[NSBundle mainBundle] loadNibNamed:@"CollectDaiKuanView" owner:nil options:nil] lastObject];
        _daiKuanView.daiKuanTable.delegate = self;
        _daiKuanView.daiKuanTable.dataSource = self;
        _daiKuanView.daiKuanTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _daiKuanView;
}

- (CollectCardView *)cardView
{
    if (!_cardView) {
        _cardView = [[[NSBundle mainBundle] loadNibNamed:@"CollectCardView" owner:nil options:nil] lastObject];
        _cardView.cardTable.delegate = self;
        _cardView.cardTable.dataSource = self;
        _cardView.cardTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _cardView;
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
