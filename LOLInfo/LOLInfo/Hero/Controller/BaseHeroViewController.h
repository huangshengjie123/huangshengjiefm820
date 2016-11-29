//
//  BaseHeroViewController.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/28.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseHeroViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
//存储英雄分类的大数组
@property (nonatomic,strong) NSMutableArray *heroArr;
//存储标题数组
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,copy) NSString *url;
//所需外漏方法
- (void)setMyUrl;
- (void)loadData;

@end
