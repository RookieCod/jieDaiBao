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
    [self requestContentDaiKuan];
    [self.daiKuanView.daiKuanTable reloadData];

    [self.daiKuanView.daiKuanTable registerNib:[UINib nibWithNibName:@"DaiKuanTableViewCell" bundle:nil]
                        forCellReuseIdentifier:daiKuanCellIdentifier];
    [self.cardView.cardTable registerNib:[UINib nibWithNibName:@"HomeCardTableViewCell" bundle:nil] forCellReuseIdentifier:homeCardCellIdentifier];

    [[self.segmentView rac_newSelectedSegmentIndexChannelWithNilValue:@(self.segmentView.selectedSegmentIndex)] subscribeNext:^(NSNumber *x) {
        if ([x integerValue] == 0) {
            self.daiKuanView.hidden = NO;
            self.cardView.hidden = YES;

            [self requestContentDaiKuan];
            [self.daiKuanView.daiKuanTable reloadData];
        } else {
            self.daiKuanView.hidden = YES;
            self.cardView.hidden = NO;

            [self requestContentCard];
            [self.cardView.cardTable reloadData];
        }
    }];
}

- (void)requestContentDaiKuan
{
    CollectRequest *request = [[CollectRequest alloc] initWithCollectType:@(1)];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];
}

- (void)requestContentCard
{
    CollectRequest *request = [[CollectRequest alloc] initWithCollectType:@(2)];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

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
    } else {
        return [self homeCardCellWithTableView:tableView atIndexPath:indexPath];
    }
}

- (DaiKuanTableViewCell *)daiKuanCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    DaiKuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:daiKuanCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (HomeCardTableViewCell *)homeCardCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    HomeCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCardCellIdentifier forIndexPath:indexPath];

    return cell;
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
