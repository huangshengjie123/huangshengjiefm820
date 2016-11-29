//
//  BaseViewController.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsModel.h"
#import "HttpRequest.h"//网络请求类
#import "NewsTableViewCell.h"//自定义Cell
#import "DetailViewController.h"
#import "AdScrollView.h"
#import "RecommModel.h"
@interface BaseViewController ()

@property (nonatomic,strong) NSMutableArray *recommArr;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数据
    [self initData];
    //设置网址
    [self setMyUrl];
    //加载数据
    [self loadData];
    
    [self createTableView];
    // Do any additional setup after loading the view.
}
#pragma mark 初始化数据
- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    _page = 1;
    _recommArr = [[NSMutableArray alloc]init];
}
#pragma mark 设置网址
- (void)setMyUrl{
    self.url = [NSString stringWithFormat:kLatestNewsUrlString,self.page];
}
#pragma mark 加载数据
- (void)loadData{
    //网络层封装
    [HttpRequest startRequestWithURL:self.url AndParameter:nil AndReturnBlock:^(NSData *data, NSError *error) {
        if (!error) {
            //请求成功
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *reslutArr = dict[@"result"];
            //遍历得到每个字典
            for (NSDictionary *resultDict in reslutArr) {
                //字典转数据模型
                NewsModel *model = [[NewsModel alloc]init];
                //kvc
                [model setValuesForKeysWithDictionary:resultDict];
                //加入数据源中
                [_dataArr addObject:model];
            }
#pragma mark 轮播视图数据
            NSArray *recommArr = dict[@"recomm"];
            for (NSDictionary *recommDict in recommArr) {
                RecommModel *model = [[RecommModel alloc]init];
                [model setValuesForKeysWithDictionary:recommDict];//jsonmodel\yymodel
                [_recommArr addObject:model];
            }
            //创建广告视图
            AdScrollView *adScroll = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) AndPicArr:_recommArr];
            _tableView.tableHeaderView = adScroll;
            //接收传值
            [adScroll setBlock:^(NSString *news_ID) {
                //接收传值 并执行对应事项
                DetailViewController *detail = [[DetailViewController alloc]init];
                detail.news_id = news_ID;
                detail.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detail animated:YES];
            }];
            
            //刷新TableView
            [_tableView reloadData];
            //去除下拉刷新控件
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        } else {
            NSLog(@"%@",error);
            [_tableView.header endRefreshing];
            [_tableView.footer endRefreshing];
        }
    }];
}
#pragma mark 创建列表
- (void)createTableView{
    //取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //注册Cell
    [_tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"BASE"];
    //添加下拉刷新与上拉加载
    [self addDropDownRefresh];
    
    [self addDropUpRefresh];
}

- (void)addDropDownRefresh{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
       //下拉刷新操作
        _page = 1;//页数归一
        [_dataArr removeAllObjects];//清空数据源
        [_recommArr removeAllObjects];//同样清空轮播数组
        //重新网络请求
        [self setMyUrl];
        [self loadData];
    }];
    //设置动画效果(数组元素类型UIImage*)
    NSArray *imageArr = @[[UIImage imageNamed:@"loading_teemo_1"],[UIImage imageNamed:@"loading_teemo_2"]];
    [header setImages:imageArr forState:MJRefreshStateRefreshing];
    [header setImages:imageArr forState:MJRefreshStateIdle];
    [header setImages:imageArr forState:MJRefreshStatePulling];
    [header setTitle:@"敌军还有30秒到达战场~" forState:MJRefreshStateRefreshing];
    _tableView.header = header;
}

- (void)addDropUpRefresh{
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        //上拉刷新
        _page++;//页数不断增加
        //重新网络请求
        [self setMyUrl];
        [self loadData];
    }];
    NSArray *imageArr = @[[UIImage imageNamed:@"common_loading_anne_0"],[UIImage imageNamed:@"common_loading_anne_1"]];
    [footer setImages:imageArr forState:MJRefreshStateRefreshing];
    _tableView.footer = footer;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BASE" forIndexPath:indexPath];
    //预防下拉刷新崩溃操作
    if (_dataArr.count <= 0) {
        return cell;
    }
    //得到每行Cell的数据
    NewsModel *model = _dataArr[indexPath.row];
    //联系视图
    [cell loadDataFromModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //去除选中停留效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //跳转并传值
    DetailViewController *detail = [[DetailViewController alloc]init];
    NewsModel *model = _dataArr[indexPath.row];
    detail.news_id = model.ID;
    //隐藏下方标签栏
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
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
