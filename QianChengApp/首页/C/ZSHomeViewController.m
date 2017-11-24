//
//  ZSHomeViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSHomeViewController.h"
#import "HomeRequest.h"
#import "BannerModel.h"
#import "CycleScrollView.h"
#import "HomeTangDouTableViewCell.h"
#import "HotDaiKuanRequest.h"
#import "HotXinYongRequest.h"
#import "DaiKuanModel.h"
#import "HomeCardModel.h"
#import "DaiKuanTableViewCell.h"
#import "HomeCardTableViewCell.h"
#import "ZSDaiKuanListViewController.h"

@interface ZSHomeViewController ()
<UITableViewDataSource,
UITableViewDelegate,
CycleScrollViewDelegate,
CycleScrollViewDatasource>
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;


/** bannerArray */
@property (nonatomic, strong) NSArray *bannerModelArray;

/** daikuanArray */
@property (nonatomic, strong) NSArray *daiKuanModelArray;

/** homeCardArray */
@property (nonatomic, strong) NSArray *homeCardModelArray;

/** tableHeaderView */
@property (nonatomic, strong) CycleScrollView *tableHeaderView;
@end

@implementation ZSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"首页";
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestContent];
    
    [self.baseTableView registerNib:[UINib nibWithNibName:@"HomeTangDouTableViewCell" bundle:nil] forCellReuseIdentifier:TangDouTableViewCell];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DaiKuanTableViewCell" bundle:nil]
             forCellReuseIdentifier:daiKuanCellIdentifier];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"HomeCardTableViewCell" bundle:nil]
             forCellReuseIdentifier:homeCardCellIdentifier];
}


- (void)requestContent
{
    //顶部banner
    HomeRequest *request1 = [[HomeRequest alloc] initWithSource:@(1)];
    HotDaiKuanRequest *request2 = [[HotDaiKuanRequest alloc] initWithType:1];
    HotXinYongRequest *request3 = [[HotXinYongRequest alloc] initWithType:1];
    
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[request1,request2,request3]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *requestArray = batchRequest.requestArray;
        
        HomeRequest *bannerRequest = requestArray[0];
        HotDaiKuanRequest *daikuanRequest = requestArray[1];
        HotXinYongRequest *xinYongRequest = requestArray[2];
        
        [self dealWithBannerResponse:bannerRequest.responseObject];
        [self dealWithDaiKuanResponse:daikuanRequest.responseObject];
        [self dealWithCardResponse:xinYongRequest.responseObject];
        
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)dealWithBannerResponse:(id)responseObj
{
    NSDictionary *responseDic = (NSDictionary *)responseObj;
    if ([responseDic[@"code"] integerValue] == 00) {
        self.bannerModelArray = [BannerModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"bannerList"]];
        
        if (self.bannerModelArray && self.bannerModelArray.count > 0) {
                [self reloadTableHeaderView];
        }
    } else {
        
    }
}

- (void)dealWithDaiKuanResponse:(id)responseObj
{
    NSDictionary *responseDic = (NSDictionary *)responseObj;
    if ([responseDic[@"code"] integerValue] == 00) {
        self.daiKuanModelArray = [DaiKuanModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"loanList"]];
        
        if (self.daiKuanModelArray && self.daiKuanModelArray.count > 0) {
            [self.baseTableView reloadData];
        }
    } else {
        
    }
}

- (void)dealWithCardResponse:(id)responseObj
{
    NSDictionary *responseDic = (NSDictionary *)responseObj;
    if ([responseDic[@"code"] integerValue] == 00) {
        self.homeCardModelArray = [HomeCardModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"cardList"]];
        
        if (self.homeCardModelArray && self.homeCardModelArray.count > 0) {
            [self.baseTableView reloadData];
        }
    } else {
        
    }
}

- (void)reloadTableHeaderView
{
    if (!self.baseTableView.tableHeaderView) {
        self.baseTableView.tableHeaderView = self.tableHeaderView;
    }
}

- (CycleScrollView *)tableHeaderView {
    if (!_tableHeaderView) {
        /**焦点图尺寸 375 * 150
         -
         */
        _tableHeaderView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 150*MAINWIDTH/375.0)];
        _tableHeaderView.delegate = self;
        _tableHeaderView.datasource = self;
        _tableHeaderView.indicateType = PageIndicateTypeLabel;
        UILabel *pageLabel = (UILabel *)[_tableHeaderView viewWithTag:10010];
        pageLabel.hidden = YES;
    }
    return _tableHeaderView;
}

