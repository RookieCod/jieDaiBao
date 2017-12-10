//
//  InfoDetailViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "InfoDetailRequest.h"
#import "InfoDetailModel.h"

@interface InfoDetailViewController ()
/** <#description#> */
@property (nonatomic, strong) UIScrollView *baseScrollView;

/*  */
@property (nonatomic, strong) InfoDetailModel *detailModel;

/* <##> */
@property (nonatomic, strong) UILabel *titleLabel;

/*  */
@property (nonatomic, strong) UILabel *sourceLabel;

/*  */
@property (nonatomic, strong) UILabel *timeLabel;

/*  */
@property (nonatomic, strong) UILabel *detaillabel;
@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"资讯详情";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];
    
    [self initView];
    [self requestContent];
}

- (void)initView
{
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@(MAINHEIGHT - 50));
    }];

    //标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.baseScrollView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.baseScrollView.mas_top).offset(15);
        make.height.mas_equalTo(@18);
    }];

    //来源
    self.sourceLabel = [[UILabel alloc] init];
    self.sourceLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];
    self.sourceLabel.font = [UIFont systemFontOfSize:12];
    [self.baseScrollView addSubview:self.sourceLabel];
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(80);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(@(120));
        make.height.mas_equalTo(@12);
    }];

    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.baseScrollView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sourceLabel.mas_right).offset(20);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-80);
        make.height.mas_equalTo(@12);
    }];

    //标题
    self.detaillabel = [[UILabel alloc] init];
    self.detaillabel.textColor = [UIColor colorWithHexString:@"4a4a4a"];
    self.detaillabel.font = [UIFont systemFontOfSize:14];
    self.detaillabel.numberOfLines = 0;
    [self.baseScrollView addSubview:self.detaillabel];
    [self.detaillabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.timeLabel.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];

    //底部收藏按钮
    UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.backgroundColor = [UIColor colorWithHexString:@"B22614"];
    collectButton.tintColor = [UIColor colorWithHexString:@"b22614"];
    [collectButton setImage:[UIImage imageNamed:@"collect_icon"] forState:UIControlStateNormal];
    [self.view addSubview:collectButton];
    [collectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseScrollView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(50));
    }];

}

- (void)requestContent
{
    InfoDetailRequest *request = [[InfoDetailRequest alloc] initWithInformationId:self.infoId];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary *dic = request.responseObject;
        MJExtensionLog(@"%@",request);

        if ([dic[@"code"] integerValue] == 00) {
            self.detailModel = [InfoDetailModel mj_objectWithKeyValues:dic[@"data"][@"informationDtail"]];
            [self reloadSubView];
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {

    }];
}

- (void)reloadSubView
{
    self.titleLabel.text = self.detailModel.informationName;
    self.sourceLabel.text = [NSString stringWithFormat:@"来源：%@",self.detailModel.customerAccount];
    self.timeLabel.text = self.detailModel.createTime;
    self.detaillabel.text = self.detailModel.informationContent;



    CGSize stringSize = [NSString getStringSize:self.detailModel.informationContent withFont:[UIFont systemFontOfSize:14] withWidth:(MAINWIDTH - 40)];
    if (stringSize.height < MAINHEIGHT - 75 - 64) {
        self.baseScrollView.contentSize = CGSizeMake(MAINWIDTH, MAINHEIGHT);
    } else {
        self.baseScrollView.contentSize = CGSizeMake(MAINWIDTH, stringSize.height + 75 + 64);
    }

}

- (UIScrollView *)baseScrollView
{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] init];
        _baseScrollView.backgroundColor = [UIColor clearColor];
        _baseScrollView.showsVerticalScrollIndicator = YES;
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _baseScrollView;
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
