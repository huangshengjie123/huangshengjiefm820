//
//  HeroTableViewCell.m
//  LOLInfo
//
//  Created by 刘硕 on 16/6/28.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "HeroTableViewCell.h"

@implementation HeroTableViewCell

- (void)loadDataFromModel:(HeroModel *)model{
    //依次赋值
    _nameLabel.text = model.name_c;
    _realLabel.text = model.title;
    _tagLabel.text = model.tags;
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"default_hero_head"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
