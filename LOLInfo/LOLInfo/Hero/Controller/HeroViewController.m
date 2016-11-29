//
//  HeroViewController.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "HeroViewController.h"
#import "FreeViewController.h"
#import "AllViewController.h"
@interface HeroViewController ()

@property (nonatomic,strong) FreeViewController *freeVC;
@property (nonatomic,strong) AllViewController *allVC;

@end

@implementation HeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    // Do any additional setup after loading the view.
}
#pragma mark 搭建UI
- (void)createUI{
    //分段选择器
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"周免",@"全部"]];
    seg.frame = CGRectMake(0, 0, 200, 30);
    [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    //默认选中
    seg.selectedSegmentIndex = 0;
    //放置导航栏上
    self.navigationItem.titleView = seg;
    
    //取消自适应
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //分别将周免、全部视图放置到该视图控制器上
    _freeVC = [[FreeViewController alloc]init];
    [self.view addSubview:_freeVC.view];
    
    _allVC = [[AllViewController alloc]init];
    [self.view addSubview:_allVC.view];
    
    //将周免、全部视图控制器做为当前视图控制器的子视图控制器（英雄界面是默认可以跳转到周免和全部的）
    [self addChildViewController:_freeVC];
    [self addChildViewController:_allVC];
    
    //修改层次关系
    [self.view bringSubviewToFront:_freeVC.view];
}

- (void)segChange:(UISegmentedControl*)seg{
    if (seg.selectedSegmentIndex == 0) {
        [self.view bringSubviewToFront:_freeVC.view];
    } else {
        [self.view bringSubviewToFront:_allVC.view];
        
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
