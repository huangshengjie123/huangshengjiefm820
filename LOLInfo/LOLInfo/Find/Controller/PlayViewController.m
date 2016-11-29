//
//  PlayViewController.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/30.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "PlayViewController.h"
#import "CocoaSecurity.h"
#import <AVFoundation/AVFoundation.h>//audio video
@interface PlayViewController ()
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenButton;
- (IBAction)fullScreenClick:(UIButton *)sender;

//播放器
@property (nonatomic,strong) AVPlayer *player;
//播放层
@property (nonatomic,strong) AVPlayerLayer *playerLayer;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (NSString *)getAuthUrlWith:(NSString *)roomId {
    //当前时间距离1970 1 1 秒数
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString * roomStr = [NSString stringWithFormat:@"room/%@?aid=android&clientsys=android&time=%ld1231", roomId, (NSInteger)time];
    //MD5加密
    CocoaSecurityResult * res = [CocoaSecurity md5:roomStr];
    return [NSString stringWithFormat:URLSTRING_Room, roomId, (NSInteger)time, res.hexLower];
}


- (void)loadData{
    NSLog(@"%@",[self getAuthUrlWith:_room_id]);
    
    [HttpRequest startRequestWithURL:[self getAuthUrlWith:_room_id] AndParameter:nil AndReturnBlock:^(NSData *data, NSError *error) {
        if (!error) {
            
            //将播放网址解析
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDict = dict[@"data"];
            NSLog(@"%@",dataDict);
            
            NSString *playUrl = dataDict[@"hls_url"];
            //创建播放器
            [self createPlayerWithURL:playUrl];
            
        } else {
            NSLog(@"%@",error);
        }
    }];
}

- (void)createPlayerWithURL:(NSString *)url{
    //创建播放器
    _player = [AVPlayer playerWithURL:[NSURL URLWithString:url]];
    //播放层关联播放器
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //坐标
    _playerLayer.frame = _playView.bounds;
    //设置播放效果（类似于UIView contentMode(停靠模式)）
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //将播放层放置到视图上
    [_playView.layer insertSublayer:_playerLayer atIndex:0];
    //添加监听 监听底部视图坐标变化 从而更新播放层坐标
    [_playView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
    
    //播放器播放
    [_player play];
}

//实现监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //对象－》结构体
    CGRect rect = [change[@"new"] CGRectValue];
    //重置播放层坐标即可
    _playerLayer.frame = rect;
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
//手动更改屏幕朝向
- (IBAction)fullScreenClick:(UIButton *)sender {
    [[UIDevice currentDevice]setValue:@(UIDeviceOrientationLandscapeLeft) forKey:@"orientation"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //不透明
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //屏幕回归竖屏
    [[UIDevice currentDevice]setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    
    //移除监听
    [self.playView removeObserver:self forKeyPath:@"bounds"];
}

- (void)dealloc{
    //播放器滞空 退出之后视频仍在播
    _player = nil;
    //移除监听
//    [_playView removeObserver:self forKeyPath:@"bounds"];
}
@end




