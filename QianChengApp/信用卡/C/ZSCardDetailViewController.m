//
//  ZSCardDetailViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/24.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSCardDetailViewController.h"
#import "CardDetailRequest.h"
#import "CardDetailModel.h"
#import "HomeCardTableViewCell.h"
#import "DetailTwoCell.h"
#import "CardDetailThreeCell.h"
#import "CardDetailFourCell.h"

@interface ZSCardDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

/** model */
@property (nonatomic, strong) CardDetailModel *detailModel;
@end

@implementation ZSCardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"信用卡详情";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];

    self.baseTableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);

    [self requestContent];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"HomeCardTableViewCell" bundle:nil] forCellReuseIdentifier:homeCardCellIdentifier];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DetailTwoCell" bundle:nil]
             forCellReuseIdentifier:detailTwoCell];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"CardDetailThreeCell" bundle:nil]
             forCellReuseIdentifier:cardDetailThreeCell];
    [self.baseTableView registerNib:[UINib nibWithNibName:@"CardDetailFourCell" bundle:nil]
             forCellReuseIdentifier:cardDetailFourCell];
}

- (void)requestContent
{
    CardDetailRequest *request = [[CardDetailRequest alloc] initWithBank:self.cardid];
    
    [MBProgressHUD showHUDAddedTo:self.view
                         animated:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *responseDic = request.responseObject;
        if ([responseDic[@"code"] integerValue] == 00) {
            NSDictionary *detailDic = responseDic[@"data"][@"cardDtail"];
            self.detailModel = [CardDetailModel mj_objectWithKeyValues:detailDic];
            [self.baseTableView reloadData];
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 83;
    } else if (indexPath.row == 1) {
        return 223;
    } else if (indexPath.row == 2) {
        return 204;
    } else {
        return 193;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [self homeCardCellWithTableView:tableView atIndexPath:indexPath];
    } else if (indexPath.row == 1) {
        return [self detailTwoCellWithTableView:tableView indexPath:indexPath];
    } else if (indexPath.row == 2) {
        return [self detailThreeCellWithTableView:tableView indexPath:indexPath];
    } else {
        return [self detailFourcellWithTableView:tableView indexPath:indexPath];
    }
}

- (HomeCardTableViewCell *)homeCardCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    HomeCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCardCellIdentifier forIndexPath:indexPath];
    cell.detailModel = self.detailModel;
    return cell;
}

- (DetailTwoCell *)detailTwoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:detailTwoCell forIndexPath:indexPath];
    cell.cardDetailModel = self.detailModel;
    return cell;
}

- (CardDetailThreeCell *)detailThreeCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    CardDetailThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:cardDetailThreeCell forIndexPath:indexPath];
    cell.cardDetailModel = self.detailModel;
    return cell;
}

- (CardDetailFourCell *)detailFourcellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    CardDetailFourCell *cell = [tableView dequeueReusableCellWithIdentifier:cardDetailFourCell forIndexPath:indexPath];
    cell.cardDetailModel = self.detailModel;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)collectButtonClick:(id)sender {
}
- (IBAction)applyButtonClick:(id)sender {
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
