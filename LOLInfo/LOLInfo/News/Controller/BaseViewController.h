//
//  BaseViewController.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
//列表
@property (nonatomic,strong) UITableView *tableView;
//数据源
@property (nonatomic,strong) NSMutableArray *dataArr;
//网址
@property (nonatomic,copy) NSString *url;
//控制网址页数
@property (nonatomic,assign) int page;
//外漏设置网址的方法 以便于子类继承
- (void)setMyUrl;
//加载数据
- (void)loadData;

@end