#pragma mark CycleScrollViewDelegate
- (void)cycleView:(CycleScrollView *)cycleView didSelectPageAtIndex:(NSUInteger)index
{
    
}
- (void)cycleView:(CycleScrollView *)cycleView didShowPageAtIndex:(NSUInteger)index
{
    
}
#pragma mark CycleScrollViewDataSource
- (NSInteger)numberOfCycleScrollViewPage
{
    if (self.bannerModelArray && self.bannerModelArray.count > 0) {
        return self.bannerModelArray.count;
    }
    return 0;
}
- (UIView *)cycleView:(CycleScrollView *)cycleView pageAtIndex:(NSUInteger)index
{
    BannerModel *bannerModel = self.bannerModelArray[index];
    UIImageView *tempView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 150*MAINWIDTH/375.0)];
    tempView.backgroundColor = [UIColor lightGrayColor];
    [tempView sd_setImageWithURL:[NSURL URLWithString:bannerModel.bannerPic] placeholderImage:nil];
    return tempView;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.homeCardModelArray && self.daiKuanModelArray) {
        return 3;
    } else if (self.homeCardModelArray || self.daiKuanModelArray) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.homeCardModelArray && self.daiKuanModelArray) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return self.daiKuanModelArray.count;
        } else {
            return self.homeCardModelArray.count;
        }
    } else if (self.homeCardModelArray || self.daiKuanModelArray) {
        if (section == 0) {
            return 1;
        } else {
            return (self.daiKuanModelArray.count > 0) ? self.daiKuanModelArray.count : self.homeCardModelArray.count;
        }
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    } else if (indexPath.section == 1) {
        return 94;
    } else {
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.daiKuanModelArray && self.homeCardModelArray) {
        if (indexPath.section == 0) {
            return [self tangDouCellWithTableView:tableView AtIndexPath:indexPath];
        } else if (indexPath.section == 1) {
            return [self daiKuanCellWithTableView:tableView atIndexPath:indexPath];
        } else {
            return [self homeCardCellWithTableView:tableView atIndexPath:indexPath];
        }
    } else if (self.daiKuanModelArray || self.homeCardModelArray) {
        if (indexPath.section == 0) {
            return [self tangDouCellWithTableView:tableView AtIndexPath:indexPath];
        } else {
            if (self.daiKuanModelArray) {
                return [self daiKuanCellWithTableView:tableView atIndexPath:indexPath];
            } else {
                return [self homeCardCellWithTableView:tableView atIndexPath:indexPath];
            }
        }
    } else {
        return [self tangDouCellWithTableView:tableView AtIndexPath:indexPath];
    }
}

- (HomeTangDouTableViewCell *)tangDouCellWithTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    HomeTangDouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TangDouTableViewCell forIndexPath:indexPath];
    [[cell.buttonClick takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(NSNumber *buttonTag) {
        //@strongify(self);
        NSInteger index = [buttonTag integerValue] - 1000;
        //根据index 判断跳转
        [self pushNextVCWithIndex:index];
    }];
    return cell;
}

- (void)pushNextVCWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            self.hidesBottomBarWhenPushed = YES;
            ZSDaiKuanListViewController *daiKuanListVC = [[ZSDaiKuanListViewController alloc] init];
            [self.navigationController pushViewController:daiKuanListVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;

        }
            break;
            
        default:
            break;
    }
}

- (DaiKuanTableViewCell *)daiKuanCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    DaiKuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:daiKuanCellIdentifier forIndexPath:indexPath];
    DaiKuanModel *model = self.daiKuanModelArray[indexPath.row];
    cell.daiKuanModel = model;
    return cell;
}

- (HomeCardTableViewCell *)homeCardCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    HomeCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCardCellIdentifier forIndexPath:indexPath];
    HomeCardModel *cardModel = self.homeCardModelArray[indexPath.row];
    cell.cardModel = cardModel;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 29;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAINWIDTH, 26)];
    backView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:backView];

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.hidden = NO;
    titleLabel.textColor = [UIColor colorWithHexString:@"4A4A4A"];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    if (section == 1) {
        titleLabel.text = @"热门贷款推荐";
    } else if (section == 2) {
        titleLabel.text = @"热门信用卡推荐";
    }
    
    UIImageView *rightImage = [[UIImageView alloc] init];
    rightImage.hidden = NO;
    rightImage.userInteractionEnabled = YES;
    rightImage.image= [UIImage imageNamed:@"threePoint"];
    [headerView addSubview:titleLabel];
    [headerView addSubview:rightImage];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(20);
        make.top.bottom.equalTo(headerView);
    }];
    [rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView.mas_right).offset(-21);
        make.top.equalTo(headerView.mas_top).offset(9.5);
        make.size.mas_equalTo(CGSizeMake(24, 7));
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        if (section == 1) {
            self.hidesBottomBarWhenPushed = YES;
            ZSDaiKuanListViewController *daiKuan = [[ZSDaiKuanListViewController alloc] init];
            [self.navigationController pushViewController:daiKuan animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else {

        }
    }];
    [rightImage addGestureRecognizer:tap];

    if (section == 0) {
        titleLabel.hidden = YES;
        rightImage.hidden = YES;
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
