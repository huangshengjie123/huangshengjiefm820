//
//  FindCollectionViewCell.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/30.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "FindCollectionViewCell.h"

@implementation FindCollectionViewCell

- (void)loadDataFromModel:(FindModel *)model{
    _iconImageView.layer.cornerRadius = 10;
    _iconImageView.clipsToBounds = YES;
    _ownerLabel.textColor = [UIColor whiteColor];
    _onlineLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:10];
    //图片
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.room_src] placeholderImage:[UIImage imageNamed:@"top_page_view_default"]];
    //标题
    _titleLabel.text = model.room_name;
    //房主
    _ownerLabel.text = model.nickname;
    //在线
    _onlineLabel.text = [NSString stringWithFormat:@"%d",model.online];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
