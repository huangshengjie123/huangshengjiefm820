//
//  MainTabBarViewController.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "NewsViewController.h"
#import "HeroViewController.h"
#import "FindViewController.h"
#import "MeViewController.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createController];
    
    self.selectedIndex = 2;//默认在发现界面
    // Do any additional setup after loading the view.
}
#pragma mark 创建标签栏控制器
- (void)createController{
    NewsViewController *news = [[NewsViewController alloc]init];
    HeroViewController *hero = [[HeroViewController alloc]init];
    FindViewController *find = [[FindViewController alloc]init];
    MeViewController *me = [[MeViewController alloc]init];
    //将视图控制器放置到可变数组中
    NSMutableArray *array = [NSMutableArray arrayWithObjects:news,hero,find,me, nil];
    //标题
    NSArray *titleArr = @[@"新闻",@"英雄",@"发现",@"我"];
    //图片
    NSArray *normalArr = @[@"tab_icon_news_normal",@"tab_icon_friend_normal",@"tab_icon_quiz_normal",@"tab_icon_more_normal"];
    
    NSArray *selectedArr = @[@"tab_icon_news_press",@"tab_icon_friend_press",@"tab_icon_quiz_press",@"tab_icon_more_press"];
    
    //循环创建
    for (int i = 0; i < titleArr.count; i++) {
        //1、依次得到每个视图控制器
        UIViewController *vc = array[i];
        //2、视图控制器－》导航控制器
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        //数组替换操作 nav替换掉原有vc
        [array replaceObjectAtIndex:i withObject:nav];
        //3、标题
        vc.title = titleArr[i];
        //4、图片
        //渲染模式 保证显示图片与给定图片保持一致
        UIImage *normalImage = [UIImage imageNamed:normalArr[i]];
        UIImage *selectImage = [UIImage imageNamed:selectedArr[i]];
        //普通状态
        vc.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //选中
        vc.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    self.viewControllers = array;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
