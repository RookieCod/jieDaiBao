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

@interface ZSHomeViewController ()
<UITableViewDataSource,
UITableViewDelegate,
CycleScrollViewDelegate,
CycleScrollViewDatasource>
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;


/** bannerArray */
@property (nonatomic, strong) NSArray *bannerModelArray;


/** tableHeaderView */
@property (nonatomic, strong) CycleScrollView *tableHeaderView;
@end

@implementation ZSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"首页";
    [self requestContent];
    
    [self.baseTableView registerNib:[UINib nibWithNibName:@"HomeTangDouTableViewCell" bundle:nil] forCellReuseIdentifier:TangDouTableViewCell];
}


- (void)requestContent
{
    //顶部banner
    HomeRequest *request = [[HomeRequest alloc] init];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *bannerResponse = request.responseObject;
        if ([bannerResponse[@"code"] integerValue] == 00) {
            //请求成功
            self.bannerModelArray = [BannerModel mj_objectArrayWithKeyValuesArray:bannerResponse[@"data"][@"bannerList"]];
            if (self.bannerModelArray && self.bannerModelArray.count > 0) {
                [self reloadTableHeaderView];
                [self.baseTableView reloadData];
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
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
    [tempView sd_setImageWithURL:[NSURL URLWithString:bannerModel.bannerPic] placeholderImage:nil];
    return tempView;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    } else if (indexPath.section == 1) {
        return 80;
    } else {
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:TangDouTableViewCell forIndexPath:indexPath];
        HomeTangDouTableViewCell *tangdou = (HomeTangDouTableViewCell *)cell;
        //@weakify(self);
        [[tangdou.buttonClick takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(NSNumber *buttonTag) {
            //@strongify(self);
            NSInteger index = [buttonTag integerValue] - 1000;
            //根据index 判断跳转
        }];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
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
