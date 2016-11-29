//
//  HeroTableViewCell.h
//  LOLInfo
//
//  Created by 刘硕 on 16/6/28.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeroModel.h"
@interface HeroTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *realLabel;

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

- (void)loadDataFromModel:(HeroModel*)model;

@end
