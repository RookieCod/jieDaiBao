//
//  ZSDaiKuanListViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/23.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSDaiKuanListViewController.h"
#import "DaiKuanTableViewCell.h"

@interface ZSDaiKuanListViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

@end

@implementation ZSDaiKuanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"贷款";
    [self initHeaderView];
    
    [self.baseTableView registerNib:[UINib nibWithNibName:@"DaiKuanTableViewCell" bundle:nil] forCellReuseIdentifier:daiKuanCellIdentifier];
}

- (void)initHeaderView
{
    NSArray *segmentArray = [NSArray arrayWithObjects:@"热门",@"普通", nil];
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:segmentArray];
    segmented.selectedSegmentIndex = 0;
    [segmented setTintColor:[UIColor colorWithHexString:@"B22614"]];
    
    [self.view addSubview:segmented];
    
    //获取指定索引选项的图片imageForSegmentAtIndex：
    
    UIImageView *imageForSegmentAtIndex = [[UIImageView alloc]initWithImage:[segmented imageForSegmentAtIndex:1]];
    
    // 设置分段名的字体
    NSDictionary *dic = @{NSForegroundColorAttributeName : [UIColor blackColor],
                          NSFontAttributeName : [UIFont systemFontOfSize:14],
                          };
    [segmented setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    
    [segmented mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(74);
        make.height.mas_equalTo(@(40));
    }];
    
    
    [[[segmented rac_signalForControlEvents:UIControlEventValueChanged] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];
    
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
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
