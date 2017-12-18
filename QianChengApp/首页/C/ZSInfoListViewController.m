//
//  ZSInfoListViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSInfoListViewController.h"
#import "InfoDetailViewController.h"
#import "HomeCardTableViewCell.h"
#import "InfoList.h"
#import "InfoListModel.h"

@interface ZSInfoListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

/** moxing */
@property (nonatomic, strong) NSArray *listArray;
@end

@implementation ZSInfoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"资讯";
    self.hidesBottomBarWhenPushed = NO;
    
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.baseTableView registerNib:[UINib nibWithNibName:@"HomeCardTableViewCell" bundle:nil]
             forCellReuseIdentifier:homeCardCellIdentifier];
    [self requestContent];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.pushType == infoVCPushTypeFromHome) {
        self.navigationItem.leftBarButtonItem = [self backButtonBar];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)requestContent
{
    InfoList *request = [[InfoList alloc] initWithType:@"2"];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dic = request.responseObject;
        MJExtensionLog(@"dic = %@",dic);
        //模型
        if ([dic[@"code"] integerValue] == 00) {
            self.listArray = [InfoListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"informationList"]];
            [self.baseTableView reloadData];

        } else {
            [MBProgressHUD showError:dic[@"errorMsg"] toView:self.view];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self homeCardCellWithTableView:tableView atIndexPath:indexPath];
}

- (HomeCardTableViewCell *)homeCardCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    HomeCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCardCellIdentifier forIndexPath:indexPath];
    InfoListModel *cardModel = self.listArray[indexPath.row];
    cell.infoListModel = cardModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InfoDetailViewController *infoDetail = [[InfoDetailViewController alloc] init];
    InfoListModel *model = self.listArray[indexPath.row];
    infoDetail.infoId = model.informationId;
    
    [self.navigationController pushViewController:infoDetail animated:YES];
    
    if (self.pushType == infoVCPushTypeFromTab) {
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
