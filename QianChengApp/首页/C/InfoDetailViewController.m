//
//  InfoDetailViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/12/1.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "InfoDetailViewController.h"

@interface InfoDetailViewController ()
/** <#description#> */
@property (nonatomic, strong) UIScrollView *baseScrollView;
@end

@implementation InfoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"资讯详情";
    self.navigationItem.leftBarButtonItem = [self backButtonBar];
    
    [self initView];
    
    CGSize textSize = [NSString getStringSize:self.infoDetail
                                        withFont:[UIFont systemFontOfSize:13]
                                       withWidth:MAINWIDTH - 40];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textColor = [UIColor colorWithHexString:@"232323"];
    textLabel.font = [UIFont systemFontOfSize:13];
    
    [self.baseScrollView addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseScrollView.mas_top);
        make.left.right.equalTo(self.baseScrollView);
        make.height.mas_equalTo(@(textSize.height));
    }];
    textLabel.text = self.infoDetail;
    
    self.baseScrollView.contentSize = CGSizeMake(MAINWIDTH, (textSize.height > MAINHEIGHT ? textSize.height : MAINHEIGHT));
}

- (void)initView
{
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(13);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (UIScrollView *)baseScrollView
{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] init];
        _baseScrollView.backgroundColor = [UIColor clearColor];
        
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
