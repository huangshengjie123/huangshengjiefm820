//
//  SkillTableViewCell.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/29.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "SkillTableViewCell.h"

@interface SkillTableViewCell ()

@property (nonatomic,strong) NSArray *array;

@end

@implementation SkillTableViewCell

- (void)loadDataFromArr:(NSArray *)skillArr{
    //转换全局
    _array = skillArr;
    //技能图片
    _backView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < skillArr.count; i++) {
        //图片
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(60 * i, 0, 50, 50)];
        //取得每个技能字典
        NSDictionary *dict = skillArr[i];
        [imageView setImageWithURL:[NSURL URLWithString:dict[@"img"]] placeholderImage:[UIImage imageNamed:@"default_hero_head"]];
        [_backView addSubview:imageView];
        
        //用户交互
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        
        //为了区分添加Tag值
        imageView.tag = 800 + i;
        
        //快捷键
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60 * i, 50, 50, 10)];
        label.text = dict[@"key"];
        label.font = [UIFont boldSystemFontOfSize:10];
        label.textAlignment = NSTextAlignmentCenter;
        [_backView addSubview:label];
    }
    
    //默认显示第一个技能
    NSDictionary *dict = skillArr.firstObject;
    //名称
    _nameLabel.text = dict[@"name"];
    //描述
    _descLabel.text = dict[@"desc"];
    //cd
    _cdLabel.text = dict[@"cd"];
    //消耗
    _costLabel.text = dict[@"cost"];
    
}

- (void)tap:(UITapGestureRecognizer*)tap{
    UIImageView *tapImageView = (UIImageView*)tap.view;
    int index = (int)tapImageView.tag - 800;//0 1 2 3 4
    //去技能数组中取对应字典即可
    NSDictionary *dict = _array[index];
    //重新赋值
    //名称
    _nameLabel.text = dict[@"name"];
    //描述
    _descLabel.text = dict[@"desc"];
    //cd
    _cdLabel.text = dict[@"cd"];
    //消耗
    _costLabel.text = dict[@"cost"];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
