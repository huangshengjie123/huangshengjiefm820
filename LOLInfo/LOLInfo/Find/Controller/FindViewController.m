//
//  FindViewController.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "FindViewController.h"
#import "FindCollectionViewCell.h"
#import "FindModel.h"
#import "MMProgressHUD.h"//MMDrawerController(侧滑抽屉)
#import "FindHeadView.h"
#import "PlayViewController.h"
@interface FindViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//收藏视图
@property (nonatomic,strong) UICollectionView *collectionView;
//数据源 大数组
@property (nonatomic,strong) NSMutableArray *dataArr;
//标题数组
@property (nonatomic,strong) NSMutableArray *titleArr;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createCollectionView];
    
    [self initData];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)initData{
    _dataArr = [[NSMutableArray alloc]init];
    _titleArr = [[NSMutableArray alloc]init];
}

- (void)loadData{
    //显示加载栏
    [MMProgressHUD showWithStatus:@"加载中..."];
    //更改样式
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleNone];
    
    [HttpRequest startRequestWithURL:MAIN_URL AndParameter:nil AndReturnBlock:^(NSData *data, NSError *error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *dataArr = dict[@"data"];
            NSLog(@"%@",dict);
            for (NSDictionary *dataDict in dataArr) {
                //存储标题文字
                [_titleArr addObject:dataDict[@"title"]];
                //组内行数组(小数组)
                NSArray *roomArr = dataDict[@"roomlist"];
                //建立小数据源
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *roomDict in roomArr) {
                    //建立数据模型存储数据
                    FindModel *model = [[FindModel alloc]init];
                    [model setValuesForKeysWithDictionary:roomDict];
                    //小数据源存储model
                    [array addObject:model];
                }
                //大数组存储小数组
                [_dataArr addObject:array];
            }
            //刷新CollectionView
            [_collectionView reloadData];
            //取消背景图片
            _collectionView.backgroundView = [[UIView alloc]init];
            //去除加载栏
            [MMProgressHUD dismissWithSuccess:@"加载成功"];
        } else {
            NSLog(@"%@",error);
            [MMProgressHUD dismissWithError:@"请求失败"];
        }
    }];
}

- (void)createCollectionView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 2, 150);
    //修改默认间隔
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:_collectionView.bounds];
    backImageView.image = [UIImage imageNamed:@"notice_pic_background_defualt"];
    _collectionView.backgroundView = backImageView;
    
    //注册自定义CollectionViewCell
    [_collectionView registerNib:[UINib nibWithNibName:@"FindCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FIND"];
    
    //注册自定义组头或组尾
    [_collectionView registerNib:[UINib nibWithNibName:@"FindHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEAD"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArr[section] count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FIND" forIndexPath:indexPath];
    //得到每个ITEM的数据
    FindModel *model = _dataArr[indexPath.section][indexPath.item];
    [cell loadDataFromModel:model];
    return cell;
}
//布局组头组尾方法
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //组头
        FindHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HEAD" forIndexPath:indexPath];
        //对组头数据进行赋值
        headView.titleLable.text = _titleArr[indexPath.section];
        return headView;
    } else {
        //组尾
        return [[UICollectionReusableView alloc]init];
    }
}
//组头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //collectionView多选（不会出现复用问题即可）
    //跳转播放界面
    PlayViewController *play = [[PlayViewController alloc]init];
    play.hidesBottomBarWhenPushed = YES;
    //传值
    FindModel *model = _dataArr[indexPath.section][indexPath.item];
    play.room_id = model.room_id;
    [self.navigationController pushViewController:play animated:YES];
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
