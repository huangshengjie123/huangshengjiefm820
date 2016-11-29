//
//  BaseHeroViewController.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/28.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "BaseHeroViewController.h"
#import "HeroTableViewCell.h"
#import "HeroModel.h"
#import "PinYinForObjc.h"
#import "HeroDetailViewController.h"
@interface BaseHeroViewController ()

@property (nonatomic,strong) UIRefreshControl *refresh;

@end

@implementation BaseHeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self initData];
    //创建列表
    [self createTableView];
    //设置网址
    [self setMyUrl];
    //加载数据
    [self loadData];
    // Do any additional setup after loading the view.
}
//初始化
- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    
    _heroArr = [[NSMutableArray alloc]init];
    
    _titleArr = [[NSMutableArray alloc]init];
}

- (void)setMyUrl{
    self.url = kAllHeroUrlString;
}

- (void)loadData{
    [HttpRequest startRequestWithURL:self.url AndParameter:nil AndReturnBlock:^(NSData *data, NSError *error) {
        if (!error) {
            //解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *resultArr = dict[@"result"];
            for (NSDictionary *resultDict in resultArr) {
                //建立数据模型
                HeroModel *model = [[HeroModel alloc]init];
                [model setValuesForKeysWithDictionary:resultDict];
                [_dataArr addObject:model];
            }
            //中文转拼音
            [self chineseToPinYin];
            //刷新UI
            [_tableView reloadData];
            [_refresh endRefreshing];
        } else {
            NSLog(@"%@",error);
            [_refresh endRefreshing];
        }
    }];
}
#pragma mark 中文转拼音
- (void)chineseToPinYin{
    /*
     大数组套小数组
     (
      A(艾希、艾瑞莉娅),
      B(波比),
      ...
      Z(扎克)
     )
     */
    for (int i = 0; i < 26; i++) {
        NSMutableArray *array = [NSMutableArray array];
        [_heroArr addObject:array];
    }
    //对应首字母英雄放置到对应数组中
    //锤石－》C－》第三个小数组中，大数组中索引为2
    /*
     A,B....Z
     0,1....25
     */
    for (int i = 0; i < _dataArr.count; i++) {
        HeroModel *model = _dataArr[i];
        NSString *heroName = model.name_c;
        //中文－》拼音
        NSString *pinyinName = [PinYinForObjc chineseConvertToPinYinHead:heroName];
        char firstChar = [pinyinName characterAtIndex:0];
        int index = firstChar - 'a';//当前循环取得的英雄所需存在的索引
        [_heroArr[index] addObject:model];
    }
    //去除空数组
    [_heroArr removeObject:@[]];
    //组标题
    for (int i = 0; i < _heroArr.count; i++) {
        //取得每个小数组中的第一个英雄数据
        HeroModel *model = _heroArr[i][0];
        NSString *pinyin = [PinYinForObjc chineseConvertToPinYinHead:model.name_c];
        char firstChar = [pinyin characterAtIndex:0];
        [_titleArr addObject:[NSString stringWithFormat:@"%c",firstChar]];
    }
}

- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView                                = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64) style:UITableViewStylePlain];
    _tableView.delegate                       = self;
    _tableView.dataSource                     = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"HeroTableViewCell" bundle:nil] forCellReuseIdentifier:@"HERO"];
    
    //下拉刷新控件
    _refresh = [[UIRefreshControl alloc]init];
    _refresh.tintColor = [UIColor greenColor];
    [_refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:@"下拉刷新"]];
    [_refresh addTarget:self action:@selector(dataRefresh) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refresh];
    
    [_refresh beginRefreshing];
}

- (void)dataRefresh{
    [_refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:@"刷新中"]];
    [_dataArr removeAllObjects];
    [_heroArr removeAllObjects];
    [_titleArr removeAllObjects];
    [self setMyUrl];
    [self loadData];
}
//返回列表组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _heroArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_heroArr[section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeroTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HERO" forIndexPath:indexPath];
    //显示内容
    HeroModel *model = _heroArr[indexPath.section][indexPath.row];
    [cell loadDataFromModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _titleArr[section];
}

//索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _titleArr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HeroDetailViewController *detail = [[HeroDetailViewController alloc]init];
    detail.hidesBottomBarWhenPushed = YES;
    //正向传值
    HeroModel *model = _heroArr[indexPath.section][indexPath.row];
    detail.heroID = model.ID;
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
