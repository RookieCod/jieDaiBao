//
//  ZSNewsViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSNewsViewController.h"
#import "ZSCreditCardRequest.h"
#import "HomeCardModel.h"
#import "CardBankModel.h"
#import "HomeCardTableViewCell.h"
#import "ZSCardDetailViewController.h"

@interface ZSNewsViewController ()
<UITableViewDelegate,
UITableViewDataSource>
{
    NSInteger selected;
    CGFloat conditionViewHeight;
}
@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

/** bankName */
@property (nonatomic, strong) NSString *bankName;

/** bankModel */
@property (nonatomic, strong) NSArray *bankModelArray;

/** 筛选Array */
@property (nonatomic, strong) NSMutableArray *filterArray;

/** filterView */
@property (nonatomic, strong) UIView *filterView;

/** titleLabel */
@property (nonatomic, strong) UILabel *titleLabel;

/** filterImage */
@property (nonatomic, strong) UIImageView *filterImage;

/** conditionView */
@property (nonatomic, strong) UIView *conditionView;

@end

@implementation ZSNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    selected = 0;
    self.bankName = @"0";
    self.navigationItem.title = @"信用卡";
    if (self.pushType == CardListPushTypeFromHome) {
        self.navigationItem.leftBarButtonItem = [self backButtonBar];
    } else {
        self.navigationItem.leftBarButtonItem = nil;

    }

    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTableView.contentInset = UIEdgeInsetsMake(self.filterView.height + 5, 0, 0, 0);
    [self.baseTableView registerNib:[UINib nibWithNibName:@"HomeCardTableViewCell" bundle:nil]
             forCellReuseIdentifier:homeCardCellIdentifier];
    [self requestContent];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.conditionView.hidden = YES;
}

- (void)requestContent
{
    ZSCreditCardRequest *cardRequest = [[ZSCreditCardRequest alloc] initWithBank:self.bankName];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [cardRequest startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *responseDic = request.responseObject;
        if ([responseDic[@"code"] integerValue] == 00) {
            self.bankModelArray = [HomeCardModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"cardList"]];
            self.filterArray = (NSMutableArray *)[CardBankModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"cardBankList"]];
            [self.filterArray insertObject:@"全部银行" atIndex:0];
            [self createHeaderView];
            [self.baseTableView reloadData];
        }
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
}

- (void)createHeaderView
{
    
    //label
    [self.view addSubview:self.filterView];
    
    [self.filterView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.filterView.mas_centerX);
        make.top.bottom.equalTo(self.filterView);
    }];
    [self.filterView addSubview:self.filterImage];
    [self.filterImage setContentMode: UIViewContentModeScaleAspectFit];
    [self.filterImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.top.equalTo(self.filterView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
    [self.filterImage setImage:[UIImage imageNamed:@"shangbai"]];

    [self createSelectViewWithCondition:self.filterArray index:0];
}

- (UIView *)filterView
{
    if (!_filterView) {
        _filterView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, MAINWIDTH - 40, 30)];
        _filterView.backgroundColor = [UIColor colorWithHexString:@"B22614"];
        _filterView.layer.borderWidth = 1;
        _filterView.layer.borderColor = [UIColor colorWithHexString:@"B22614"].CGColor;
        _filterView.layer.cornerRadius = 5;
        _filterView.layer.masksToBounds = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            //根据点击筛选
            @strongify(self);
            if (selected == 0) {
                //需要展开
                [self reloadFilterViewSelected:1];
                self.conditionView.hidden = NO;
                [self.filterImage setImage:[UIImage imageNamed:@"xiabai"]];
                selected = 1;
            } else {
                [self reloadFilterViewSelected:0];
                self.conditionView.hidden = YES;
                [self.filterImage setImage:[UIImage imageNamed:@"shangbai"]];
                selected = 0;
            }
            
        }];
        [_filterView addGestureRecognizer:tap];
    }
    
    return _filterView;
}

- (void)createSelectViewWithCondition:(NSArray *)conditionArray index:(NSInteger)index
{
    [self.view addSubview:self.conditionView];
    for (UIView *subView in [self.conditionView subviews]) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
    CGFloat originY = 20;
    for (int i = 0; i < conditionArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100 + i;
        if (i == 0) {
            [button setTitle:conditionArray[i] forState:UIControlStateNormal];
        } else {
            CardBankModel *model = conditionArray[i];
            [button setTitle:[NSString stringWithFormat:@"%@",model.cardBank] forState:UIControlStateNormal];
        }
        
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [[[button rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
            UIButton *button = (UIButton *)x;
            NSInteger index = button.tag - 100;
            if (index == 0) {
                self.bankName = @"0";
                [self selectedChanged:0 title:@"全部银行"];
            } else {
                CardBankModel *bankModel = self.filterArray[index];
                self.bankName = bankModel.cardBank;
                [self selectedChanged:index title:bankModel.cardBank];
            }
            [self.filterImage setImage:[UIImage imageNamed:@"shangbai"]];
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

- (void)reloadFilterViewSelected:(NSInteger)selected
{
    self.filterView.backgroundColor = [UIColor colorWithHexString:@"B22614"];
    self.titleLabel.textColor = [UIColor whiteColor];
}

- (void)selectedChanged:(NSInteger)index title:(NSString *)title
{
//    if (index == 0) {
//        //全部银行
//        self.filterView.backgroundColor = [UIColor whiteColor];
//        self.titleLabel.textColor = [UIColor colorWithHexString:@"B22614"];
//        self.titleLabel.text = title;
//    } else {
//        
//    }
    self.filterView.backgroundColor = [UIColor colorWithHexString:@"B22614"];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = title;
    selected = 0;
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


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor  = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"全部银行";
    }
    return _titleLabel;
}

- (UIImageView *)filterImage
{
    if (!_filterImage) {
        _filterImage = [[UIImageView alloc] init];;
    }
    
    return _filterImage;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bankModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (UITableViewCell *)[self homeCardCellWithTableView:tableView atIndexPath:indexPath];
}

- (HomeCardTableViewCell *)homeCardCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath
{
    HomeCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCardCellIdentifier forIndexPath:indexPath];
    HomeCardModel *cardModel = self.bankModelArray[indexPath.row];
    cell.cardModel = cardModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZSCardDetailViewController *cardDetail = [[ZSCardDetailViewController alloc] init];
    HomeCardModel *cardModel = self.bankModelArray[indexPath.row];
    cardDetail.cardid = cardModel.cardId;

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cardDetail animated:YES];
    if (self.pushType == CardListPushTypeFromTab) {
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
