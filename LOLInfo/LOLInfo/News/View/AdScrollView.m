//
//  AdScrollView.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/28.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "AdScrollView.h"
#import "RecommModel.h"
#import "NSString+URLEncoding.h"
//匿名类别
@interface AdScrollView ()
//全局数组
@property (nonatomic,strong) NSArray *photoArr;
//当前页数
@property (nonatomic,assign) int page;//0 1 2 3
@end

@implementation AdScrollView

- (instancetype)initWithFrame:(CGRect)frame AndPicArr:(NSArray *)picArr{
    if (self = [super initWithFrame:frame]) {
        //转换为全局变量
        _photoArr = picArr;
        //当前控件宽高
        float width = self.bounds.size.width;
        float height = self.bounds.size.height;
        //滚动视图
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(width * picArr.count, height);
        //contentOffSet\contentInSet
        [self addSubview:_scrollView];
        
        for (int i = 0; i < picArr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width * i, 0, width, height)];
            //得到每张图片数据模型
            RecommModel *model = picArr[i];
            NSString *realUrl = [model.ban_img URLDecodedString];
            [imageView setImageWithURL:[NSURL URLWithString:realUrl] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];
            [_scrollView addSubview:imageView];
            
            //图片添加手势
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            //区分图片
            imageView.tag = 1000 + i;
            
            //标题
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(width * i, height - 30, width, 30)];
            label.text = model.name;
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:0.8];
            [_scrollView addSubview:label];
        }
        
        //分页控制器
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(width - 100, height - 30, 100, 30)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = picArr.count;
        [self addSubview:_pageControl];
        
        //定时器
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(timeRefresh) userInfo:nil repeats:YES];
        
    }
    return self;
}
//时间刷新
- (void)timeRefresh{
    _page++;//1 2 3(0)
    //临界值
    if (_page >= _photoArr.count) {
        _page = 0;//归零
    }
    //修改偏移量
//    _scrollView.contentOffset = CGPointMake(self.bounds.size.width * _page, 0);
    //3 1 2 3 1
    //具有动画效果
    [_scrollView scrollRectToVisible:CGRectMake(self.bounds.size.width * _page, 0, self.bounds.size.width, self.bounds.size.height) animated:YES];
    //分页控制器
    _pageControl.currentPage = _page;
}

- (void)tapImageView:(UITapGestureRecognizer*)tap{
    //跳转到详情界面
    //获取当前点击的视图
    UIImageView *tapImageView = (UIImageView*)tap.view;
    NSLog(@"%ld",tapImageView.tag - 1000);//0 1 2
    //取得对应图片数据模型
    RecommModel *model = _photoArr[tapImageView.tag - 1000];
    //反向传值新闻ID
    //调用
    _block(model.article_id);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
