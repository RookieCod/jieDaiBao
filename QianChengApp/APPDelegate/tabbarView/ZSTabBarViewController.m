//
//  ZSTabBarViewController.m
//  QianChengApp
//
//  Created by zhangsong on 2017/11/17.
//  Copyright © 2017年 zhangsong. All rights reserved.
//

#import "ZSTabBarViewController.h"
#import "ZSTabBarItem.h"
#import "ZSTabBarItemModel.h"

@interface ZSTabBarViewController ()
{
    NSInteger selectedIndex;
}
@property (strong, nonatomic) IBOutletCollection(ZSTabBarItem) NSArray *tabBarArray;

/** modelArray */
@property (nonatomic, strong) NSArray<ZSTabBarItemModel*> *defaultTabBarModelArray;

@end

@implementation ZSTabBarViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTabVC];
}

- (void)initTabVC
{
    //默认选中的tabItem
    selectedIndex = 1;
    
    //UIButton *button = (UIButton *)[self.view viewWithTag:selectedIndex];
    [self layoutTabBarItems];
    

}
- (IBAction)buttonAction:(id)sender {
    
    ZSTabBarItem *button = (ZSTabBarItem *)sender;
    
    if (selectedIndex != button.tag) {
        
        //本次选中的高亮
        [button setItemHighlighted:YES];
        
        // 设置上次选中button的normal image
        ZSTabBarItem *_btn = (ZSTabBarItem *)[self.view viewWithTag:selectedIndex];
        [_btn setItemHighlighted:NO];
        
        selectedIndex = (int)button.tag;
    }
}

- (void)setBarItemIndex:(NSInteger)index
{
    UIButton *btn = self.tabBarArray[index];
    [self buttonAction:btn];
}

-(void) layoutTabBarItems
{
    NSInteger index = 0;
    for (ZSTabBarItem *btn in self.tabBarArray) {
        
        if (index < self.tabBarArray.count) {
            [btn configWithItemModel:self.defaultTabBarModelArray[index]
                              status:(index == selectedIndex - 1)];
        }else
        {
            [btn configWithItemModel:self.defaultTabBarModelArray[index]
                              status:(index == selectedIndex - 1)];
        }
        index++;
    }
    
}


#pragma mark - properties
-(NSArray<ZSTabBarItemModel*> *)defaultTabBarModelArray
{
    
    if (!_defaultTabBarModelArray) {
        
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < 4; i++) {
            ZSTabBarItemModel *model = [[ZSTabBarItemModel alloc] init];
            model.title = tabBarNameArray[i];
            model.defaultIcon = [[UIImage imageNamed:[NSString stringWithFormat:@"tabDefaultIcon_%ld",(long)i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
            model.selectedIcon = [[UIImage imageNamed:[NSString stringWithFormat:@"tabSelectedIcon_%ld",(long)i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            
//            model.defaultColor = [UIColor blackColor];
//            model.selectedColor = [UIColor redColor];
            
            [mutableArray addObject:model];
        }
        
        _defaultTabBarModelArray = [mutableArray copy];
    }
    
    return _defaultTabBarModelArray;
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
