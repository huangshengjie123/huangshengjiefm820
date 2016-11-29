//
//  NewsTableViewCell.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/27.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell
//视图联系数据
- (void)loadDataFromModel:(NewsModel *)model{
    //标题
    _titleLabel.text = model.title;
    //详情
    _infoLabel.text = model.shortStr;
    //图片
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
