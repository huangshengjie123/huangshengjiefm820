//
//  HeroDetailViewController.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/29.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "HeroDetailViewController.h"
#import "SkillTableViewCell.h"
#import "StoryTableViewCell.h"
#import "UseTableViewCell.h"
#import "DetailModel.h"
#import "SqliteManager.h"//数据库封装类
@interface HeroDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UIView *line;
//用于标示当前点击button的索引
@property (nonatomic,assign) int index;
@end

@implementation HeroDetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    //设置导航栏背景图片
    /*
     1、图片信息[[UIImage alloc]init]表示透明图片
     2、设备朝向
     */
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    //去除阴影线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    //英雄是否购买判断
    SqliteManager *manager = [SqliteManager sharedSqliteManager];
    if ([manager isExistHeroWithHeroID:_heroID]) {
        self.navigationItem.rightBarButtonItem.title = @"已购买";
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //重置导航栏图片
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self createUI];
    //初始化
    [self initData];
    [self loadData];
}

- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
}

- (void)loadData{
    [HttpRequest startRequestWithURL:[NSString stringWithFormat:kHeroDetailInfoUrlString,_heroID] AndParameter:nil AndReturnBlock:^(NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *resultDict = dict[@"result"];
            //抽取数据
            DetailModel *model = [[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:resultDict];
            //数据源
            [_dataArr addObject:model];
            //头部视图赋值
            [_topImageView setImageWithURL:[NSURL URLWithString:model.img_top] placeholderImage:[UIImage imageNamed:@"heroDefaultBG"]];
            [_tableView reloadData];
        } else {
            NSLog(@"%@",error);
        }
    }];
}

- (void)createUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //加入Cell自适应额外设置
    _tableView.rowHeight = UITableViewAutomaticDimension;
    //预计的行高
    _tableView.estimatedRowHeight = 44.0;
    [self.view addSubview:_tableView];
    
    //去除多余行
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.separatorInset 调整线条位置
    
    //注册自定义Cell
    [_tableView registerNib:[UINib nibWithNibName:@"SkillTableViewCell" bundle:nil] forCellReuseIdentifier:@"Skill"];
    [_tableView registerNib:[UINib nibWithNibName:@"StoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"Story"];
    [_tableView registerNib:[UINib nibWithNibName:@"UseTableViewCell" bundle:nil] forCellReuseIdentifier:@"Use"];
    
    //contentInSet 额外的滑动区域 UIEdgInsets在原有坐标上进行调整位置
    //上 左 下 右
    _tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -150, SCREEN_WIDTH, 150)];
    _topImageView.image = [UIImage imageNamed:@"heroDefaultBG"];
    //无论如何缩放 始终保持原有显示比例
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    //去除超出原视图的部分
    _topImageView.clipsToBounds = YES;
    [_tableView addSubview:_topImageView];
    //分类
    [self createSwitchButton];
    //购买按钮
    [self createBuyButton];
}

- (void)createBuyButton{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"购买" style:UIBarButtonItemStylePlain target:self action:@selector(buyClick)];
}

- (void)buyClick{
    SqliteManager *manager = [SqliteManager sharedSqliteManager];
    
    BOOL isSuc = [manager insertHeroWithHeroID:_heroID];
    if (isSuc) {
        //购买－》已购买－》不可点击
        self.navigationItem.rightBarButtonItem.title = @"已购买";
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)createSwitchButton{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    backView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    _tableView.tableHeaderView = backView;
    
    NSArray *titleArr = @[@"英雄技能",@"背景故事",@"使用技巧"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(SCREEN_WIDTH / 3 * i, 0, SCREEN_WIDTH / 3, 48);
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 500 + i;//tag值
        [backView addSubview:button];
    }
    
    //线条
    _line = [[UIView alloc]initWithFrame:CGRectMake(0, 48, SCREEN_WIDTH / 3, 2)];
    _line.backgroundColor = [UIColor orangeColor];
    [backView addSubview:_line];
    
}

- (void)buttonClick:(UIButton*)button{
    //索引变化
    _index = (int)button.tag - 500;
    //刷新
    [_tableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        _line.frame = CGRectMake((button.tag - 500) * SCREEN_WIDTH / 3, 48, SCREEN_WIDTH / 3, 2);
    }];
}

//滚动既会调用的方法 上拉偏移量增加 下拉偏移量减小
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offSet = scrollView.contentOffset.y;
    //判断是否为下拉
    if (offSet < -150) {
        //下拉
        CGRect rect = _topImageView.frame;
        /*
         CGRect:CGPoint CGSize
         */
        //1、图片始终处于屏幕最上方（0 -150 SCREEN_WIDTH 150）
//        rect.origin.y = -150 - (-offSet - 150);
        rect.origin.y = offSet;
        //2、图片高度随下拉改变
//        rect.size.height = 150 + (-offSet - 150);
        rect.size.height = -offSet;
        //3、重置坐标
        _topImageView.frame = rect;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailModel *model = _dataArr[indexPath.row];
    if (_index == 0) {
        //技能
        SkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Skill" forIndexPath:indexPath];
        
        [cell loadDataFromArr:model.skill];
        
        return cell;
    } else if (_index == 1) {
        //故事
        StoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Story" forIndexPath:indexPath];
        
        cell.storyLabel.text = model.background;
        
        return cell;
    } else {
        //使用
        UseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Use" forIndexPath:indexPath];
        //去除选中效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userLabel.text = model.analyse;//使用技巧
        cell.gankLabel.text = model.talent_desc;//对线技巧
        
        return cell;
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
