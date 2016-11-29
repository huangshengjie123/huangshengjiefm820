//
//  DetailViewController.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "DetailViewController.h"
#import "UMSocial.h"
@interface DetailViewController ()

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    //导航栏颜色
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    //导航栏控件颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createWebView];
    // Do any additional setup after loading the view.
}

- (void)createWebView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    //1、加载网址
    NSString *url = [NSString stringWithFormat:kNewsDetailUrlString,_news_id];
    //2、生成请求体
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //3、加载请求体
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    
    //分享按钮
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 40, 40);
    [shareBtn setImage:[UIImage imageNamed:@"share_normal"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
}

- (void)shareClick{
    //社会化分享（分享、登录）
    //前往对应平台下载对应SDK集成
    //友盟、ShareSDK
    /*
     1、从哪个视图控制器弹出
     2、网站所申请的appkey
     3、分享文字
     4、分享图片
     5、分享渠道（UMShareTo）
     6、代理，处理分享成功或失败的操作
     */
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"573ab64a67e58e3714001a41" shareText:@"我是卖报的小画家" shareImage:[UIImage imageNamed:@"loading_teemo_1"] shareToSnsNames:@[UMShareToSina,UMShareToRenren,UMShareToTencent] delegate:nil];
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
